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
	displayname="EventListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="eventService">

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getEventsAsStruct" output="false" access="public" returntype="struct"
		hint="This method returns a struct of ID:Name for use in the form:select tag">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset var events = StructNew() />
		<cfset var thisEvent = "" />
		
		<cfloop array="#getEventService().getEvents()#" index="thisEvent">
			<cfset events[ thisEvent.getId() ] = thisEvent.getName() />
		</cfloop>
		
		<cfreturn events />
	</cffunction>
	
</cfcomponent>