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

	<cffunction name="create" returntype="EventAuthorization" access="public" output="false">
		<cfargument name="authentication" type="Authentication" required="false"/>

		<cfset var authorization = createObject("component", "enlist.model.security.EventAuthorization").init()/>

		<cfset authorization.setLogFactory(getLogFactory())/>
		<cfif structKeyExists(arguments, "authentication")>
			<cfset authorization.setAuthentication(arguments.authentication)/>
		</cfif>
		<cfreturn authorization/>
	</cffunction>

	<cffunction name="authorize" returntype="boolean" access="public" output="false">
		<cfargument name="authorization" type="EventAuthorization" required="true"/>

		<cfset var auth = arguments.authorization/>
		<cfset var rules = getSecurityRules()/>
		<cfset var rule = "null"/>
		<cfset var environment = getEnvironment()/>
		<cfset var action = ""/>
		<cfset var log = getLog()/>

		<cfset log.info("Performing authorization in environment; group:#environment.group#, name:#environment.name#")/>
		<cfloop from="1" to="#arrayLen(rules)#" index="i">
			<cfset rule = rules[i]/>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Evaluating rule: #rule.getSummary()#")/>
			</cfif>

			<cfif rule.isEventMatch(auth.getEventName()) and rule.isEnvironmentMatch(environment)>
				<cfset auth.setMatchedSecurityRule(rule)/>
				<cfset action = rule.getAction()/>

				<cfif action eq "allow">
					<cfset auth.setPermissionGranted(true)/>
					<cfbreak/>
				<cfelseif action eq "deny">
					<cfset auth.setPermissionDenied(true)/>
					<cfbreak/>
				</cfif>

				<cfif action eq "requireAuthentication">
					<cfif auth.hasAuthentication() and auth.getAuthentication().getIsAuthenticated()>
						<cfset auth.setPermissionGranted(true)/>
						<cfbreak/>
					<cfelse>
						<cfset auth.setAuthenticationRequired(true)/>
						<cfbreak/>
					</cfif>
				</cfif>

				<cfif action eq "requireRole">
					<cfif not auth.hasAuthentication() or not auth.getAuthentication().getIsAuthenticated()>
						<cfset auth.setAuthenticationRequired(true)/>
						<cfbreak/>
					<cfelseif auth.getAuthentication().hasRole(rule.getRoleRequired())>
						<cfset auth.setPermissionGranted(true)/>
						<cfbreak/>
					<cfelse>
						<cfset auth.setPermissionDenied(true)/>
						<cfbreak/>
					</cfif>
				</cfif>

				<cfif action eq "requirePermission">
					<cfif not auth.hasAuthentication() or not auth.getAuthentication().getIsAuthenticated()>
						<cfset auth.setAuthenticationRequired(true)/>
						<cfbreak/>
					<cfelseif auth.getAuthentication().hasPermission(rule.getPermissionRequired())>
						<cfset auth.setPermissionGranted(true)/>
						<cfbreak/>
					<cfelse>
						<cfset auth.setPermissionDenied(true)/>
						<cfbreak/>
					</cfif>
				</cfif>

				<cfif auth.hasMatchedSecurityRule()>
					<cfreturn auth.getIsAuthorized()/>
				<cfelse>
					<cfthrow type="SecurityRulesException" message="The EventAuthorizationService encountered an invalid rule action (#action#)."/>
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn false/>
	</cffunction>

	<cffunction name="getSecurityRules" returntype="array" access="public" output="false">
		<cfreturn variables.securityRules/>
	</cffunction>
	<cffunction name="setSecurityRules" returntype="void" access="public" output="false">
		<cfargument name="securityRules" type="array" required="true"/>
		<cfset variables.securityRules = arguments.securityRules/>
	</cffunction>

	<cffunction name="getEnvironment" returntype="struct" access="public" output="false">
		<cfreturn variables.environment/>
	</cffunction>
	<cffunction name="setEnvironment" returntype="void" access="public" output="false">
		<cfargument name="environment" type="struct" required="true"/>
		<cfset variables.environment = arguments.environment/>
	</cffunction>

</cfcomponent>