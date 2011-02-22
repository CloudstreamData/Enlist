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
	displayname="SessionFacade"
	output="false">
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="SessionFacade" output="false"
		hint="Initializes the Udfs.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getUser" access="public" returntype="Enlist.model.User" output="false">
		<cfreturn session.user />
	</cffunction>
	<cffunction name="removeUser" access="public" returntype="void" output="false">
		<cfset structDelete(session, "user") />
	</cffunction>
	<cffunction name="setUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="Enlist.model.User" required="true" />
		<cfset session.user = arguments.user />
	</cffunction>
	<cffunction name="isUserDefined" access="public" returntype="void" output="false">
		<cfreturn StructKeyExists(session, "user") />
	</cffunction>
	
</cfcomponent>