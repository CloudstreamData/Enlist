<cfcomponent output="false">

	<cffunction name="init" returntype="BaseSecurityObject" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="defineImmutableInstanceVariable" returntype="void" access="private" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="value" type="any" required="true"/>

		<cfif structKeyExists(variables, arguments.name)>
			<cfthrow type="SecurityManagerException" message="The instance variable (#arguments.name#) has already been defined; it is now immutable."/>
		</cfif>
		<cfset variables[arguments.name] = arguments.value/>
	</cffunction>

	<cffunction name="getLog" access="public" returntype="MachII.logging.Log" output="false">
		<cfif not structKeyExists(variables, "log")>
			<cfset variables.log = createObject("component", "MachII.logging.LogFactory").init().getLog(getMetadata(this).name)/>
		</cfif>
		<cfreturn variables.log/>
	</cffunction>
	<cffunction name="setLog" access="public" returntype="void" output="false">
		<cfargument name="log" type="MachII.logging.Log" required="true"/>
		<cfset variables.log = arguments.log/>
	</cffunction>

	<cffunction name="getLogFactory" access="public" returntype="MachII.logging.LogFactory" output="false">
		<cfif not structKeyExists(variables, "logFactory")>
			<cfset variables.logFactory = createObject("component", "MachII.logging.LogFactory").init()/>
		</cfif>
		<cfreturn variables.logFactory/>
	</cffunction>
	<cffunction name="setLogFactory" access="public" returntype="void" output="false">
		<cfargument name="logFactory" type="MachII.logging.LogFactory" required="true"/>
		<cfset variables.logFactory = arguments.logFactory/>
		<cfset setLog(variables.logFactory.getLog(getMetadata(this).name))/>
	</cffunction>

</cfcomponent>