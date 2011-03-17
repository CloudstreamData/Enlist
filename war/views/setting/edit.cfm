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
	<cfimport prefix="form" taglib="/MachII/customtags/form">
</cfsilent>
<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>
</cfif>
</cfoutput>

<form:form actionEvent="setting.save" bind="setting" id="settingForm">
	<table>
		<tr>
			<th>Organization Name:</th>
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