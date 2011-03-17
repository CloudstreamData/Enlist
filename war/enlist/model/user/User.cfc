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

$Id: $

Notes:
--->
<cfcomponent
	displayname="User"
	output="false"
	hint="A bean which models the User form.">


	<!---
	PROPERTIES
	--->
	<cfset variables.id = "" />
	<cfset variables.status = "" />
	<cfset variables.role = "" /><!--- valid values: Volunteer, Coordinator, Admin --->
	<cfset variables.chapterId = "" />
	<cfset variables.firstName = "" />
	<cfset variables.lastName = "" />
	<cfset variables.googleEmail = "" />
	<cfset variables.altEmail = "" />
	<cfset variables.importHashCode = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="User" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="valid" />
		<cfargument name="role" type="string" required="false" default="" />
		<cfargument name="chapterId" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="googleEmail" type="string" required="false" default="" />
		<cfargument name="altEmail" type="string" required="false" default="" />
		<cfargument name="importHashCode" type="UUID" required="false" default="#CreateUUID()#" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true"/>
		<cfset setId(arguments.data.id) />
		<cfset setStatus(arguments.data.status) />
		<cfset setRole(arguments.data.role) />
		<cfset setChapterId(arguments.data.chapterId) />
		<cfset setFirstName(arguments.data.firstName) />
		<cfset setLastName(arguments.data.lastName) />
		<cfset setGoogleEmail(arguments.data.googleEmail) />
		<cfset setAltEmail(arguments.data.altEmail) />
		<cfset setImportHashCode(arguments.data.importHashCode) />
	</cffunction>
	<cffunction name="getInstanceMemento" access="public"returntype="struct" output="false" >
		<cfset var data = structnew() />
		<cfset var fieldname = "" />

		<cfloop list="id,status,role,chapterId,firstName,lastName,googleEmail,altEmail,importHashCode" index="fieldname">
			<cfset data[fieldname] = variables[fieldname] />
		</cfloop>

		<cfreturn data />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = trim(arguments.id) />
	</cffunction>
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.id />
	</cffunction>

	<cffunction name="setStatus" access="public" returntype="void" output="false">
		<cfargument name="status" type="string" required="true" />
		<cfset variables.status = trim(arguments.status) />
	</cffunction>
	<cffunction name="getStatus" access="public" returntype="string" output="false">
		<cfreturn variables.status />
	</cffunction>

	<cffunction name="setRole" access="public" returntype="void" output="false">
		<cfargument name="role" type="string" required="true" />
		<cfset variables.role = trim(arguments.role) />
	</cffunction>
	<cffunction name="getRole" access="public" returntype="string" output="false">
		<cfreturn variables.role />
	</cffunction>

	<cffunction name="setChapterId" access="public" returntype="void" output="false">
		<cfargument name="chapterId" type="string" required="true" />
		<cfset variables.chapterId = trim(arguments.chapterId) />
	</cffunction>
	<cffunction name="getChapterId" access="public" returntype="string" output="false">
		<cfreturn variables.chapterId />
	</cffunction>

	<cffunction name="setFirstName" access="public" returntype="void" output="false">
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.firstName = trim(arguments.firstName) />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.firstName />
	</cffunction>

	<cffunction name="setLastName" access="public" returntype="void" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.lastName = trim(arguments.lastName) />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="string" output="false">
		<cfreturn variables.lastName />
	</cffunction>

	<cffunction name="setGoogleEmail" access="public" returntype="void" output="false">
		<cfargument name="googleEmail" type="string" required="true" />
		<cfset variables.googleEmail = trim(arguments.googleEmail) />
	</cffunction>
	<cffunction name="getGoogleEmail" access="public" returntype="string" output="false">
		<cfreturn variables.googleEmail />
	</cffunction>

	<cffunction name="setAltEmail" access="public" returntype="void" output="false">
		<cfargument name="altEmail" type="string" required="true" />
		<cfset variables.altEmail = trim(arguments.altEmail) />
	</cffunction>
	<cffunction name="getAltEmail" access="public" returntype="string" output="false">
		<cfreturn variables.altEmail />
	</cffunction>

	<cffunction name="setImportHashCode" access="public" returntype="void" output="false">
		<cfargument name="importHashCode" type="UUID" required="true" />
		<cfset variables.importHashCode = arguments.importHashCode />
	</cffunction>
	<cffunction name="getImportHashCode" access="public" returntype="UUID" output="false">
		<cfreturn variables.importHashCode />
	</cffunction>
	
	<cffunction name="dump" access="public" returntype="void" output="false">
		<cfargument name="abort" type="boolean" required="false" default="false" />
		
		<cfset var property = "" />
		
		<cfloop collection="#variables#" item="property">
			<cfdump var="#variables[property]#" /><br />
		</cfloop>
		
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

</cfcomponent>