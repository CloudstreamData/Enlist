<cfcomponent extends="BaseSecurityObject" output="false">

	<cffunction name="init" returntype="Authentication" access="public" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="false"/>

		<cfset setIsAuthenticated(false)/>
		<cfif structKeyExists(arguments, "user")>
			<cfset setUser(arguments.user)/>
		</cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getSummary" returntype="string" access="public" output="false">
		<cfset var summary = ""/>
		<cfset var user = "null"/>

		<cfset summary = listAppend(summary, "isAuthenticated=" & getIsAuthenticated(), ";")/>
		<cfif hasUser()>
			<cfset user = getUser()/>
			<cfset summary = listAppend(summary, "id='#user.getId()#'", ";")/>
			<cfset summary = listAppend(summary, "googleEmail='#user.getGoogleEmail()#'", ";")/>
			<cfset summary = listAppend(summary, "status='#user.getStatus()#'", ";")/>
			<cfset summary = listAppend(summary, "role='#user.getRole()#'", ";")/>
		<cfelse>
			<cfset summary = listAppend(summary, "credentials=anonymous", ";")/>
		</cfif>
		<cfreturn summary/>
	</cffunction>

	<cffunction name="getIsAuthenticated" returntype="boolean" access="public" output="false">
		<cfif hasUser() and compareNoCase(getUser().getStatus(), "valid") eq 0>
			<cfreturn true/>
		<cfelse>
			<cfreturn false/>
		</cfif>
	</cffunction>
	<cffunction name="setIsAuthenticated" returntype="void" access="public" output="false">
		<cfargument name="isAuthenticated" type="boolean" required="true"/>
		<cfset variables.isAuthenticated = arguments.isAuthenticated/>
	</cffunction>

	<cffunction name="hasRole" returntype="boolean" access="public" output="false">
		<cfargument name="role" type="string" required="true"/>

		<cfset var _role = ""/>

		<cfif not hasUser()>
			<cfreturn false/>
		</cfif>
		<cfloop list="#getUser().getRole()#" index="_role">
			<cfif compareNoCase(_role, arguments.role) eq 0>
				<cfreturn true/>
			</cfif>
		</cfloop>
		<cfreturn false/>
	</cffunction>

	<cffunction name="hasUser" returntype="boolean" access="public" output="false">
		<cfreturn structKeyExists(variables, "user")/>
	</cffunction>
	<cffunction name="getUser" returntype="Enlist.model.user.User" access="public" output="false">
		<cfreturn variables.user/>
	</cffunction>
	<cffunction name="setUser" returntype="void" access="public" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="true"/>
		<cfset variables.user = arguments.user/>
	</cffunction>

</cfcomponent>