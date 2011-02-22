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
	displayname="Event" 
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.id = "" />
	<cfset variables.name = "" />
	<cfset variables.startDate = "" />
	<cfset variables.endDate = "" />
	<cfset variables.location = "" />
	<cfset variables.status = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Enlist.model.event.Event" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />

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
		<cfset setStartDate(arguments.data.startDate) />
		<cfset setEndDate(arguments.data.endDate) />
		<cfset setLocation(arguments.data.location) />
		<cfset setStatus(arguments.data.status) />
 	</cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structnew() />
		<cfset var fieldname = "" />
		
		<cfloop list="id,name,startdate,enddate,location,status" index="fieldname">
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
     
     <cffunction name="getstartDate" access="public" returntype="string" output="false">     
     	<cfreturn variables.startDate />     
     </cffunction>     
     <cffunction name="setstartDate" access="public" returntype="void" output="false">     
     	<cfargument name="startDate" type="string" required="true" />     
     	<cfset variables.startDate = Trim(arguments.startDate) />     
     </cffunction>
	
	<cffunction name="getendDate" access="public" returntype="string" output="false">        
    	<cfreturn variables.endDate />        
    </cffunction>        
    <cffunction name="setendDate" access="public" returntype="void" output="false">        
    	<cfargument name="endDate" type="string" required="true" />        
    	<cfset variables.endDate = Trim(arguments.endDate) />        
    </cffunction>
    
    <cffunction name="getlocation" access="public" returntype="string" output="false">    
    	<cfreturn variables.location />    
    </cffunction>    
    <cffunction name="setlocation" access="public" returntype="void" output="false">    
    	<cfargument name="location" type="string" required="true" />    
    	<cfset variables.location = Trim(arguments.location) />    
    </cffunction>
    
    <cffunction name="getstatus" access="public" returntype="string" output="false">    
    	<cfreturn variables.status />    
    </cffunction>    
    <cffunction name="setstatus" access="public" returntype="void" output="false">    
    	<cfargument name="status" type="string" required="true" />    
    	<cfset variables.status = Trim(arguments.status) />    
    </cffunction>
	
</cfcomponent>