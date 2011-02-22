<cfcomponent extends="BaseSecurityObject" output="false">

	<cffunction name="create" returntype="Authentication" access="public" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="false"/>

		<cfset var authentication = "null"/>

		<cfif not structKeyExists(arguments, "user")>
			<cfset authentication = createObject("component", "Authentication").init()/>
			<cfset authentication.setLogFactory(getLogFactory())/>
			<cfreturn authentication/>
		</cfif>

		<cfset authentication = createObject("component", "Authentication").init(arguments.user)/>
		<cfreturn authentication/>
	</cffunction>

	<cffunction name="authenticate" returntype="Authentication" access="public" output="false">
		<cfargument name="loginBean" type="Enlist.model.beans.Bean" required="true"/>

		<cfset var user = createObject("component", "Enlist.model.user.User").init()/>
		<cfset var authentication = createObject("component", "Authentication")/>

		<cfset authentication.setUser(user)/>
		<cfreturn authentication/>
	</cffunction>

	<cffunction name="penalty" returntype="Authentication" access="private" output="false">
		<cfargument name="authentication" type="Authentication" required="true"/>

		<cfset sleep(5000)/>
		<cfreturn arguments.authentication/>
	</cffunction>

</cfcomponent>