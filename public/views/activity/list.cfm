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
	
	$Id$
	
	Notes:
	--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("${event.activities}") />	
	
	<cfif event.getName() EQ "activity.doSearch">
		<cfset variables.title = "Activities Search Results" />
	<cfelse>
		<cfset variables.title = "List Activities" />
	</cfif>
	<view:meta type="title" content="#variables.title#" />

</cfsilent>
<cfoutput>
<p><view:a event="activity.edit">Create a new activity</view:a></p>

<h3>#variables.title#</h3>
<table>
	<tr>
		<th>Title</th>
		<th>Number of People</th>
		<th>Start Date</th>
		<th>End Date</th>
		<th>Point Hours</th>
		<th>Location</th>
		<th>Event</th>
		<th>Actions</th>
	</tr>
	<cfloop array="#variables.activities#" index="activity">
		<tr>
			<td>#variables.activity.getTitle()#</td>
			<td>#variables.activity.getNumPeople()#</td>
			<td>#variables.activity.getStartDate()#</td>
			<td>#variables.activity.getEndDate()#</td>
			<td>#variables.activity.getPointHours()#</td>
			<td>#variables.activity.getLocation()#</td>
			<td>#variables.activity.getEvent().getName()#</td>
			<td><view:a event="activity.edit" p:id="#variables.activity.getId()#" label="Edit" /></td>
		</tr>	
	</cfloop>
</table>

<p><view:a event="activity.edit">Create a new activity</view:a></p>
</cfoutput>