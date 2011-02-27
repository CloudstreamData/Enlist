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

<form:form actionEvent="activity.save" bind="activity">
	<form:hidden name="id" path="id" />
	<cfoutput>
	<table style="width: 100%">
		<tr>
			<th>Title:</th>
			<td><form:input path="title" size="40" maxlength="200" /></td>
		</tr>
 		<tr>
			<th>Description:</th>
			<td><form:input path="description" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Number of People:</th>
			<td><form:input path="numPeople" size="40" maxlength="4" /></td>
		</tr>
		<tr>
			<th>Start Date:</th>
			<td><form:input path="startDate" size="40" maxlength="10" /></td>
		</tr>
		<tr>
			<th>End Date:</th>
			<td><form:input path="endDate" size="40" maxlength="10" /></td>
		</tr>
		<tr>
			<th>Point Hours:</th>
			<td><form:input path="pointHours" size="40" maxlength="4" /></td>
		</tr>
		<tr>
			<th>Location:</th>
			<td><form:input path="location" size="40" maxlength="20" /></td>
		</tr>
		<tr>
			<th>Event:</th>
			<td>
				<form:select path="eventId" items="#event.getArg("events")#" bind="#event.getArg("activity").getEvent().getId()#">
				<form:option value="" label="Choose an event" />
				</form:select>
			</td>
		</tr> 
		<!--- TODO: Add dropdown of events --->
		<tr>
			<td></td>
			<td><form:button type="submit" name="save" value="Save Activity" /></td>
		</tr>
		</cfoutput>
	</table>
</form:form>