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
--->
<cfcomponent extends="tests.mxunit.BaseTest" output="false">

	<cffunction name="setup" returntype="void" access="public" output="false">
		<cfset super.setup()/>
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public" output="false">
	</cffunction>

	<cffunction name="testUserRoles" returntype="void" access="public" output="false">
		<cfset var securityManager = getSecurityManager()/>
		<cfset var user = "null"/>
		<cfset var authentication = "null"/>
		<cfset var authorization = "null"/>

		<!--- Anonymous user --->
		<cfset authentication = securityManager.getAuthenticationService().create()/>
		<cfset assertFalse(authentication.hasUser(), "The anonymous authentication should not have a user.")/>
		<cfset assertFalse(authentication.getIsAuthenticated(), "The anonymous user should not be authenticated")/>

		<!--- Volunteer user --->
		<cfset user = getUserByType("volunteer")/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>
		<cfset assertTrue(authentication.hasUser(), "The volunteer authentication should contain a user.")/>
		<cfset assertTrue(authentication.getIsAuthenticated(), "The volunteer user should be authenticated.")/>
		<cfset assertTrue(authentication.hasRole("volunteer"), "The volunteer user should have the volunteer role.")/>
		<cfset assertFalse(authentication.hasRole("coordinator"), "The volunteer user should not have the coordinator role.")/>
		<cfset assertFalse(authentication.hasRole("admin"), "The volunteer user should not have the admin role.")/>

		<!--- Coordinator user --->
		<cfset user = getUserByType("coordinator")/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>
		<cfset assertTrue(authentication.hasUser(), "The coordinator authentication should contain a user.")/>
		<cfset assertTrue(authentication.getIsAuthenticated(), "The coordinator user should be authenticated.")/>
		<cfset assertTrue(authentication.hasRole("volunteer"), "The coordinator user should also have the volunteer role.")/>
		<cfset assertTrue(authentication.hasRole("coordinator"), "The coordinator user should have the coordinator role.")/>
		<cfset assertFalse(authentication.hasRole("admin"), "The coordinator user should not have the admin role.")/>

		<!--- Admin user --->
		<cfset user = getUserByType("admin")/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>
		<cfset assertTrue(authentication.hasUser(), "The admin authentication should contain a user.")/>
		<cfset assertTrue(authentication.getIsAuthenticated(), "The admin user should be authenticated.")/>
		<cfset assertFalse(authentication.hasRole("volunteer"), "The admin user should not have the volunteer role.")/>
		<cfset assertFalse(authentication.hasRole("coordinator"), "The admin user should not have the coordinator role.")/>
		<cfset assertTrue(authentication.hasRole("admin"), "The admin user should have the admin role.")/>

	</cffunction>


	<cffunction name="testUserAccess" returntype="void" access="public" output="false">
		<cfset var securityManager = getSecurityManager()/>
		<cfset var environment = getEnvironmentByType("production")/>
		<cfset var securityRules = getSecurityRulesByType("user")/>
		<cfset var user = getUserByType("volunteer")/>
		<cfset var authentication = "null"/>
		<cfset var authorization = "null"/>

		<cfset securityManager.load(securityRules, environment)/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>

		<cfset authorization = securityManager.getAuthorizationService().create(authentication)/>
		<cfset authorization.setEventName("user.home")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertTrue(authorization.getIsAuthorized(), "An authenticated user should have access to the user home page.")/>
	</cffunction>

	<cffunction name="testAdminAccess" returntype="void" access="public" output="false">
		<cfset var securityManager = getSecurityManager()/>
		<cfset var environment = getEnvironmentByType("production")/>
		<cfset var securityRules = getSecurityRulesByType("admin")/>
		<cfset var user = getUserByType("admin")/>
		<cfset var authentication = "null"/>
		<cfset var authorization = "null"/>

		<cfset securityManager.load(securityRules, environment)/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>

		<cfset authorization = securityManager.getAuthorizationService().create(authentication)/>
		<cfset authorization.setEventName("admin.home")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertTrue(authorization.getIsAuthorized(), "The admin user should be granted access to the admin.home event.")/>
	</cffunction>

	<cffunction name="testVolunteerAccess" returntype="void" access="public" output="false">
		<cfset var securityManager = getSecurityManager()/>
		<cfset var environment = getEnvironmentByType("production")/>
		<cfset var securityRules = getSecurityRulesByType("volunteer")/>
		<cfset var user = getUserByType("volunteer")/>
		<cfset var authentication = "null"/>
		<cfset var authorization = "null"/>

		<cfset securityManager.load(securityRules, environment)/>
		<cfset authentication = securityManager.getAuthenticationService().create(user)/>

		<cfset authorization = securityManager.getAuthorizationService().create(authentication)/>
		<cfset authorization.setEventName("volunteer.home")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertTrue(authorization.getIsAuthorized(), "The volunteer user should have access to the volunteer home page.")/>
	</cffunction>

	<cffunction name="testAnonymousAccess" returntype="void" access="public" output="false">
		<cfset var securityManager = getSecurityManager()/>
		<cfset var environment = getEnvironmentByType("production")/>
		<cfset var securityRules = "null"/>
		<cfset var authentication = "null"/>
		<cfset var authorization = "null"/>

		<!--- Allow all --->
		<cfset securityRules = getSecurityRulesByType("allowAll")/>
		<cfset securityManager.load(securityRules, environment)/>

		<cfset authorization = securityManager.getAuthorizationService().create()/>
		<cfset authorization.setEventName("event")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertTrue(authorization.getIsAuthorized(), "All events should be authorized.")/>

		<!--- Deny all --->
		<cfset securityRules = getSecurityRulesByType("denyAll")/>
		<cfset securityManager.load(securityRules, environment)/>

		<cfset authorization = securityManager.getAuthorizationService().create()/>
		<cfset authorization.setEventName("event")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertFalse(authorization.getIsAuthorized(), "No events should be authorized.")/>

		<!--- Public event --->
		<cfset securityRules = getSecurityRulesByType("user")/>
		<cfset securityManager.load(securityRules, environment)/>

		<cfset authorization = securityManager.getAuthorizationService().create()/>
		<cfset authorization.setEventName("login")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertTrue(authorization.getIsAuthorized(), "The anonymous user should have access to the login page.")/>

		<!--- Require login --->
		<cfset securityRules = getSecurityRulesByType("user")/>
		<cfset securityManager.load(securityRules, environment)/>

		<cfset authorization = securityManager.getAuthorizationService().create()/>
		<cfset authorization.setEventName("user.home")/>
		<cfset securityManager.getAuthorizationService().authorize(authorization)/>
		<cfset assertFalse(authorization.getIsAuthorized(), "The anonymous user should be required to login.")/>
	</cffunction>

	<cffunction name="getSecurityManager" returntype="Enlist.model.security.SecurityManager" access="private" output="false">
		<cfset var securityManager = "null"/>
		<cfset var authenticationService = createObject("component", "Enlist.model.security.AuthenticationService")/>
		<cfset var authorizationService = createObject("component", "Enlist.model.security.EventAuthorizationService")/>
		<cfset var securityRuleParser = createObject("component", "Enlist.model.security.EventSecurityRuleParser")/>
		<cfset var environment = structNew()/>

		<cfset securityManager = createObject("component", "Enlist.model.security.SecurityManager").init(authenticationService, authorizationService, securityRuleParser)/>
		<cfreturn securityManager/>
	</cffunction>

	<cffunction name="getEnvironmentByType" returntype="struct" access="private" output="false">
		<cfargument name="type" type="string" required="true"/>

		<cfset var environment = structNew()/>

		<cfif arguments.type eq "development">
			<cfset environment.group = "development"/>
			<cfset environment.name = "localhost"/>
		<cfelseif arguments.type eq "production">
			<cfset environment.group = "production"/>
			<cfset environment.name = "server"/>
		</cfif>
		<cfreturn environment/>
	</cffunction>

	<cffunction name="getSecurityRulesByType" returntype="array" access="private" output="false">
		<cfargument name="type" type="string" required="true"/>

		<cfset var securityRule = "null"/>
		<cfset var securityRules = arrayNew(1)/>

		<!--- TODO: As soon as Open BlueDragon for Google App Engine supports mondern syntax, clean this up. --->
		<cfif arguments.type eq "allowAll">
			<cfset securityRule = structNew()/>
			<cfset securityRule.eventPattern = ".*"/>
			<cfset securityRule.action = "allow"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		<cfelseif arguments.type eq "denyAll">
			<cfset securityRule = structNew()/>
			<cfset securityRule.eventPattern = ".*"/>
			<cfset securityRule.action = "deny"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		<cfelseif arguments.type eq "user">
			<!--- Public events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.events = "home,login,logout"/>
			<cfset securityRule.action = "allow"/>
			<cfset arrayAppend(securityRules, securityRule)/>

			<!--- User events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.eventName = "user.home"/>
			<cfset securityRule.action = "requireAuthentication"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		<cfelseif arguments.type eq "admin">
			<!--- Public events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.events = "home,login,logout"/>
			<cfset securityRule.action = "allow"/>
			<cfset arrayAppend(securityRules, securityRule)/>

			<!--- Admin events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.eventPattern = "admin.*"/>
			<cfset securityRule.action = "requireRole"/>
			<cfset securityRule.roleRequired = "admin"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		<cfelseif arguments.type eq "volunteer">
			<!--- Public events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.events = "home,login,logout"/>
			<cfset securityRule.action = "allow"/>
			<cfset arrayAppend(securityRules, securityRule)/>

			<!--- Volunteer events --->
			<cfset securityRule = structNew()/>
			<cfset securityRule.eventPattern = "volunteer.*"/>
			<cfset securityRule.action = "requireRole"/>
			<cfset securityRule.roleRequired = "volunteer"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		<cfelseif arguments.type eq "development">
			<cfset securityRule = structNew()/>
			<cfset securityRule.environment = "group:development,localhost"/>
			<cfset securityRule.eventPattern = ".*"/>
			<cfset securityRule.action = "allow"/>
			<cfset arrayAppend(securityRules, securityRule)/>
		</cfif>
		<cfreturn securityRules/>
	</cffunction>

	<cffunction name="getUserByType" returntype="Enlist.model.user.User" access="private" output="false">
		<cfargument name="type" type="string" required="false" default=""/>

		<cfset var cfg = getConfig()/>
		<cfset var user = "null"/>

		<cfif arguments.type eq "admin">
			<cfset user = createObject("component", "Enlist.model.user.User").init(argumentCollection=cfg.testData.admin)/>
		<cfelseif arguments.type eq "coordinator">
			<cfset user = createObject("component", "Enlist.model.user.User").init(argumentCollection=cfg.testData.coordinator)/>
		<cfelseif arguments.type eq "volunteer">
			<cfset user = createObject("component", "Enlist.model.user.User").init(argumentCollection=cfg.testData.volunteer)/>
		<cfelse>
			<cfset fail("A request for an unknown user type (" & arguments.type & ") was requested.")/>
		</cfif>
		<cfreturn user/>
	</cffunction>

</cfcomponent>