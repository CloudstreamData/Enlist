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