<cfimport prefix="view" taglib="/MachII/customtags/view">

<cfset activityVolunteerEntities = event.getArg("activityVolunteerEntities")>

<table>
<tr>
	<th>Activity</th>
	<th>Description</th>
	<th>Event</th>
	<th>Start</th>
	<th>End</th>
	<th>Action</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(activityVolunteerEntities)#" index="i">
	<tr>
		<td>#activityVolunteerEntities[i].getActivity().getTitle()#</td>
		<td>#activityVolunteerEntities[i].getActivity().getDescription()#</td>
		<td>#activityVolunteerEntities[i].getActivity().getEvent().getName()#</td>
		<td>#dateFormat( activityVolunteerEntities[i].getScheduledStart(), "short" )#</td>
		<td>#dateFormat( activityVolunteerEntities[i].getScheduledEnd(), "short" )#</td>
		<td>
			<cfif isDate( activityVolunteerEntities[i].getActivity().getStartDate() ) AND dateCompare( activityVolunteerEntities[i].getActivity().getStartDate(), now(), "d") EQ 0>
				<cfif NOT len( activityVolunteerEntities[i].getScheduledStart() )>
					<view:a event="activityvolunteer.signin">Sign In</view:a>
				<cfelseif NOT len( activityVolunteerEntities[i].getScheduledEnd() )>
					<view:a event="activityvolunteer.signout">Sign Out</view:a>
				</cfif>
			</cfif>
		</td>
	</tr>
</cfloop> 
</cfoutput>
</table>
