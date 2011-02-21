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
$Id: RedirectCommand.cfc 2669 2011-02-16 21:06:32Z jason_york $

Created version: 1.1.0
Updated version: 1.8.0

Notes:
--->
<cfcomponent
	displayname="RedirectCommand"
	extends="MachII.framework.Command"
	output="false"
	hint="An Command for redirecting.">

	<!---
	PROPERTIES
	--->
	<cfset variables.commandType = "redirect" />
	<cfset variables.eventName = "" />
	<cfset variables.eventParameter = "" />
	<cfset variables.redirectPersistParameter = "" />
	<cfset variables.moduleName = "" />
	<cfset variables.url = "" />
	<cfset variables.args = "" />
	<cfset variables.persist = "" />
	<cfset variables.persistArgs = "" />
	<cfset variables.persistArgsIgnore = "" />
	<cfset variables.statusType = "" />
	<cfset variables.routeName = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="RedirectCommand" output="false"
		hint="Used by the framework for initialization.">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false" default="" />
		<cfargument name="url" type="string" required="false" default="" />
		<cfargument name="args" type="string" required="false" default="" />
		<cfargument name="persist" type="boolean" required="false" default="false" />
		<cfargument name="persistArgs" type="string" required="false" default="" />
		<cfargument name="statusType" type="string" required="false" default="temporary" />
		<cfargument name="persistArgsIgnore" type="string" required="false" default="" />
		<cfargument name="routeName" type="string" required="false" default="" />

		<cfset setEventName(arguments.eventName) />
		<cfset setModuleName(arguments.moduleName) />
		<cfset setUrl(arguments.url) />
		<cfset setArgs(arguments.args) />
		<cfset setPersist(arguments.persist) />
		<cfset setPersistArgs(arguments.persistArgs) />
		<cfset setStatusType(arguments.statusType) />
		<cfset setPersistArgsIgnore(arguments.persistArgsIgnore) />
		<cfset setRouteName(arguments.routeName) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="false"
		hint="Executes the command.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var redirectUrl = "" />
		<cfset var log = getLog() />

		<!--- Clear the event queue since we do not want to Application.cfc/cfm error
			handling to catch a cfabort --->
		<cfset arguments.eventContext.clearEventQueue() />

		<!--- Make the redirect --->
		<cfset makeRedirect(arguments.event, arguments.eventContext) />

		<!--- Return false to stop the processeing of any remaning commands.
			Since we have cleared the event queue, the request will stop
			gracefully. Otherwise, the onError()/cferror handlers we be called
			thus causing potential problems. --->
		<cfreturn false />
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="makeRedirect" access="private" returntype="void" output="false"
		hint="Redirects the request to the built route/event url.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var redirectUrl = "" />
		<cfset var params = StructNew() />
		<cfset var args = getArgs() />
		<cfset var persistArgs = StructNew() />
		<cfset var i = "" />
		<cfset var element = "" />
		<cfset var arg = "" />
		<cfset var evaluatedUrl = getUrl() />
		<cfset var evaluatedEventName = getEventName() />
		<cfset var evaluatedModuleName =  getModuleName() />
		<cfset var evaluatedRouteName = getRouteName() />
		<cfset var propertyManager = arguments.eventContext.getAppManager().getPropertyManager() />
		<cfset var expressionEvaluator = getExpressionEvaluator() />

		<!--- Grab the UrlBase if no URL is specified --->
		<cfif NOT Len(evaluatedUrl)>
			<cfset evaluatedUrl = propertyManager.getProperty("urlBase") />
		</cfif>

		<cfif Len(evaluatedRouteName) AND expressionEvaluator.isExpression(evaluatedRouteName)>
			<cfset evaluatedRouteName = expressionEvaluator.evaluateExpression(evaluatedRouteName,
				arguments.event, propertyManager) />
		</cfif>

		<!--- Persist if directed --->
		<cfif getPersist()>
			<cfset persistArgs = buildPersistEventData(arguments.event, arguments.eventContext) />
		</cfif>

		<!--- Build params which can have notation like args="id=${event.product_id},type=print"  --->
		<cfloop list="#args#" index="i" delimiters=",">
			<cfif ListLen(i, "=") eq 2>
				<cfset element = ListGetAt(i, 2, "=") />
				<cfset i = ListGetAt(i, 1, "=") />
				<cfif expressionEvaluator.isExpression(element)>
					<cfset arg = expressionEvaluator.evaluateExpression(element, arguments.event, propertyManager) />
				<cfelse>
					<cfset arg = element />
				</cfif>
			<cfelse>
				<cfif expressionEvaluator.isExpression(i)>
					<cfset arg = expressionEvaluator.evaluateExpression(i, arguments.event, propertyManager) />
					<cfset i = ListLast(ListFirst(REReplaceNoCase(i, "^\${(.*)}$", "\1", "all"), ":"), ".") />
				<cfelse>
					<cfset arg = arguments.event.getArg(i, "") />
				</cfif>
			</cfif>

			<cfif IsSimpleValue(arg)>
				<cfset params[i] = arg />
			</cfif>
		</cfloop>

		<cfif Len(evaluatedUrl) AND expressionEvaluator.isExpression(evaluatedUrl)>
			<cfset evaluatedUrl = expressionEvaluator.evaluateExpression(evaluatedUrl, arguments.event, propertyManager) />
		</cfif>

		<!--- Support redirect urls using a url route --->
		<cfif Len(evaluatedRouteName)>
			<cfset getLog().info("Redirecting to route '#evaluatedRouteName#' with '#statusType#' status code (persist='#getPersist()#').") />

			<cfset arguments.eventContext.getAppManager().getRequestManager().getRequestHandler().getEventContext().redirectRoute(
					evaluatedRouteName
					, params
					, getPersist()
					, persistArgs
					, getStatusType()
					, evaluatedUrl) />
		<cfelse>
			<cfif Len(evaluatedEventName) AND expressionEvaluator.isExpression(evaluatedEventName)>
				<cfset evaluatedEventName = expressionEvaluator.evaluateExpression(evaluatedEventName, arguments.event, propertyManager) />
			</cfif>
			<cfif Len(evaluatedModuleName) AND expressionEvaluator.isExpression(evaluatedModuleName)>
				<cfset evaluatedModuleName = expressionEvaluator.evaluateExpression(evaluatedModuleName, arguments.event, propertyManager) />
			</cfif>

			<cfset getLog().info("Redirecting to event '#evaluatedEventName#' in module '#evaluatedModuleName#' with '#statusType#' status code (persist='#getPersist()#').") />

			<cfset arguments.eventContext.getAppManager().getRequestManager().getRequestHandler().getEventContext().redirectEvent(
					evaluatedEventName
					, params
					, evaluatedModuleName
					, getPersist()
					, persistArgs
					, getStatusType()
					, evaluatedUrl) />
		</cfif>
	</cffunction>

	<cffunction name="buildPersistEventData" access="private" returntype="struct" output="false"
		hint="Saves persisted event data and returns the persistId.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var args = StructNew() />
		<cfset var persistArgs = getPersistArgs() />
		<cfset var persistArgsIgnore = getPersistArgsIgnore() />
		<cfset var persistId = "" />
		<cfset var i = "" />
		<cfset var element = "" />
		<cfset var arg = "" />
		<cfset var propertyManager = arguments.eventContext.getAppManager().getPropertyManager() />
		<cfset var expressionEvaluator = getExpressionEvaluator() />

		<!--- Build params --->
		<cfif NOT ListLen(persistArgs)>
			<cfset args = arguments.event.getArgs() />
			<!--- Remove the persist args to ignore --->
			<cfloop list="#persistArgsIgnore#" index="i" delimiters=",">
				<cfset StructDelete(args, i, FALSE) />
			</cfloop>
		<cfelse>
			<cfloop list="#persistArgs#" index="i" delimiters=",">
				<cfif ListLen(i, "=") eq 2>
					<cfset element = ListGetAt(i, 2, "=") />
					<cfset i = ListGetAt(i, 1, "=") />
					<cfif expressionEvaluator.isExpression(element)>
						<cfset arg = expressionEvaluator.evaluateExpression(element, arguments.event, propertyManager) />
					<cfelse>
						<cfset arg = element />
					</cfif>
					<cfset args[i] = arg />
				<cfelse>
					<cfif expressionEvaluator.isExpression(i)>
						<cfset args[i] = expressionEvaluator.evaluateExpression(i, arguments.event, propertyManager) />
					<cfelseif arguments.event.isArgDefined(i)>
						<cfset args[i] = arguments.event.getArg(i, "") />
					</cfif>
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn args />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setEventName" access="private" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset variables.eventName = arguments.eventName />
	</cffunction>
	<cffunction name="getEventName" access="private" returntype="string" output="false">
		<cfreturn variables.eventName />
	</cffunction>

	<cffunction name="setRouteName" access="private" returntype="void" output="false">
		<cfargument name="routeName" type="string" required="true" />
		<cfset variables.routeName = arguments.routeName />
	</cffunction>
	<cffunction name="getRouteName" access="private" returntype="string" output="false">
		<cfreturn variables.routeName />
	</cffunction>

	<cffunction name="setModuleName" access="private" returntype="void" output="false">
		<cfargument name="moduleName" type="string" required="true" />
		<cfset variables.moduleName = arguments.moduleName />
	</cffunction>
	<cffunction name="getModuleName" access="private" returntype="string" output="false">
		<cfreturn variables.moduleName />
	</cffunction>

	<cffunction name="setUrl" access="private" returntype="void" output="false">
		<cfargument name="url" type="string" required="true" />
		<cfset variables.url = arguments.url />
	</cffunction>
	<cffunction name="getUrl" access="private" returntype="string" output="false">
		<cfreturn variables.url />
	</cffunction>

	<cffunction name="setArgs" access="private" returntype="void" output="false">
		<cfargument name="args" type="string" required="true" />
		<cfset variables.args = arguments.args />
	</cffunction>
	<cffunction name="getArgs" access="private" returntype="string" output="false">
		<cfreturn variables.args />
	</cffunction>

	<cffunction name="setPersist" access="private" returntype="void" output="false">
		<cfargument name="persist" type="boolean" required="true" />
		<cfset variables.persist = arguments.persist />
	</cffunction>
	<cffunction name="getPersist" access="private" returntype="boolean" output="false">
		<cfreturn variables.persist />
	</cffunction>

	<cffunction name="setPersistArgs" access="private" returntype="void" output="false">
		<cfargument name="persistArgs" type="string" required="true" />
		<cfset variables.persistArgs = arguments.persistArgs />
	</cffunction>
	<cffunction name="getPersistArgs" access="private" returntype="string" output="false">
		<cfreturn variables.persistArgs />
	</cffunction>

	<cffunction name="setPersistArgsIgnore" access="private" returntype="void" output="false">
		<cfargument name="persistArgsIgnore" type="string" required="true" />
		<cfset variables.persistArgsIgnore = arguments.persistArgsIgnore />
	</cffunction>
	<cffunction name="getPersistArgsIgnore" access="private" returntype="string" output="false">
		<cfreturn variables.persistArgsIgnore />
	</cffunction>

	<cffunction name="setStatusType" access="private" returntype="void" output="false">
		<cfargument name="statusType" type="string" required="true" />
		<cfset variables.statusType = arguments.statusType />
	</cffunction>
	<cffunction name="getStatusType" access="private" returntype="string" output="false">
		<cfreturn variables.statusType />
	</cffunction>

</cfcomponent>