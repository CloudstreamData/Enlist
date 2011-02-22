<cfimport prefix="view" taglib="/MachII/customtags/view">



<cfset activities = event.getArg("activities")>

<p><view:a event="activity.edit">Create a new activity</view:a></p>

<table>
<tr>
	<th>Activity</th>
	<th>Description</th>
	<th>Event</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(activities)#" index="i">
	<tr>
		<td>#activities[i].getName()#</td>
		<td>#activities[i].getDescription()#</td>
		<td>#activities[i].getEvent().getName()#</td>
	</tr>	
</cfloop> 
</cfoutput>
</table>

<p><view:a event="activity.edit">Create a new activity</view:a></p>