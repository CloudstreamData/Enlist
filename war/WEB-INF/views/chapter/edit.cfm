<cfimport prefix="form" taglib="/MachII/customtags/form">

<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>
</cfif>
</cfoutput>
<form:form actionEvent="chapter.save" bind="chapter">
	<table>
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Location:</th>
			<td><form:input path="location" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Status:</th>
			<td>
				<form:select path="statusCode">
					<form:option value="Active" />
					<form:option value="Archive" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Chapter" /></td>
		</tr>
	</table>
</form:form>