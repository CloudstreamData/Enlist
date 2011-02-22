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
    displayname="Activity" 
    output="false">
	
	<!--- PROPERTIES --->
	<cfproperty name="id" type="string" />
	<cfproperty name="name" type="string" />
	<cfproperty name="description" type="string" />
	<cfproperty name="event" type="Enlist.model.event.Event" />


    
    <cfset variables.id = "" />
	<cfset variables.name = "" />
	<cfset variables.description = "" />
	<cfset variables.eventId = "" />



    <!---
    INITIALIZATION / CONFIGURATION
    --->
    <cffunction name="init" access="public" output="false" returntype="Enlist.model.event.activity.Activity">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="event" type="Enlist.model.event.Event" required="true" />

        <cfset setInstanceMemento(arguments) />	
	   
	   <cfreturn this />
	</cffunction>
	
	
    <!---
    PUBLIC FUNCTIONS
    --->
    <cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
        <cfargument name="data" type="struct" required="true" />    
        <cfset setId( arguments.data.id ) />
        <cfset setName( arguments.data.name ) />
        <cfset setDescription( arguments.data.description ) />
        <cfset setEvent( arguments.data.event ) />
    </cffunction>
    <cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
        <cfset var data = structnew() />
        <cfset var fieldname = "" />
        
        <cfloop list="id,name,description,eventid" index="fieldname">
            <cfset data[fieldname] = variables[fieldname]>
        </cfloop>
        
        <cfreturn data />   
    </cffunction>	
	
	
    <!---
    ACCESSORS/MUTATORS
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
        <cfset variables.name = arguments.name />   
     </cffunction>	
	
    <cffunction name="getDescription" access="public" returntype="string" output="false">        
        <cfreturn variables.description />
     </cffunction>     
     <cffunction name="setDescription" access="public" returntype="void" output="false">     
        <cfargument name="description" type="string" required="true" />     
        <cfset variables.description = arguments.description />   
     </cffunction>	
	
    <cffunction name="getEvent" access="public" returntype="Enlist.model.event.Event" output="false">        
        <cfreturn variables.event />
     </cffunction>     
     <cffunction name="setEvent" access="public" returntype="void" output="false">     
        <cfargument name="event" type="Enlist.model.event.Event" required="true" />    
		<cfset variables.event = arguments.event /> 
        <cfset variables.eventId = arguments.event.getId() />   
     </cffunction>  
	
	<cffunction name="getEventId" access="public" output="false" returntype="string">
		<cfreturn variables.eventId />
	</cffunction>
	
</cfcomponent>	