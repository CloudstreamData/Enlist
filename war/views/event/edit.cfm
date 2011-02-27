<cfimport prefix="form" taglib="/MachII/customtags/form">

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
			<td><form:input path="startDate" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">End Date:</th>
			<td><form:input path="endDate" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Status:</th>
			<td><form:select path="status"  class="required">
				<form:option value="" label="Choose a status" />
				<form:option value="pending" label="Pending" />
				<form:option value="open" label="Open" />
				<form:option value="closed" label="Closed" />
				<form:option value="archived" label="Archived" />
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
		$("#eventForm").validate();
	});
</script>