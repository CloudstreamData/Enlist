<cfcomponent extends="BaseSecurityObject" output="false">

	<cffunction name="create" returntype="Authentication" access="public" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="false"/>

		<cfset var authentication = "null"/>

		<cfif not structKeyExists(arguments, "user")>
			<cfset authentication = createObject("component", "Authentication").init()/>
		<cfelse>
			<cfset authentication = createObject("component", "Authentication").init(arguments.user)/>
		</cfif>
		<cfset authentication.setLogFactory(getLogFactory())/>
		<cfreturn authentication/>
	</cffunction>

	<cffunction name="authenticate" returntype="Authentication" access="public" output="false">
		<cfargument name="username" type="string" required="true"/>
		<cfargument name="password" type="string" required="true"/>

		<!--- TODO: Since this is GAE, the traditional username/password authentication needs to be changed. --->

		<cfset var user = createObject("component", "Enlist.model.user.User").init()/>
		<cfset var authentication = createObject("component", "Authentication")/>

		<cfset authentication.setUser(user)/>
		<cfreturn authentication/>
	</cffunction>

</cfcomponent>