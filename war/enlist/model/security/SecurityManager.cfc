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
<cfcomponent extends="BaseSecurityObject" output="false">

	<cffunction name="init" returntype="SecurityManager" access="public" output="false">
		<cfargument name="authenticationService" type="enlist.model.security.AuthenticationService" required="false"/>
		<cfargument name="authorizationService" type="enlist.model.security.EventAuthorizationService" required="false"/>
		<cfargument name="securityRuleParser" type="enlist.model.security.EventSecurityRuleParser" required="false"/>

		<cfset super.init()/>
		<cfif structKeyExists(arguments, "authenticationService")>
			<cfset setAuthenticationService(arguments.authenticationService)/>
		</cfif>
		<cfif structKeyExists(arguments, "authorizationService")>
			<cfset setAuthorizationService(arguments.authorizationService)/>
		</cfif>
		<cfif structKeyExists(arguments, "securityRuleParser")>
			<cfset setSecurityRuleParser(arguments.securityRuleParser)/>
		</cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="load" returntype="void" access="public" output="false">
		<cfargument name="securityRules" type="any" required="true"/>
		<cfargument name="environment" type="struct" required="true"/>

		<cfset getAuthorizationService().setEnvironment(arguments.environment)/>
		<cfset getAuthorizationService().setSecurityRules(getSecurityRuleParser().parse(arguments.securityRules))/>
	</cffunction>

	<cffunction name="getSecurityRuleParser" returntype="enlist.model.security.EventSecurityRuleParser" access="private" output="false">
		<cfreturn variables.securityRuleParser/>
	</cffunction>
	<cffunction name="setSecurityRuleParser" returntype="void" access="private" output="false">
		<cfargument name="securityRuleParser" type="enlist.model.security.EventSecurityRuleParser" required="true"/>
		<cfset defineImmutableInstanceVariable("securityRuleParser", arguments.securityRuleParser)/>
	</cffunction>

	<cffunction name="getAuthenticationService" returntype="enlist.model.security.AuthenticationService" access="public" output="false">
		<cfreturn variables.authenticationService/>
	</cffunction>
	<cffunction name="setAuthenticationService" returntype="void" access="public" output="false">
		<cfargument name="authenticationService" type="enlist.model.security.AuthenticationService" required="true"/>
		<cfset defineImmutableInstanceVariable("authenticationService", arguments.authenticationService)/>
	</cffunction>

	<cffunction name="getAuthorizationService" returntype="enlist.model.security.EventAuthorizationService" access="public" output="false">
		<cfreturn variables.authorizationService/>
	</cffunction>
	<cffunction name="setAuthorizationService" returntype="void" access="public" output="false">
		<cfargument name="authorizationService" type="enlist.model.security.EventAuthorizationService" required="true"/>
		<cfset defineImmutableInstanceVariable("authorizationService", arguments.authorizationService)/>
	</cffunction>

</cfcomponent>