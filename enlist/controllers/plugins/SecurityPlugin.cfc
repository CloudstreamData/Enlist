<!---
	Enlist - Volunteer Management Software
	Copyright (C) 2011 GreatBizTools, LLC

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

$Id$

Notes:
--->
<cfcomponent 
	extends="MachII.framework.Plugin"
	depends="securityManager">

	<!---
	INIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" returntype="void" access="public" output="false">
		<!--- Does nothing for now --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS - PLUGIN POINTS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.eventContext" required="true" />

		<cfset var event = "" />
		<cfset var log = getLog() />
		<cfset var authentication = "null" />
		<cfset var authorization = "null" />
		<cfset var environment = getEnvironment() />
		<cfset var securityManager = getSecurityManager() />
		<cfset var sessionFacade = getProperty("sessionFacade") />
		<cfset var result = structNew() />
		<cfset var args = structNew() />

		<cfset result.success = false />
		<cfset result.message = "" />

		<!---
		If Mach-II has no event, there's no event name on which to judge authorization
		--->
		<cfif arguments.eventContext.hasNextEvent()>
			<cfset event = arguments.eventContext.getNextEvent() />
			<cfif log.isInfoEnabled()>
				<cfset log.info("Event name: " & event.getName()) />
			</cfif>
		<cfelse>
			<cfif log.isInfoEnabled()>
				<cfset log.info("No event; exiting") />
			</cfif>
			<cfreturn />
		</cfif>

		<!---
		The side-effect of the plugin is that the session facade always has an authentication object.
		--->
		<cfif sessionFacade.isPropertyDefined("authentication")>
			<cfset authentication = sessionFacade.getProperty("authentication") />
			<cfif log.isDebugEnabled()>
				<cfset log.debug("Session facade contains authentication: #authentication.getSummary()#") />
			</cfif>
		<cfelse>
			<cfif log.isDebugEnabled()>
				<cfset log.debug("No authentication in session facade; Creating anonymous authentication") />
			</cfif>
			<cfset authentication = securityManager.getAuthenticationService().create() />
			<cfset sessionFacade.setProperty("authentication", authentication) />
		</cfif>

		<!---
		Request authorization for the current event and the authentication object, which will contain the name of the event on which to apply security rules.
		--->
		<cfset authorization = securityManager.getAuthorizationService().create(authentication) />
		<cfset authorization.setEventName(event.getName()) />
		<cfset securityManager.getAuthorizationService().authorize(authorization) />
		<cfif log.isDebugEnabled()>
			<cfset log.debug("Authorization complete: #authorization.getSummary()#") />
		</cfif>

		<cfif authorization.hasMatchedSecurityRule()>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Authorization matched security rule: #authorization.getMatchedSecurityRule().getSummary()#") />
			</cfif>
		<cfelse>
			<cfif log.isWarnEnabled()>
				<cfset log.warn("Authorization did not match security rules.") />
			</cfif>
		</cfif>

		<cfif authorization.getIsAuthorized()>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Authorization result: access granted") />
			</cfif>
		<cfelseif authorization.getAuthenticationRequired()>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Authorization result: authentication required") />
			</cfif>
			<cfset result.message = getParameter("authenticationRequiredMessage") />
			<cfset args.result = result />
			<cfset event.setArg("result", result) />
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset arguments.eventContext.announceEvent(getParameter("authenticationRequiredEvent"), args) />
		<cfelse>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Authorization result: access denied") />
			</cfif>
			<cfset result.message = getParameter("authorizationFailedMessage") />
			<cfset args.result = result />
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset arguments.eventContext.announceEvent(getParameter("authorizationFailedEvent"), args) />
		</cfif>
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="getEnvironment" access="private" returntype="struct" output="false">

		<cfset var environment = structNew() />

		<cfset environment.group = getAppManager().getEnvironmentGroup() />
		<cfset environment.name = getAppManager().getEnvironmentName() />
		
		<cfreturn environment />
	</cffunction>

</cfcomponent>