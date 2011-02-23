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