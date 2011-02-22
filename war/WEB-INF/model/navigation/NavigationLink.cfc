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
	displayname="NavigationLink" 
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.id = "" />
	<cfset variables.name = "" />
	<cfset variables.event = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Enlist.model.navigation.NavigationLink" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="event" type="string" required="false" default="" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true" />	
		<cfset setId(arguments.data.id) />
		<cfset setName(arguments.data.name) />
		<cfset setEvent(arguments.data.event) />
 	</cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structnew() />
		<cfset var fieldname = "" />
		
		<cfloop list="id,name,event" index="fieldname">
			<cfset data[fieldname] = variables[fieldname] />
		</cfloop>
		
		<cfreturn data />	
	</cffunction>
	
	<!---
	ACCESSORS
	--->
 	<cffunction name="getId" access="public" returntype="string" output="false">	 	
		<cfreturn variables.id />
     </cffunction>     
     <cffunction name="setId" access="public" returntype="void" output="false">     
     	<cfargument name="id" type="string" required="true" />     
     	<cfset variables.id = arguments.id />   
     </cffunction>
     
     <cffunction name="getName" access="public" returntype="string" output="false">     
     	<cfreturn variables.name />     
     </cffunction>     
     <cffunction name="setName" access="public" returntype="void" output="false">     
     	<cfargument name="name" type="string" required="true" />     
     	<cfset variables.name = Trim(arguments.name) />
     </cffunction>
     
     <cffunction name="getEvent" access="public" returntype="string" output="false">     
     	<cfreturn variables.startDate />     
     </cffunction>     
     <cffunction name="setEvent" access="public" returntype="void" output="false">     
     	<cfargument name="startDate" type="string" required="true" />     
     	<cfset variables.startDate = Trim(arguments.startDate) />     
     </cffunction>
	
</cfcomponent>