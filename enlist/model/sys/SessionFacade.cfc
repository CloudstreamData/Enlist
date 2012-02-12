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

$Id$

Notes:
To get a reference to the current user, perform the following:

	authentication = sessionFacade.getProperty("authentication");
	if (authentication.hasUser() and authentication.getIsAuthenticated()) {
		user = authentication.getUser();
	}

To effectively log a user out, delete the authentication:
	sessionFacade.deleteProperty("authentication")

--->
<cfcomponent
	displayname="SessionFacade"
	output="false">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="SessionFacade" output="false">
		<cfargument name="sessionStoreName" type="string" required="false" default=""/>

		<cfif arguments.sessionStoreName neq "">
			<cfset setSessionStoreName(arguments.sessionStoreName)/>
		<cfelse>
			<cfset setSessionStoreName("SessionFacadeSessionStore")/>
		</cfif>
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="isPropertyDefined" returntype="boolean" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>

		<cfset var ss = getSessionStore()/>

		<cflock scope="session" type="readonly" throwontimeout="true" timeout="10">
			<cfreturn structKeyExists(ss, arguments.name)>
		</cflock>
	</cffunction>

	<cffunction name="getProperty" returntype="any" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="default" type="any" required="true" default=""/>

		<cfset var ss = getSessionStore()/>

		<cflock scope="session" type="readonly" throwontimeout="true" timeout="10">
			<cfif structKeyExists(ss, arguments.name)>
				<cfreturn ss[arguments.name]/>
			<cfelse>
				<cfreturn arguments.default/>
			</cfif>
		</cflock>
	</cffunction>

	<cffunction name="setProperty" returntype="void" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="value" type="any" required="true"/>

		<cfset var ss = getSessionStore()/>

		<cflock scope="session" type="exclusive" throwontimeout="true" timeout="10">
			<cfif structKeyExists(ss, arguments.name)>
				<cfset structUpdate(ss, arguments.name, arguments.value)/>
			<cfelse>
				<cfset structInsert(ss, arguments.name, arguments.value)/>
			</cfif>
		</cflock>
	</cffunction>

	<cffunction name="deleteProperty" returntype="void" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="throwOnUndefinedProperty" type="boolean" required="false" default="false"/>

		<cfset var ss = getSessionStore()/>

		<cflock scope="session" type="exclusive" throwontimeout="true" timeout="10">
			<cfif not structKeyExists(ss, arguments.name) and arguments.throwOnUndefinedProperty>
				<cfthrow message="SessionFacade.deleteProperty(): Property '#arguments.name#' is not defined."/>
			<cfelse>
				<cfset structDelete(ss, arguments.name)/>
			</cfif>
		</cflock>
	</cffunction>

	<cffunction name="deleteProperties" returntype="void" access="public" output="false">
		<cfargument name="names" type="string" required="true"/>
		<cfargument name="throwOnUndefinedProperty" type="boolean" required="false" default="false"/>

		<cfset var name = ""/>

		<cfif len(arguments.names) gt 0>
			<cfloop list="#arguments.names#" index="name">
				<cfset deleteProperty(name, arguments.throwOnUndefinedProperty)/>
			</cfloop>
		</cfif>
	</cffunction>

	<cffunction name="clearSessionStore" returntype="void" access="public" output="false">
		<cfset structClear(getSessionStore()) />
	</cffunction>

	<!---
	PRIVATE FUNCTIONS
	--->
	<cffunction name="getSessionStore" access="private" returntype="struct" output="false">
		<cfset var ss = structNew()/>

		<cflock scope="session" type="exclusive" throwontimeout="true" timeout="10">
			<cfif not structKeyExists(session, getSessionStoreName())>
				<cfset structInsert(session, getSessionStoreName(), ss)/>
				<cfreturn ss/>
			<cfelse>
				<cfreturn session[getSessionStoreName()]/>
			</cfif>
		</cflock>
	</cffunction>

	<cffunction name="getSessionStoreName" returntype="string" access="private" output="false">
		<cfif variables.sessionStoreName eq "">
			<cfreturn "SessionStore"/>
		<cfelse>
			<cfreturn variables.sessionStoreName/>
		</cfif>
	</cffunction>
	<cffunction name="setSessionStoreName" returntype="void" access="public" output="false">
		<cfargument name="sessionStoreName" type="string" required="true"/>
		<cfset variables.sessionStoreName = arguments.sessionStoreName/>
	</cffunction>

</cfcomponent>