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
	displayname="GenericDAO"
	hint="Abstract all basic CRUD operations with Google data store here. This can be composed into gateway beans or extended by custom DAOs."
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.entityComponentPath = "" />
	<cfset variables.kind = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="entityComponentPath" type="string" required="true" hint="Component path for entity type (e.g., 'foo.model.user.User')." />
		<cfargument name="kind" type="string" required="false" hint="Google BigTable 'kind' for all CRUD operations of this gateway instance." />

		<cfset setEntityComponentPath( arguments.entityComponentPath ) />

		<cfif not structKeyExists( arguments, "kind" )>
			<cfset arguments.kind = listLast( arguments.entityComponentPath, "." )/>
		</cfif>
		<cfset setKind( arguments.kind ) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="entity" type="any" required="true" />
		<!--- Workaround: googleDelete(entity) does not work unless entity has been read from googleQuery() --->
		<cfset var readEntity = read( arguments.entity.getID() ) />
		<cfset googleDelete( readEntity ) />
	</cffunction>

	<cffunction name="list" access="public" returntype="array" output="false">
		<cfreturn googleQuery("select from #getKind()#") />
	</cffunction>

	<cffunction name="listByProperty" access="public" returntype="array" output="false">
		<cfargument name="propertyName" type="string" required="true" />
		<cfargument name="propertyValue" type="string" required="true" />
		<cfset var map = structNew() />
		<cfset map[ arguments.propertyName ] = arguments.propertyValue />
		<cfreturn googleQuery( "select from #getKind()# where #arguments.propertyName# == '#arguments.propertyValue#'" ) />
	</cffunction>

	<cffunction name="listByPropertyMap" access="public" returntype="array" output="false">
		<cfargument name="map" type="struct" required="true" hint="Property key/value pairs to filter on." />
		<cfreturn googleQuery( "select from #getKind()# #propertyMapToWhereClause( arguments.map )#" ) />
	</cffunction>

	<cffunction name="read" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn readByProperty( "id", arguments.id ) />
	</cffunction>

	<cffunction name="readByProperty" access="public" returntype="any" output="false">
		<cfargument name="propertyName" type="string" required="true" />
		<cfargument name="propertyValue" type="string" required="true" />
		<cfset var map = structNew() />
		<cfset map[ arguments.propertyName ] = arguments.propertyValue />
		<cfreturn readByPropertyMap( map ) />
	</cffunction>

	<cffunction name="readByPropertyMap" access="public" returntype="any" output="false">
		<cfargument name="map" type="struct" required="true" hint="Property key/value pairs to filter on." />

		<cfset var qryResult = googleQuery( "select from #getKind()# #propertyMapToWhereClause( arguments.map )#" ) />

		<cfif arrayLen( qryResult )>
			<cfreturn qryResult[1] />
		</cfif>

		<!--- return new/empty object, if no match --->
		<cfreturn createObject( "component", getEntityComponentPath() ).init() />
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="entity" type="any" required="true">

		<cfif arguments.entity.getID() eq "">
			<cfset arguments.entity.setID( createUUID() ) />
		<cfelse>
			<!--- This is a necessary workaround, because googleWrite() will not currently update, but always insert a new record: --->
			<cfset delete( arguments.entity ) />
		</cfif>

		<cfset googleWrite( arguments.entity ) />
	</cffunction>

	<!---
	PRIVATE FUNCTIONS
	--->
	<cffunction name="propertyMapToWhereClause" returntype="string" access="private" output="false">
		<cfargument name="map" type="struct" required="true" hint="Property key/value pairs to filter on." />
		<cfscript>
			var whereClause = "";
			var key = "";

			for ( key in arguments.map )
			{
				if ( len( arguments.map[ key ] ) )
				{
					if ( len( whereClause ) )
						whereClause = whereClause & " &&";
					else
						whereClause = "where";
					
					whereClause = whereClause & " #key# == '#trim( arguments.map[ key ] )#'";
				}
			}

			return whereClause;
		</cfscript>
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="getEntityComponentPath" returntype="string" access="public" output="false">
		<cfreturn variables.entityComponentPath />
	</cffunction>
	<cffunction name="setEntityComponentPath" returntype="any" access="public" output="false">
		<cfargument name="entityComponentPath" type="string" required="true" />
		<cfset variables.entityComponentPath = arguments.entityComponentPath />
		<cfreturn this />
	</cffunction>

	<cffunction name="getKind" returntype="string" access="public" output="false">
		<cfreturn variables.kind />
	</cffunction>
	<cffunction name="setKind" returntype="any" access="public" output="false">
		<cfargument name="kind" type="string" required="true" />
		<cfset variables.kind = arguments.kind />
		<cfreturn this />
	</cffunction>

</cfcomponent>