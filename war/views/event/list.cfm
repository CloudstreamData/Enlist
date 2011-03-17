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
	<cfset events = event.getArg("events")>
</cfsilent>
<p><view:a event="event.edit">Create a new event</view:a></p>

<table>
<tr>
	<th>Event</th>
	<th>Start Date</th>
	<th>End Date</th>
	<th>Location</th>
	<th>Options</th>
	<th>Status</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(events)#" index="i">
	<tr>
		<td>#events[i].getName()#</td>
		<td>#events[i].getStartDate()#</td>
		<td>#events[i].getEndDate()#</td>
		<td>#events[i].getLocation()#</td>
		<td><view:a event="event.edit" p:id="#events[i].getID()#">Edit</view:a></td>
		<td>#events[i].getStatus()#</td>
	</tr>	
</cfloop> 
</cfoutput>
</table>

<p><view:a event="event.edit">Create a new event</view:a></p>