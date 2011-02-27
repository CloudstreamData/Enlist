<cfimport prefix="form" taglib="/MachII/customtags/form">
<cfset chapters = event.getArg("chapters") />

<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>
</cfif>
</cfoutput>
<form:form actionEvent="user.save" bind="user" id="userForm">
	<table>
		<tr>
			<th>First Name:</th>
			<td><form:input path="firstname" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Last Name:</th>
			<td><form:input path="lastname" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Google Email:</th>
			<td><form:input path="googleemail" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Alternative Email</th>
			<td><form:input path="altEmail" size="40" maxlength="200" /></td>
		</tr>
		<cfif arrayLen( chapters )>
			<tr>
				<th>Chapter</th>
				<td>
					<form:select path="chapterId">
						<cfloop from="1" to="#arrayLen(chapters)#" index="i">
							<form:option value="#chapters[i].getID()#" label="#chapters[i].getName()#" />
						</cfloop>
					</form:select>
				</td>
			</tr>
		</cfif>
		<tr>
			<th>Status:</th>
			<td>
				<form:select path="status">
					<form:option value="valid" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th>Role:</th>
			<td>
				<form:select path="role">
					<form:option label="Volunteer" value="volunteer" />
					<form:option label="Coordinator" value="coordinator" />
					<form:option label="Admin" value="admin" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save User" /></td>
		</tr>
	</table>
</form:form>
<script>
	$(document).ready(function(){
		$("#userForm").validate();
	});
</script>