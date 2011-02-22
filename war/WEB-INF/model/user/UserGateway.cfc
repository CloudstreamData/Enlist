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
	<cfset variables.dao = "" />

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
	<cffunction name="getUser" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn getDAO().read( arguments.id ) />
	</cffunction>

	<cffunction name="getUserByGoogleEmail" access="public" returntype="any" output="false"
		hint="Gets an User from the datastore by Google Email.">
		<cfargument name="googleEmail" type="string" required="true" />
		<cfreturn getDAO().readByProperty( "googleEmail", arguments.googleEmail ) />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="array" output="false">
		<cfreturn getDAO().list() />
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
		<cfreturn getDAO().listByPropertyMap( arguments ) />
	</cffunction>

	<cffunction name="getUsersByRole" access="public" returntype="array" output="false">
		<cfargument name="role" type="string" required="true" />
		<cfreturn getDAO().listByProperty( "role", arguments.role ) />
	</cffunction>

	<cffunction name="saveUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="true">
		<cfset getDAO().save( arguments.user ) />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="getDAO" returntype="Enlist.model.GenericDAO" access="public" output="false">
		<cfreturn variables.dao />
	</cffunction>
	<cffunction name="setDAO" returntype="void" access="public" output="false">
		<cfargument name="dao" type="Enlist.model.GenericDAO" required="true" />
		<cfset variables.dao = arguments.dao />
	</cffunction>

</cfcomponent>