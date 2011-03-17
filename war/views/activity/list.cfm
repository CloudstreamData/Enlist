<cfsilent>
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
	<cfimport prefix="view" taglib="/MachII/customtags/view">
	<cfset activities = event.getArg("activities")>
</cfsilent>
<p><view:a event="activity.edit">Create a new activity</view:a></p>

<table>
<tr>
	<th>Title</th>
	<th>Description</th>
	<th>Number of People</th>
	<th>Start Date</th>
	<th>End Date</th>
	<th>Point Hours</th>
	<th>Location</th>
	<th>Event</th>
	<th>Options</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(activities)#" index="i">
	<tr>
		<td>#activities[i].getTitle()#</td>
		<td>#activities[i].getDescription()#</td>
		<td>#activities[i].getNumPeople()#</td>
		<td>#activities[i].getStartDate()#</td>
		<td>#activities[i].getEndDate()#</td>
		<td>#activities[i].getPointHours()#</td>
		<td>#activities[i].getLocation()#</td>
		<td>#activities[i].getEvent().getName()#</td>
		<td><view:a event="activity.edit" p:id="#activities[i].getId()#" label="Edit" /></td>
	</tr>	
</cfloop> 
</cfoutput>
</table>

<p><view:a event="activity.edit">Create a new activity</view:a></p>