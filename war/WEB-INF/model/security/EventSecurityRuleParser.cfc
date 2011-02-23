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

	<cffunction name="parse" returntype="array" access="public" output="false">
		<cfargument name="securityRules" type="any" required="true"/>

		<cfset var rule = "null"/>
		<cfset var rules = arrayNew(1)/>
		<cfset var eventSecurityRule = "null"/>
		<cfset var log = getLog()/>

		<cfset getLog().info("Parsing security rules.")/>
		<cfloop array="#arguments.securityRules#" index="rule">
			<cfset eventSecurityRule = createObject("component", "Enlist.model.security.EventSecurityRule").init(argumentCollection=rule)/>
			<cfset eventSecurityRule.setLogFactory(getLogFactory())/>
			<cfif log.isInfoEnabled()>
				<cfset log.info("Created security rule: #eventSecurityRule.getSummary()#")/>
			</cfif>
			<cfset arrayAppend(rules, eventSecurityRule)/>
		</cfloop>
		<cfreturn rules/>
	</cffunction>

</cfcomponent>