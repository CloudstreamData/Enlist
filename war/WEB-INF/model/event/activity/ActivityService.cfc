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

	<!---
	PROPERTIES
	--->
	<cfset variables.activityGateway = "" />
	
	
    <!--- DEPENDENCIES --->
	<cffunction name="getActivityGateway" access="public" returntype="Enlist.model.event.activity.ActivityGateway" output="false">
		<cfreturn variables.activityGateway />
	</cffunction> 
	<cffunction name="setActivityGateway" access="public" returntype="void" output="false">
		<cfargument name="activityGateway" type="Enlist.model.event.activity.ActivityGateway" required="true" /> 
		<cfset variables.activityGateway = arguments.activityGateway />
	</cffunction> 
 
	<!---
	PUBLIC FUNCTIONS
	--->	
	<cffunction name="getActivity" access="public" returntype="Enlist.model.event.activity.Activity" output="false">
		<cfargument name="id" type="string" required="false" default="">
		<cfreturn getActivityGateway().getActivity( argumentCollection = arguments ) />
	</cffunction> 
	
	<cffunction name="getActivities" access="public" returntype="array" output="false">
		<cfreturn getActivityGateway().getActivities() />
	</cffunction>

	
	<cffunction name="getActivityVolunteerHistoryByUser" returntype="Enlist.model.event.ActivityVolunteer[]" access="public" output="false">
		<cfargument name="userId" type="numeric" required="true" />
		<cfreturn getActivityGateway().getActivityVolunteerHistoryByUser( arguments.userId ) />
	</cffunction>
	

	<cffunction name="saveActivity" access="public" returntype="void" output="false">
		<cfargument name="activity" type="Enlist.model.event.activity.Activity" required="true">
		<cfset getActivityGateway().saveActivity( arguments.activity ) />
	</cffunction> 
	
</cfcomponent>