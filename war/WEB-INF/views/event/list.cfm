<cfimport prefix="view" taglib="/MachII/customtags/view">

<cfset events = event.getArg("events")>

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