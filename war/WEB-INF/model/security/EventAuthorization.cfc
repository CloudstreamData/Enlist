<cfcomponent extends="BaseSecurityObject" output="false">

	<cfset variables.authenticationRequired = false/>
	<cfset variables.permissionGranted = false/>
	<cfset variables.permissionDenied = false/>
	<cfset variables.eventName = ""/>

	<cffunction name="init" returntype="EventAuthorization" access="public" output="false">
		<cfset super.init()/>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getSummary" returntype="string" access="public" output="false">
		<cfset var summary = ""/>

		<cfset summary = listAppend(summary, "authenticationRequired=" & getAuthenticationRequired(), ";")/>
		<cfset summary = listAppend(summary, "permissionGranted=" & getPermissionGranted(), ";")/>
		<cfset summary = listAppend(summary, "permissionDenied=" & getPermissionDenied(), ";")/>
		<cfset summary = listAppend(summary, "hasAuthentication=" & hasAuthentication(), ";")/>
		<cfset summary = listAppend(summary, "hasMatchedSecurityRule=" & hasMatchedSecurityRule(), ";")/>
		<cfset summary = listAppend(summary, "eventName=" & getEventName(), ";")/>
		<cfreturn summary/>
	</cffunction>

	<cffunction name="getIsAuthorized" returntype="boolean" access="public" output="false">
		<cfif not structKeyExists(variables, "isAuthorized")>
			<cfthrow type="UnknownAuthorizationStateException" message="The authorization state cannot be determined."/>
		<cfelse>
			<cfreturn variables.isAuthorized/>
		</cfif>
	</cffunction>
	<cffunction name="setIsAuthorized" returntype="void" access="private" output="false">
		<cfargument name="isAuthorized" type="boolean" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setIsAuthorized(#arguments.isAuthorized#)")/>
		</cfif>
		<cfset variables.isAuthorized = arguments.isAuthorized/>
	</cffunction>

	<cffunction name="hasAuthentication" returntype="boolean" access="public" output="false">
		<cfreturn structKeyExists(variables, "authentication")/>
	</cffunction>
	<cffunction name="getAuthentication" returntype="Authentication" access="public" output="false">
		<cfreturn variables.authentication/>
	</cffunction>
	<cffunction name="setAuthentication" returntype="void" access="public" output="false">
		<cfargument name="authentication" type="Authentication" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setAuthentication(#arguments.authentication.getSummary()#)")/>
		</cfif>
		<cfset variables.authentication = arguments.authentication/>
	</cffunction>

	<cffunction name="getAuthenticationRequired" returntype="boolean" access="public" output="false">
		<cfreturn variables.authenticationRequired/>
	</cffunction>
	<cffunction name="setAuthenticationRequired" returntype="void" access="public" output="false">
		<cfargument name="authenticationRequired" type="boolean" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setAuthenticationRequired(#arguments.authenticationRequired#)")/>
		</cfif>
		<cfset variables.authenticationRequired = arguments.authenticationRequired/>
		<cfset setIsAuthorized(not arguments.authenticationRequired)/>
	</cffunction>

	<cffunction name="hasMatchedSecurityRule" returntype="boolean" access="public" output="false">
		<cfreturn structKeyExists(variables, "matchedSecurityRule")/>
	</cffunction>
	<cffunction name="getMatchedSecurityRule" returntype="EventSecurityRule" access="public" output="false">
		<cfreturn variables.matchedSecurityRule/>
	</cffunction>
	<cffunction name="setMatchedSecurityRule" returntype="void" access="public" output="false">
		<cfargument name="matchedSecurityRule" type="EventSecurityRule" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setMatchedRule(#arguments.matchedSecurityRule.getSummary()#)")/>
		</cfif>
		<cfset variables.matchedSecurityRule = arguments.matchedSecurityRule/>
	</cffunction>

	<cffunction name="getPermissionGranted" returntype="boolean" access="public" output="false">
		<cfreturn variables.permissionGranted/>
	</cffunction>
	<cffunction name="setPermissionGranted" returntype="void" access="public" output="false">
		<cfargument name="permissionGranted" type="boolean" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setPermissionGranted(#arguments.permissionGranted#)")/>
		</cfif>
		<cfset variables.permissionGranted = arguments.permissionGranted/>
		<cfset setIsAuthorized(arguments.permissionGranted)/>
	</cffunction>

	<cffunction name="getPermissionDenied" returntype="boolean" access="public" output="false">
		<cfreturn variables.permissionDenied/>
	</cffunction>
	<cffunction name="setPermissionDenied" returntype="void" access="public" output="false">
		<cfargument name="permissionDenied" type="boolean" required="true"/>

		<cfif getLog().isInfoEnabled()>
			<cfset getLog().info("setPermissionDenied(#arguments.permissionDenied#)")/>
		</cfif>
		<cfset variables.permissionDenied = arguments.permissionDenied/>
		<cfset setIsAuthorized(not arguments.permissionDenied)/>
	</cffunction>

	<cffunction name="getEventName" returntype="string" access="public" output="false">
		<cfreturn variables.eventName/>
	</cffunction>
	<cffunction name="setEventName" returntype="void" access="public" output="false">
		<cfargument name="eventName" type="string" required="true"/>
		<cfset getLog().info("setEventName('#arguments.eventName#')")/>
		<cfset variables.eventName = arguments.eventName/>
	</cffunction>

</cfcomponent>