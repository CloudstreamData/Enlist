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
	displayname="ApplicationPlugin"
	extends="MachII.framework.Plugin"
	depends="sessionFacade,securityManager,userService"
	output="false"
	hint="An ApplicationPlugin.">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the plugin.">
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var event = arguments.eventContext.getNextEvent() />
		<cfset var sessionFacade = getProperty("sessionFacade")/>

		<cfif sessionFacade.isPropertyDefined("authentication")>
			<cfset var authentication = sessionFacade.getProperty("authentication")/>
		<cfelse>
			<cfset var authentication = getSecurityManager().getAuthenticationService().create()/>
		</cfif>

		<!--- <cfif getGoogleUserService().isUserLoggedIn() AND NOT authentication.hasUser()>
			<!--- Load in our User object based off the Google Email as the ID --->
			<cfset var googleEmail = getGoogleUserService().getCurrentUser().getEmail() />
			<cfset var userByGoogleEmail = getUserService().getUserByGoogleEmail( googleEmail ) />

			<cfif len(userByGoogleEmail.getID())>
				<cfset authentication.setUser( userByGoogleEmail ) />
				<cfset sessionFacade.setProperty("authentication", authentication) />
			<cfelseif event.getName() NEQ "register_process">
				<!--- if the user is logged in with their google account, but not in this system, send them to the registration event --->
				<cfset eventContext.clearEventQueue() />
				<cfif not event.isArgDefined("message")>
					<cfset event.setArg("message", "Please register before continuing") />
				</cfif>
				<cfset event.setArg("googleEmail",googleEmail) />
				<cfset announceEvent("register", event.getArgs()) />
			</cfif>
		</cfif> --->
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->

	<!---
	ACCESSORS
	--->

</cfcomponent>