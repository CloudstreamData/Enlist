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
$Id: Command.cfc 2827 2011-07-15 03:58:14Z peterjfarrell $

Created version: 1.0.0
Updated version: 1.8.0

Notes:
--->
<cfcomponent
	displayname="Command"
	output="false"
	hint="Base Command component.">

	<!---
	PROPERTIES
	--->
	<cfset variables.commandType = "undefined" />
	<cfset variables.parameters = StructNew() />
	<cfset variables.log = "" />
	<cfset variables.expressionEvaluator = "" />
	<cfset variables.utils = "" />
	<cfset variables.parentHandlerType = "" />
	<cfset variables.parentHandlerName = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Command" output="false"
		hint="Used by the framework for initialization.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="true"
		hint="Overridden by the command that extends this component.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var log = getLog() />

		<cfif log.isInfoEnabled()>
			<cfset log.info("Executing a default command named '#getParameter("commandName")#' in #getParentHandlerType()# named '#getParentHandlerName()#' in module '#arguments.eventContext.getAppManager().getModuleName()#'. This is not a concrete command. Check your configuration file.") />
		</cfif>

		<cfreturn true />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS - UTIL
	--->
	<cffunction name="setParameters" access="public" returntype="void" output="false"
		hint="Sets a struct of parameters to this command.">
		<cfargument name="parameters" type="struct" required="true" />

		<cfset var key = "" />

		<cfloop collection="#arguments.parameters#" item="key">
			<cfset setParameter(key, parameters[key]) />
		</cfloop>
	</cffunction>
	
	<cffunction name="resolveExpressions" access="public" returntype="any" output="false"
		hint="Resolves M2EL a struct of parameters.">
		<cfargument name="expressions" type="any" required="true" />
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var resolvedExpressions = StructNew() />
		
		<cfif IsSimpleValue(arguments.expressions)>
			<cfreturn recurseResolveExpressions(arguments.expressions, arguments.event, arguments.eventContext.getAppManager().getPropertyManager(), getExpressionEvaluator()) />
		<cfelse>
			<!--- Append the current parameters to the resolved version so the original values are not corrupted --->
			<cfset StructAppend(resolvedExpressions, arguments.expressions) />
		
			<cfreturn recurseResolveExpressions(resolvedExpressions, arguments.event, arguments.eventContext.getAppManager().getPropertyManager(), getExpressionEvaluator()) />
		</cfif>
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="recurseResolveExpressions" access="private" returntype="any" output="false"
		hint="Recurses through an incoming parameters for resolution.">
		<cfargument name="node" type="any" required="true" />
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="propertyManager" type="MachII.framework.PropertyManager" required="true" />
		<cfargument name="expressionEvaluator" type="MachII.util.ExpressionEvaluator" required="true" />
	
		<cfset var value = "" />
		<cfset var i = "" />
		
		<cfif IsSimpleValue(arguments.node)>
			<cfif arguments.expressionEvaluator.isExpression(arguments.node)>
				<cfset value = arguments.expressionEvaluator.evaluateExpression(arguments.node, arguments.event, arguments.propertyManager) />
			<cfelse>
				<cfset value  = arguments.node />
			</cfif>
		<cfelseif IsStruct(arguments.node)>
			<cfset value = StructNew() />
			<cfloop collection="#arguments.node#" item="i">
				<cfset value[i] = recurseResolveExpressions(arguments.node[i], arguments.event, arguments.propertyManager, arguments.expressionEvaluator) />
			</cfloop>
		<cfelseif IsArray(arguments.node)>
			<cfset value = ArrayNew(1) />
			<cfloop from="1" to="#ArrayLen(arguments.node)#" index="i">
				<cfset value[i] = recurseResolveExpressions(arguments.node[i], arguments.event, arguments.propertyManager, arguments.expressionEvaluator) />
			</cfloop>
		<cfelse>
			<cfset value = arguments.node />
		</cfif>
		
		<cfreturn value />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="getCommandType" access="public" returntype="string" output="false">
		<cfreturn variables.commandType />
	</cffunction>

	<cffunction name="setParameter" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfset variables.parameters[arguments.name] = arguments.value />
	</cffunction>
	<cffunction name="getParameter" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfreturn variables.parameters[arguments.name] />
	</cffunction>

	<cffunction name="setLog" access="public" returntype="void" output="false"
		hint="Set the log.">
		<cfargument name="log" type="MachII.logging.Log" required="true" />
		<cfset variables.log = arguments.log />
	</cffunction>
	<cffunction name="getLog" access="public" returntype="MachII.logging.Log" output="false"
		hint="Gets the log.">
		<cfreturn variables.log />
	</cffunction>

	<cffunction name="setExpressionEvaluator" access="public" returntype="void" output="false">
		<cfargument name="expressionEvaluator" type="MachII.util.ExpressionEvaluator" required="true" />
		<cfset variables.expressionEvaluator = arguments.expressionEvaluator />
	</cffunction>
	<cffunction name="getExpressionEvaluator" access="public" returntype="MachII.util.ExpressionEvaluator" output="false">
		<cfreturn variables.expressionEvaluator />
	</cffunction>

	<cffunction name="setUtils" access="public" returntype="void" output="false">
		<cfargument name="utils" type="MachII.util.Utils" required="true" />
		<cfset variables.utils = arguments.utils />
	</cffunction>
	<cffunction name="getUtils" access="public" returntype="MachII.util.Utils" output="false">
		<cfreturn variables.utils />
	</cffunction>

	<cffunction name="setParentHandlerType" access="public" returntype="void" output="false">
		<cfargument name="parentHandlerType" type="string" required="true" />
		<cfset variables.parentHandlerType = arguments.parentHandlerType />
	</cffunction>
	<cffunction name="getParentHandlerType" access="public" returntype="string" output="false">
		<cfreturn variables.parentHandlerType />
	</cffunction>
	<cffunction name="setParentHandlerName" access="public" returntype="void" output="false">
		<cfargument name="parentHandlerName" type="string" required="true" />
		<cfset variables.parentHandlerName = arguments.parentHandlerName />
	</cffunction>
	<cffunction name="getParentHandlerName" access="public" returntype="string" output="false">
		<cfreturn variables.parentHandlerName />
	</cffunction>

</cfcomponent>