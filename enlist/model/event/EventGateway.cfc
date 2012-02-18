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
<!--- TODO: I don't think this is being used anymore now that EventService leverages 
			the generic service/gateway stuff --->
<cfcomponent output="false">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.dao = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="EventGateway" output="false"
		hint="Initializes the gateway.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getEvent" access="public" returntype="enlist.model.event.Event" output="false">
		<cfargument name="eventID" type="string" required="false" default="">
		<cfreturn read( arguments.eventID ) />
	</cffunction> 
	
	<cffunction name="getEvents" access="public" returntype="query" output="false">
		<cfargument name="Event_id" required="no" type="numeric" default="0">
		<cfargument name="name" required="no" type="string" default="">
		<cfargument name="startdate" required="no" type="string" default="">
		<cfargument name="enddate" required="no" type="string" default="">
		<cfargument name="location" required="no" type="string" default="">
		<cfargument name="status" required="no" type="string" default="">
		<cfset var qEvents = 0>
		<cfquery name="qEvents">
		SELECT id, name, startdate, enddate, location, status
		FROM event
		WHERE (1=1)
			<cfif arguments.Event_id neq "0">
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Event_id#"
								null="#yesnoformat(len(arguments.Event_id) eq 0)#"></cfif>
			<cfif arguments.name neq "">
				AND name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.name#%"
									null="#yesnoformat(len(arguments.name) eq 0)#" maxlength="100"></cfif>
			<cfif arguments.startdate neq "">
				AND startdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.startdate#"
									null="#yesnoformat(len(arguments.startdate) eq 0)#"></cfif>
			<cfif arguments.enddate neq "">
				AND enddate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.enddate#"
									null="#yesnoformat(len(arguments.enddate) eq 0)#"></cfif>
			<cfif arguments.location neq "">
				AND location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.location#"
									null="#yesnoformat(len(arguments.location) eq 0)#" maxlength="100"></cfif>
			<cfif arguments.status neq "">
				AND status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#"
								null="#yesnoformat(len(arguments.status) eq 0)#" maxlength="50"></cfif>
		</cfquery>
		<cfreturn qEvents>
	</cffunction>

	<cffunction name="saveEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="enlist.model.event.Event" required="true">
		<cfif arguments.Event.getID() neq 0>
			<cfset update(arguments.Event)>
		<cfelse>
			<cfset create(arguments.Event)>
		</cfif>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="Event" type="enlist.model.event.Event" required="yes">
		<cfset var data = Event.getInstanceMemento()>
		<cfset var newEvent = 0>
		<cftransaction>
		<cfquery name="newEvent">
		INSERT INTO event (name, startdate, enddate, location, status)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
				null="#yesnoformat(len(data.name) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#data.startdate#"
				null="#yesnoformat(len(data.startdate) eq 0)#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#data.enddate#"
				null="#yesnoformat(len(data.enddate) eq 0)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
				null="#yesnoformat(len(data.location) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#"
				null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">
		)
		</cfquery>
		<cfquery name="qMaxID">
		SELECT LAST_INSERT_ID() as maxID from event
		</cfquery>
		</cftransaction>
		<cfset Event.setId(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="Event" type="enlist.model.event.Event" required="yes">
		<cfset var data = Event.getInstanceMemento()>
		<cfset var updateEvent = 0>
		<cfquery name="updateEvent">
		UPDATE event
		SET 
			name = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
					null="#yesnoformat(len(data.name) eq 0)#" maxlength="100">,
			startdate = 
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#data.startdate#"
					null="#yesnoformat(len(data.startdate) eq 0)#">,
			enddate = 
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#data.enddate#"
					null="#yesnoformat(len(data.enddate) eq 0)#">,
			location = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
					null="#yesnoformat(len(data.location) eq 0)#" maxlength="100">,
			status = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#"
					null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="enlist.model.event.Event" output="false">
		<cfargument name="EventID" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var Event = 0>
		<cfset var readEvent = 0>
		<cfif arguments.eventID neq 0>
			<cfquery name="readEvent">
			SELECT id, name, startdate, enddate, location, status
			FROM event
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.EventID#" />
			</cfquery>
			<cfloop list="#readEvent.columnList#" index="field">
				<cfset 'data.#field#' = evaluate('readEvent.#field#')>
			</cfloop>
			<cfset Event = createObject("component", "enlist.model.event.Event").init(argumentcollection=data)>
		<cfelse>
			<cfset Event = createObject("component", "enlist.model.event.Event").init()>
		</cfif>
		<cfreturn Event>
	</cffunction>
		
	<!---
	ACCESSORS
	--->
	<cffunction name="getDAO" returntype="enlist.model.GenericDAO" access="public" output="false">
		<cfreturn variables.dao />
	</cffunction>
	<cffunction name="setDAO" returntype="void" access="public" output="false">
		<cfargument name="dao" type="enlist.model.GenericDAO" required="true" />
		<cfset variables.dao = arguments.dao />
	</cffunction>
	
</cfcomponent>