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
	<cfimport prefix="view" taglib="/MachII/customtags/view">
	<cfset copyToScope("${event.activityVolunteerEntities}") />
</cfsilent>
<cfoutput>
<table>
	<tr>
		<th>Activity</th>
		<th>Description</th>
		<th>Event</th>
		<th>Start</th>
		<th>End</th>
		<th>Action</th>
	</tr>
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
</table>
</cfoutput>