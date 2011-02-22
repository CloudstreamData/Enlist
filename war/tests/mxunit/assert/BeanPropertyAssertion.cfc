<cfcomponent>

	<cffunction name="assertBeanProperty" returntype="boolean" access="public" output="false">
		<cfargument name="properties" type="string" required="true"/>
		<cfargument name="bean" type="any" required="true"/>

		<cfset var property = ""/>
		<cfset var value = ""/>

		<cfloop list="#arguments.properties#" index="property">
			<cftry>
				<cfinvoke component="#arguments.bean#" method="get#property#" returnVariable="value"/>
				<cfcatch>
					<cfreturn false/>
				</cfcatch>
			</cftry>
		</cfloop>
		<cfreturn true/>
	</cffunction>

</cfcomponent>