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
<cfcomponent output="false">

	<cfset variables.id = "">
	<cfset variables.name = "">
	<cfset variables.startDate = "">
	<cfset variables.endDTate = "">
	<cfset variables.location = "">
	<cfset variables.status = "">
	
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

	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfreturn variables />	
	</cffunction>
	<cffunction name="setInstanceMemento" access="private" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true" />
		<cfset setId(data.id) />
		<cfset setName(data.name) />
		<cfset setStartDate(data.startDate) />
		<cfset setEndDate(data.endDate) />
		<cfset setLocation(data.location) />
		<cfset setStatus(data.status) />
 	</cffunction>
 
 	<cffunction name="getId" access="public" returntype="string" output="false"> 
	 	<cfif variables.id eq "">
	     	<cfreturn googleKey(this) />     
	 	<cfelse>
		 	<cfreturn variables.id />
	 	</cfif>    
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
     	<cfset variables.name = arguments.name />     
     </cffunction>
     
     <cffunction name="getstartDate" access="public" returntype="string" output="false">     
     	<cfreturn variables.startDate />     
     </cffunction>     
     <cffunction name="setstartDate" access="public" returntype="void" output="false">     
     	<cfargument name="startDate" type="string" required="true" />     
     	<cfset variables.startDate = arguments.startDate />     
     </cffunction>
	
	<cffunction name="getendDate" access="public" returntype="string" output="false">        
    	<cfreturn variables.endDate />        
    </cffunction>        
    <cffunction name="setendDate" access="public" returntype="void" output="false">        
    	<cfargument name="endDate" type="string" required="true" />        
    	<cfset variables.endDate = arguments.endDate />        
    </cffunction>
    
    <cffunction name="getlocation" access="public" returntype="string" output="false">    
    	<cfreturn variables.location />    
    </cffunction>    
    <cffunction name="setlocation" access="public" returntype="void" output="false">    
    	<cfargument name="location" type="string" required="true" />    
    	<cfset variables.location = arguments.location />    
    </cffunction>
    
    <cffunction name="getstatus" access="public" returntype="string" output="false">    
    	<cfreturn variables.status />    
    </cffunction>    
    <cffunction name="setstatus" access="public" returntype="void" output="false">    
    	<cfargument name="status" type="string" required="true" />    
    	<cfset variables.status = arguments.status />    
    </cffunction>
	
</cfcomponent>