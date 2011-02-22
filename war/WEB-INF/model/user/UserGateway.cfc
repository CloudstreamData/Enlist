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
	displayname="UserGateway"
	output="false">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="UserGateway" output="false"
		hint="Initializes the gateway.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getUser" access="public" returntype="User" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfset var users = "" />

		<cfquery dbtype="google" name="users">
			select from user
			where id == '#trim(arguments.id)#'
		</cfquery>


		<cfif arrayLen( users )>
			<cfreturn users[1] />
		</cfif>

		<!--- without null, we need a convention--I'm going with returning a new object --->
		<cfreturn createObject("component", "Enlist.model.user.User").init() />
	</cffunction>

	<cffunction name="getUserByGoogleEmail" access="public" returntype="User" output="false"
		hint="Gets an User from the datastore by Google Email.">
		<cfargument name="googleEmail" type="string" required="true" />

		<cfset var users = "" />

		<cfquery dbtype="google" name="users">
			select from user
			where googleEmail == '#arguments.googleEmail#'
		</cfquery>

		<cfif arrayLen( users )>
			<cfreturn users[1] />
		</cfif>

		<cfreturn createObject("component", "Enlist.model.user.User").init() />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="array" output="false">
		<cfreturn googleQuery("select from user") />
	</cffunction>

	<cffunction name="getUsersBySearch" access="public" returntype="array" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />
		<cfargument name="role" type="string" required="false" default="" />
		<cfargument name="chapterId" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="googleEmail" type="string" required="false" default="" />
		<cfargument name="altEmail" type="string" required="false" default="" />
		<cfscript>
			var qry = "";
			var qs = "select from user where";
			var argument = "";
			var count = 0;
			for(argument in arguments) {
				if (len(arguments[argument])) {
					count = count + 1;
					if (count NEQ 1)
						qs = qs & " &&";

					qs = qs & " #argument# == '#trim(arguments[argument])#'";
				}
			}

			qry = googleQuery(qs);
			return qry;
		</cfscript>
	</cffunction>

	<cffunction name="getUsersByRole" access="public" returntype="array" output="false">
		<cfargument name="role" type="string" required="true" />
		<cfreturn googleQuery( "select from user where role == '#arguments.role#'" ) />
	</cffunction>

	<cffunction name="saveUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="true">

		<cfif user.getID() eq "">
			<cfset user.setID( createUUID() ) />
		<cfelse>
			<!--- Peter said this is a necessary workaround, because googleWrite() will not currently update, but always insert a new record: --->
			<cfset googleDelete( arguments.user ) />
		</cfif>
		<cfset googleWrite( user ) />
	</cffunction>

</cfcomponent>