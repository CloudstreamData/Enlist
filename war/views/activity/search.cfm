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
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset copyToScope("${event.events}") />
	
	<view:meta type="title" content="Search Activities" />

	<view:script>
		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</view:script>
</cfsilent>
<cfoutput>
	
<h3>Search Activities</h3>
<form:form actionEvent="activity.doSearch">
	<table>
		<tr>
			<th>Event</th>
			<td>
				<form:select path="eventId" items="#variables.events#">
					<form:option value="" label="Choose an event" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th>Title</th>
			<td><form:input path="title" size="40" maxlength="200" /></td>
		</tr>
 		<tr>
			<th>Description</th>
			<td><form:input path="description" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Number of People</th>
			<td><form:input path="numPeople" size="40" maxlength="4" /></td>
		</tr>
		<tr>
			<th>Start Date</th>
			<td><form:input path="startDate" size="40" maxlength="10" /></td>
		</tr>
		<tr>
			<th>End Date</th>
			<td><form:input path="endDate" size="40" maxlength="10" /></td>
		</tr>
		<tr>
			<th>Point Hours</th>
			<td><form:input path="pointHours" size="40" maxlength="4" /></td>
		</tr>
		<tr>
			<th>Location</th>
			<td><form:input path="location" size="40" maxlength="20" /></td>
		</tr>
		<tr>
			<td></td>
			<td><form:button type="submit" name="search" value="Search" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>