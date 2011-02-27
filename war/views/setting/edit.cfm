<cfimport prefix="form" taglib="/MachII/customtags/form">
<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>
</cfif>
</cfoutput>

<form:form actionEvent="setting.save" bind="setting" id="settingForm">
	<table>
		<tr>
			<th>Orginaztion Name:</th>
			<td><form:input path="orgName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Description:</th>
			<td><form:textarea path="orgDesc" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Address:</th>
			<td><form:textarea path="orgAddress" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Points Name:</th>
			<td><form:input path="pointName" size="10" maxlength="200"  class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Default Point Value:</th>
			<td><form:input path="defaultPointValue" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap">Send Emails:</th>
			<td><form:select path="sendEmail">
				<form:option value="true" label="Yes" />
				<form:option value="false" label="No" />
			</form:select></td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Setting" /></td>
		</tr>
	</table>
</form:form>
<script>
  $(document).ready(function(){
    $("#settingForm").validate();
  });
  </script>