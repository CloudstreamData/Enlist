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
	<cfset copyToScope("${event.events}") />
	
	<cfif event.getName() EQ "event.doSearch">
		<cfset variables.title = "Event Search Results" />
	<cfelse>
		<cfset variables.title = "List Events" />
	</cfif>
	<view:meta type="title" content="#variables.title#" />
	
	<view:asset package="jquery-tablesorter" />
	<view:script>
		$(document).ready(function() {
				$("#eventList").tablesorter( { widgets: ['zebra'], headers: { 5:{sorter: false}}} );
			}
		);
	</view:script>
</cfsilent>
<cfoutput>
<p><view:a event="event.edit">Create a new event</view:a></p>

<h3>#variables.title#</h3>

<table id="eventList" class="tablesorter">
	<thead>
		<tr>
			<th>Status</th>
			<th>Event</th>
			<th>Start Date</th>
			<th>End Date</th>
			<th>Location</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#variables.events#" index="thisEvent">
			<tr>
				<td>#variables.thisEvent.getStatus()#</td>
				<td>#variables.thisEvent.getName()#</td>
				<td>#variables.thisEvent.getStartDate()#</td>
				<td>#variables.thisEvent.getEndDate()#</td>
				<td>#variables.thisEvent.getLocation()#</td>
				<td>
					<view:a event="event.edit" p:id="#variables.thisEvent.getID()#">Edit</view:a> | 
					<view:a event="activity.doSearch" p:eventId="#variables.thisEvent.getID()#">Activities</view:a>
				</td>
			</tr>	
		</cfloop>
	</tbody>
</table>

<p><view:a event="event.edit">Create a new event</view:a></p>
</cfoutput>