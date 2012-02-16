<!---

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2010 GreatBizTools, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	As a special exception, the copyright holders of this library give you
	permission to link this library with independent modules to produce an
	executable, regardless of the license terms of these independent
	modules, and to copy and distribute the resultant executable under
	the terms of your choice, provided that you also meet, for each linked
	independent module, the terms and conditions of the license of that
	module.  An independent module is a module which is not derived from
	or based on this library and communicates with Mach-II solely through
	the public interfaces* (see definition below). If you modify this library,
	but you may extend this exception to your version of the library,
	but you are not obligated to do so. If you do not wish to do so,
	delete this exception statement from your version.


	* An independent module is a module which not derived from or based on
	this library with the exception of independent module components that
	extend certain Mach-II public interfaces (see README for list of public
	interfaces).

Author: Ben Edwards (ben@ben-edwards.com)
$Id: FilterCommand.cfc 2827 2011-07-15 03:58:14Z peterjfarrell $

Created version: 1.0.0
Updated version: 1.8.0

Notes:
--->
<cfcomponent
	displayname="FilterCommand"
	extends="MachII.framework.Command"
	output="false"
	hint="A Command for processing an EventFilter.">

	<!---
	PROPERTIES
	--->
	<cfset variables.commandType = "filter" />
	<cfset variables.filterProxy = "" />
	<cfset variables.paramArgs = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="FilterCommand" output="false"
		hint="Used by the framework for initialization.">
		<cfargument name="filterProxy" type="MachII.framework.BaseProxy" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="parseRuntimeParameters" type="boolean" required="false" default="false" />

		<cfset setFilterProxy(arguments.filterProxy) />
		<cfset setParamArgs(arguments.paramArgs) />
		<cfset setParseRuntimeParameters(arguments.parseRuntimeParameters) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="true"
		hint="Executes the command.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var continue = false />
		<cfset var filter = getFilterProxy().getObject() />
		<cfset var log = filter.getLog() />
		<cfset var paramArgs = getParamArgs() />

		<cfif StructCount(paramArgs)>
			<!--- Resolve runtime parameters for M2EL syntax if defined --->
			<cfif getParseRuntimeParameters()>
				<cftry>
					<cfset paramArgs = resolveExpressions(paramArgs, arguments.event, arguments.eventContext) />
					<cfcatch type="any">
						<cfif log.isErrorEnabled()>
							<cfset log.error("Event-filter '#filter.getComponentNameForLogging()#' has caused an exception. Unable to properly resolve the runtime parameters for M2EL syntax."
									& filter.getUtils().buildMessageFromCfCatch(cfcatch, getMetadata(filter).path)
									, cfcatch) />
						</cfif>
						<cfrethrow />
					</cfcatch>				
				</cftry>
			</cfif>

			<cfset log.debug("Filter '#filter.getComponentNameForLogging()#' beginning execution with runtime paramArgs. (Parsed for M2EL: '#getParseRuntimeParameters()#')", paramArgs) />
		<cfelse>
			<cfset log.debug("Filter '#filter.getComponentNameForLogging()#' beginning execution with no runtime paramArgs.") />
		</cfif>

		<cftry>			
			<cfsetting enablecfoutputonly="false" /><cfinvoke component="#filter#" method="filterEvent" returnVariable="continue">
				<cfinvokeargument name="event" value="#arguments.event#" />
				<cfinvokeargument name="eventContext" value="#arguments.eventContext#" />
				<cfinvokeargument name="paramArgs" value="#paramArgs#" />
			</cfinvoke><cfsetting enablecfoutputonly="true" />
			<cfcatch type="any">
				<cfif log.isErrorEnabled()>
					<cfset log.error("Event-filter '#filter.getComponentNameForLogging()#' has caused an exception."
							& filter.getUtils().buildMessageFromCfCatch(cfcatch, getMetadata(filter).path)
							, cfcatch) />
				</cfif>
				<cfrethrow />
			</cfcatch>
		</cftry>

		<cfif NOT continue>
			<cfset log.info("Filter '#filter.getComponentNameForLogging()# has changed the flow of this event.") />
		</cfif>

		<cfreturn continue />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setFilterProxy" access="private" returntype="void" output="false">
		<cfargument name="filterProxy" type="MachII.framework.BaseProxy" required="true" />
		<cfset variables.filterProxy = arguments.filterProxy />
	</cffunction>
	<cffunction name="getFilterProxy" access="private" returntype="MachII.framework.BaseProxy" output="false">
		<cfreturn variables.filterProxy />
	</cffunction>

	<cffunction name="setParamArgs" access="private" returntype="void" output="false">
		<cfargument name="paramArgs" type="struct" required="true" />
		<cfset variables.paramArgs = arguments.paramArgs />
	</cffunction>
	<cffunction name="getParamArgs" access="private" returntype="struct" output="false">
		<cfreturn variables.paramArgs />
	</cffunction>
	
	<cffunction name="setParseRuntimeParameters" access="private" returntype="void" output="false"
		hint="Sets if the runtime parameters should be parsed because it contains M2EL syntax.">
		<cfargument name="parseRuntimeParameters" type="boolean" required="true" />
		<cfset variables.parseRuntimeParameters = arguments.parseRuntimeParameters />
	</cffunction>
	<cffunction name="getParseRuntimeParameters" access="private" returntype="boolean" output="false"
		hint="Gets if the runtime parameters should be parsed because it contains M2EL syntax.">
		<cfreturn variables.parseRuntimeParameters />
	</cffunction>

</cfcomponent>