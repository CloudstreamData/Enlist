<cfimport prefix="view" taglib="/MachII/customtags/view">



<cfset activities = event.getArg("activities")>

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
	</tr>	
</cfloop> 
</cfoutput>
</table>

<p><view:a event="activity.edit">Create a new activity</view:a></p>