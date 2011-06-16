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
	<cfimport prefix="tags" taglib="/customtags" />
	<cfset copyToScope("${event.activity},${event.events}") />

	<cfif NOT Len(variables.activity.getId())>
		<cfset variables.type = "New" />
		<view:meta type="title" content="New Activity" />
	<cfelse>
		<cfset variables.type = "Edit" />
		<view:meta type="title" content="Edit Activity | #variables.activity.getTitle()#" />
	</cfif>

	<view:script>
		$(document).ready(function(){
			jQuery.validator.addMethod("greaterThanEqual", function(value, element, params) {
				if (!/Invalid|NaN/.test(new Date(value))) {
					return new Date(value) > new Date($(params).val());
				}
				return isNaN(value) && isNaN($(params).val()) || (parseFloat(value) > parseFloat($(params).val()));
			},'Must be greater than or equal to {0}.');
			$("#actForm").validate();
			$("#endDate").rules("add", {greaterThanEqual: "#startDate"});
		});

		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</view:script>
</cfsilent>
<cfoutput>
<tags:displaymessage />
<tags:displayerror />

<h3>#variables.type# Activity</h3>

<form:form actionEvent="activity.save" bind="activity" id="actForm">
	<table>
		<tr>
			<th>Event</th>
			<td>
				<form:select path="eventId" items="#variables.events#" bind="#variables.activity.getEvent().getId()#" class="required">
					<form:option value="" label="Choose an event" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th>Title</th>
			<td><form:input path="title" size="40" maxlength="200" class="required" /></td>
		</tr>
 		<tr>
			<th>Description</th>
			<td><form:textarea path="description" style="width:100%;"/></td>
		</tr>
		<tr>
			<th>Number of People</th>
			<td><form:input path="numPeople" size="40" maxlength="4" class="required" /></td>
		</tr>
		<tr>
			<th>Start Date</th>
			<td><form:input path="startDate" size="40" maxlength="10" class="required date" /></td>
		</tr>
		<tr>
			<th>End Date</th>
			<td><form:input path="endDate" size="40" maxlength="10" class="required date" /></td>
		</tr>
		<tr>
			<th>Point Hours</th>
			<td><form:input path="pointHours" size="40" maxlength="4" class="required" /></td>
		</tr>
		<tr>
			<th>Location</th>
			<td><form:input path="location" size="40" maxlength="20" class="required" /></td>
		</tr>
		<tr>
			<td><form:hidden path="id" /></td>
			<td><form:button type="submit" name="save" value="Save Activity" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>