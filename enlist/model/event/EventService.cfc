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
--->
<cfcomponent
	displayname="EventService"
	output="false"
	extends="enlist.model.BaseService">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="EventService" output="false"
		hint="Initializes the service.">

		<cfset super.init(argumentcollection = arguments) />

		<cfreturn this />
	</cffunction>
	
	<cffunction name="setEventGateway" access="public" returntype="void" output="false">
		<cfargument name="EventGateway" type="enlist.model.event.EventGateway" required="yes" />
		<cfset variables.EventGateway = arguments.EventGateway />
	</cffunction>
	<cffunction name="getEventGateway" access="public" returntype="enlist.model.event.EventGateway" output="false">
		<cfreturn variables.EventGateway />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getEvent" access="public" returntype="enlist.model.event.Event" output="false">
		<cfargument name="eventID" type="numeric" required="false" default="0" />
		<cfreturn getEventGateway().read(arguments.eventID) />
	</cffunction>

	<cffunction name="getEvents" access="public" returntype="query" output="false">
		<cfreturn getEventGateway().getEvents() />
	</cffunction>

	<cffunction name="getEventsAsStruct" output="false" access="public" returntype="struct"
		hint="This method returns a struct of ID:Name for use in the form:select tag">

		<cfset var events = StructNew() />
		<cfset var thisEvent = "" />

		<cfloop array="#getEvents()#" index="thisEvent">
			<cfset events[ thisEvent.getId() ] = thisEvent.getName() />
		</cfloop>

		<cfreturn events />
	</cffunction>

	<cffunction name="saveEvent" access="public" returntype="any" output="false">
		<cfargument name="event" type="enlist.model.event.Event" required="true">
		<cfset var errors = arguments.event.validate() />
		<cfif (structIsEmpty(errors))>
			<cfset getEventGateway().saveEvent(arguments.event) />
		</cfif>
		<cfreturn errors />
	</cffunction>

	<cffunction name="getEventsBySearch" access="public" returntype="array" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="location" type="string" required="false" deafult="" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />
		<cfreturn getGateway().listByPropertyMap( arguments ) />
	</cffunction>

</cfcomponent>