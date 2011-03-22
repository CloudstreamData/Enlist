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
<cfcomponent output="false">
	
	<!---
	PROPERTIES
	--->
	<cfproperty name="id" type="string" />
	<cfproperty name="user" type="enlist.model.user.User" />
	<cfproperty name="activity" type="enlist.model.event.activity.Activity" />
	<cfproperty name="volunteeredOn" type="date" />
	<cfproperty name="scheduledStart" type="string" />
	<cfproperty name="scheduledEnd" type="string" />
	<cfproperty name="cancelledOn" type="string" />
	<cfproperty name="actualHours" type="numeric" />
	<cfproperty name="actualBones" type="numeric" />
	<cfproperty name="status" type="string" />
	
	<cfset variables.id = "" />
	<cfset variables.userId = "" />
	<cfset variables.activityId = "" />
	<cfset variables.volunteeredOn = "" />
	<cfset variables.scheduledStart = "" />
	<cfset variables.scheduledEnd = "" />
	<cfset variables.cancelledOn = "" />
	<cfset variables.actualHours = "" />
	<cfset variables.actualBones = "" />
	<cfset variables.status = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="enlist.model.event.activity.ActivityVolunteer" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="volunteeredOn" type="string" required="false" default="" />
		<cfargument name="scheduledStart" type="string" required="false" default="" />
		<cfargument name="scheduledEnd" type="string" required="false" default="" />
		<cfargument name="cancelledOn" type="string" required="false" default="" />
		<cfargument name="actualHours" type="string" required="false" default="" />
		<cfargument name="actualBones" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />
		<cfargument name="user" type="enlist.model.user.User" required="false" />
		<cfargument name="activity" type="enlist.model.event.activity.Activity" required="false" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
	</cffunction>


	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true" />	
		<cfset setId( arguments.data.id ) />
		<cfset setVolunteeredOn( arguments.data.volunteeredOn ) />
		<cfset setScheduledStart( arguments.data.scheduledStart ) />
		<cfset setScheduledEnd( arguments.data.scheduledEnd ) />
		<cfset setCancelledOn( arguments.data.cancelledOn ) />
		<cfset setActualHours( arguments.data.actualHours ) />
		<cfset setActualBones( arguments.data.actualBones ) />
		<cfset setStatus( arguments.data.status ) />
		<cfif structKeyExists( arguments.data, "user")>
			<cfset setUser( arguments.data.user ) />
		</cfif>
		<cfif structKeyExists( arguments.data, "activity")>
			<cfset setActivity( arguments.data.activity ) />
		</cfif>
	</cffunction>
	
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structnew() />
		<cfset var fieldname = "" />
		
		<cfloop list="id,userId,eventId,volunteeredOn,scheduledStart,scheduledStart,cancelledOn,actualHours,actualBones,status" index="fieldname">
			<cfset data[fieldname] = variables[fieldname]>
		</cfloop>
		
		<cfreturn data />	
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setId" returntype="void" access="public" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = arguments.id />
	</cffunction>
	
	<cffunction name="getId" returntype="string" access="public" output="false">
		<cfreturn variables.id />
	</cffunction>
	
	
	<cffunction name="setUserId" returntype="void" access="public" output="false">
		<cfargument name="userId" type="string" required="true" />
		<cfset variables.userId = arguments.userId />
	</cffunction>
	
	<cffunction name="getUserId" returntype="string" access="public" output="false">
		<cfreturn variables.userId />
	</cffunction>
	
	
	<cffunction name="setUser" returntype="void" access="public" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true" />
		<cfset variables.user = arguments.user />
		<cfset variables.userId = arguments.user.getId() />
	</cffunction>
		
	<cffunction name="getUser" returntype="enlist.model.user.User" access="public" output="false">
		<cfreturn variables.user />
	</cffunction>
	
	
	<cffunction name="setActivityId" returntype="void" access="public" output="false">
		<cfargument name="activityId" type="string" required="true" />
		<cfset variables.activityId = arguments.activityId />
	</cffunction>
		
	<cffunction name="getActivityId" returntype="string" access="public" output="false">
		<cfreturn variables.activityId />
	</cffunction>
	
	<cffunction name="setActivity" returntype="void" access="public" output="false">
		<cfargument name="activity" type="enlist.model.event.activity.Activity" required="true" />
		<cfset variables.activity = arguments.activity />
		<cfset variables.activityId = arguments.activity.getId() />
	</cffunction>
		
	<cffunction name="getActivity" returntype="enlist.model.event.activity.Activity" access="public" output="false">
		<cfreturn variables.activity />
	</cffunction>
	
	
	<cffunction name="setVolunteeredOn" returntype="void" access="public" output="false">
		<cfargument name="volunteeredOn" type="string" required="true" />
		<cfset variables.volunteeredOn = arguments.volunteeredOn />
	</cffunction>
		
	<cffunction name="getVolunteeredOn" returntype="string" access="public" output="false">
		<cfreturn variables.volunteeredOn />
	</cffunction>
	
	
	<cffunction name="setScheduledStart" returntype="void" access="public" output="false">
		<cfargument name="scheduledStart" type="string" required="true" />
		<cfset variables.scheduledStart = arguments.scheduledStart />
	</cffunction>
		
	<cffunction name="getScheduledStart" returntype="string" access="public" output="false">
		<cfreturn variables.scheduledStart />
	</cffunction>
	
	
	<cffunction name="setScheduledEnd" returntype="void" access="public" output="false">
		<cfargument name="scheduledEnd" type="string" required="true" />
		<cfset variables.scheduledEnd = arguments.scheduledEnd />
	</cffunction>
		
	<cffunction name="getScheduledEnd" returntype="string" access="public" output="false">
		<cfreturn variables.scheduledEnd />
	</cffunction>
	
	
	<cffunction name="setCancelledOn" returntype="void" access="public" output="false">
		<cfargument name="cancelledOn" type="string" required="true" />
		<cfset variables.cancelledOn = arguments.cancelledOn />
	</cffunction>
		
	<cffunction name="getCancelledOn" returntype="string" access="public" output="false">
		<cfreturn variables.cancelledOn />
	</cffunction>

	
	<cffunction name="setActualHours" returntype="void" access="public" output="false">
		<cfargument name="actualHours" type="string" required="true" />
		<cfset variables.actualHours = arguments.actualHours />
	</cffunction>
		
	<cffunction name="getActualHours" returntype="string" access="public" output="false">
		<cfreturn variables.actualHours />
	</cffunction>
	
	
	<cffunction name="setActualBones" returntype="void" access="public" output="false">
		<cfargument name="actualBones" type="string" required="true" />
		<cfset variables.actualBones = arguments.actualBones />
	</cffunction>
		
	<cffunction name="getActualBones" returntype="string" access="public" output="false">
		<cfreturn variables.actualBones />
	</cffunction>
	
	
	<cffunction name="setStatus" returntype="void" access="public" output="false">
		<cfargument name="status" type="string" required="true" />
		<cfset variables.status = arguments.status />
	</cffunction>
		
	<cffunction name="getStatus" returntype="string" access="public" output="false">
		<cfreturn variables.status />
	</cffunction>
	
</cfcomponent>