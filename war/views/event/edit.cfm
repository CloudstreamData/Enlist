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
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset statuses = getProperty("eventStatuses") />
</cfsilent>
<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>
</cfif>
</cfoutput>

<cfsavecontent variable="js">
	<script>
		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</script>

</cfsavecontent>
<cfhtmlhead text="#js#">

<form:form actionEvent="event.save" bind="event" id="eventForm">
	<table>
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Location:</th>
			<td><form:input path="location" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Start Date:</th>
			<td><form:input path="startDate" id="startDate" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">End Date:</th>
			<td><form:input path="endDate" id="endDate" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Status:</th>
			<td><form:select path="status" items="#statuses#" class="required">
				<form:option value="" label="Choose a status" />
			</form:select></td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Event" /></td>
		</tr>
	</table>
</form:form>
<script>
	$(document).ready(function(){
		jQuery.validator.addMethod("greaterThan", function(value, element, params) {
			if (!/Invalid|NaN/.test(new Date(value))) {
				return new Date(value) > new Date($(params).val());
			}
			return isNaN(value) && isNaN($(params).val()) || (parseFloat(value) > parseFloat($(params).val()));
		},'Must be greater than {0}.');
		$("#eventForm").validate();
		$("#endDate").rules("add", {greaterThan: "#startDate"});
	});
</script>