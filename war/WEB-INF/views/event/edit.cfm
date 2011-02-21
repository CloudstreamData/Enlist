<cfimport prefix="form" taglib="/MachII/customtags/form">

<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>	
</cfif>
GoogleKey(event) = '#GoogleKey(event.getarg("event"))#'<br />
event.id = '#event.getArg("event").getID()#'
	
</cfoutput>

<form:form actionEvent="event.save" bind="event">
	<form:hidden name="id" path="id" />
	<table style="width: 100%">
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" /></td>
			<th>Location:</th>
			<td><form:input path="location" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Start Date:</th>
			<td><form:input path="startDate" size="10" maxlength="200" /></td>
			<th nowrap="nowrap">End Date:</th>
			<td><form:input path="endDate" size="10" maxlength="200" /></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Event" /></td>
		</tr>
	</table>
</form:form>