<cfimport prefix="form" taglib="/MachII/customtags/form">

<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>	
</cfif>
</cfoutput>

<form:form actionEvent="event.save" bind="event">
	<form:hidden name="id" path="id" />
	<table style="width: 100%">
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" /></td>
			<th>Description:</th>
			<td><form:input path="description" size="40" maxlength="200" /></td>
		</tr>
		<!--- TODO: Add dropdown of events --->
		<tr>
			<td></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Activity" /></td>
		</tr>
	</table>
</form:form>