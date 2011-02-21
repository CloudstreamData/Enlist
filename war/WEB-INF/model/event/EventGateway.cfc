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
	
	<cffunction name="getEvent" access="public" returntype="Enlist.model.event.Event" output="false">
		<cfargument name="eventID" type="string" required="false" default="">
		
		<cfset var events = 0 />
		<cfset var event = 0 />
		
		<cfif NOT Len(arguments.eventID)>
			<cfset event = createObject("component", "Enlist.model.event.Event").init() />
		<cfelse>
			<cfset events = GoogleQuery("select from event where id == '#arguments.eventID#'") />
			<cfset event = events[1] />
		</cfif>
		
		<cfreturn event />
	</cffunction> 
	
	<cffunction name="getEvents" access="public" returntype="array" output="false">
		<cfreturn googleQuery("select from event") />
	</cffunction>

	<cffunction name="saveEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="Enlist.model.event.Event" required="true">

		<cfset var key = "" />
		
		<cfif event.getID() eq "">
			<cfset event.setID(createUUID()) />
		<cfelse>
			<cfset googleDelete(arguments.event) />
		</cfif>
		<cfset key = arguments.event.googleWrite("event") />
	</cffunction> 
	
</cfcomponent>