<cfcomponent extends="BaseSecurityObject" output="false">

	<cffunction name="init" returntype="Authentication" access="public" output="false">
		<cfset super.init()/>
		<cfset setIsAuthenticated(false)/>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getSummary" returntype="string" access="public" output="false">
		<cfset var summary = ""/>

		<cfset summary = listAppend(summary, "isAuthenticated=" & getIsAuthenticated(), ";")/>
		<cfset summary = listAppend(summary, "credentials=anonymous", ";")/>
		<cfreturn summary/>
	</cffunction>

	<cffunction name="hasRole" returntype="boolean" access="public" output="false">
		<cfargument name="role" type="string" required="true"/>
		<cfreturn false/>
	</cffunction>

	<cffunction name="hasPermission" returntype="boolean" access="public" output="false">
		<cfargument name="permission" type="string" required="true"/>
		<cfreturn false/>
	</cffunction>

	<cffunction name="getIsAuthenticated" returntype="boolean" access="public" output="false">
		<cfreturn variables.isAuthenticated/>
	</cffunction>
	<cffunction name="setIsAuthenticated" returntype="void" access="public" output="false">
		<cfargument name="isAuthenticated" type="boolean" required="true"/>
		<cfset variables.isAuthenticated = arguments.isAuthenticated/>
	</cffunction>

</cfcomponent>