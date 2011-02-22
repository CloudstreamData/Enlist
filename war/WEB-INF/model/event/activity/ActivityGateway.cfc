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
	
	
    <!--- DEPENDENCIES --->
    <cffunction name="getEventService" access="public" returntype="Enlist.model.event.EventService" output="false">
        <cfreturn variables.eventService />
    </cffunction> 
    <cffunction name="setEventService" access="public" returntype="void" output="false">
        <cfargument name="eventService" type="Enlist.model.event.EventService" required="true" /> 
        <cfset variables.eventService = arguments.eventService />
    </cffunction>
	
	<cffunction name="getUserService" returntype="Enlist.model.user.UserService" access="public" output="false">
		<cfreturn variables.userService />
	</cffunction>
	<cffunction name="setUserService" returntype="void" access="public" output="false">
		<cfargument name="userService" type="Enlist.model.user.UserService" required="true" />
		<cfset variables.userService = arguments.userService />
	</cffunction>
	
	<cffunction name="getActivity" access="public" returntype="Enlist.model.event.activity.Activity" output="false">
		<cfargument name="id" type="string" required="false" default="">
		
		<cfset var activities = 0 />
		<cfset var activity = 0 />

		<cfif NOT Len(arguments.id)>
			<cfset activity = createObject("component", "Enlist.model.event.activity.Activity").init( argumentCollection = arguments ) />
		<cfelse>
			<cfset activities = GoogleQuery("select from activity where id == '#arguments.id#'") />
			<cfset activity = activity[ 1 ] />
		</cfif>
		
		<cfset activity.setEvent( getEventService().getEvent( activity.getEventId() ) ) />
		
		<cfreturn activity />
	</cffunction> 
	
	<cffunction name="getActivities" access="public" returntype="array" output="false">
		<cfset var activities = googleQuery( "select from activity" ) />
		<cfset var activity = "" />
		<cfloop array="#activities#" index="activity">
			<cfset activity.setEvent( getEventService().getEvent( activity.getEventId() ) ) />
		</cfloop>
		<cfreturn activities />
	</cffunction>
	
	

	<cffunction name="getActivityVolunteerHistoryByUser" returntype="Enlist.model.event.activity.ActivityVolunteer[]" access="public" output="false">
		<cfargument name="userId" type="numeric" required="true" />
		<cfset var volunteerActivities = GoogleQuery("select from activityvolunteer where userid == '#arguments.userId#'") />
		<cfset var volunteerActivity = "" />
		<cfset var user = getUserService().getUser( volunteerActivity.getUserId() ) />
		<cfloop array="#volunteerActivities#" index="volunteerActivity">
			<cfset volunteerActivity.setEvent( getEventService().getEvent( volunteerActivity.getEventId() ) ) />
			<cfset volunteerActivity.setUser( user ) />
		</cfloop>
		<cfreturn volunteerActivities />
	</cffunction>

	
	<cffunction name="saveActivity" access="public" returntype="void" output="false">
		<cfargument name="activity" type="Enlist.model.event.activity.Activity" required="true">

		<cfset var key = "" />
		
		<cfif activity.getID() eq "">
			<cfset activity.setID( createUUID() ) />
		<cfelse>
			<cfset googleDelete( arguments.activity ) />
		</cfif>
		<cfset key = arguments.activity.googleWrite( "activity" ) />
	</cffunction> 
	


    <!--- 
	PRIVATE 
	--->
<!---     <cffunction name="setEventFromEventStub" access="private" output="false" returntype="void">
	   <cfargument name="activity" type="Enlist.model.event.activity.Activity" required="true" />
        <!--- The base Activity class comes back with an Event instance that *should* be populated with an ID.  This will populated it with an instance of the Event of that ID --->
        <cfif Len(arguments.activity.getEvent().getId()) >
           <cfset arguments.activity.setEvent( getEventService().getEvent( arguments.activity.getId() ) ) />
        </cfif>     
		<cfreturn />
	</cffunction> --->
</cfcomponent>