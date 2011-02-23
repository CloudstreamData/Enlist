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
	displayname="BaseService"
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.gateway = "" />
	<cfset variables.sessionFacade = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfreturn this />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="getGateway" access="public" returntype="any" output="false">
		<cfreturn variables.gateway />
	</cffunction>
	<cffunction name="setGateway" access="public" returntype="void" output="false">
		<cfargument name="gateway" type="any" required="true" />
		<cfset variables.gateway = arguments.gateway />
	</cffunction>

	<cffunction name="getSessionFacade" access="public" returntype="any" output="false">
		<cfreturn variables.sessionFacade />
	</cffunction>
	<cffunction name="setSessionFacade" access="public" returntype="any" output="false">
		<cfargument name="sessionFacade" type="any" required="true" />
		<cfset variables.sessionFacade = arguments.sessionFacade />
	</cffunction>

</cfcomponent>