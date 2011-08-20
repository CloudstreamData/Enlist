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
	<view:meta type="title" content="Register" />
	
	<cfset copyToScope("states=${properties.usStates},${event.chapters},${event.user},${event.googleEmail}") />
	<cfset variables.user.setgoogleEmail(googleEmail) />
	
	<view:script>
	$(document).ready(function(){
		$("#registerForm").validate();
	});
</view:script>
</cfsilent>
<cfoutput>
<h2>Register</h2>

<tags:displaymessage />

<!--- Output any errors if we have some --->
<tags:displayerror />

<form:form actionEvent="register_process" bind="user" id="registerForm">
	<table>
		<tr>
			<th style="width:40%;"><label id="firstName">First Name *</label></th>
			<td style="width:60%;"><form:input path="firstName" size="40" maxlength="200"  class="required" /></td>
		</tr>
		<tr>
			<th><label id="lastName">Last Name *</label></th>
			<td><form:input path="lastName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="phone">Phone</label></th>
			<td><form:input path="phone" size="40" maxlength="40" /></td>
		</tr>
		<tr>
			<th><label id="address1">Address 1</label></th>
			<td><form:input path="address1" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="address2">Address 2</label></th>
			<td><form:input path="address2" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="city">City</label></th>
			<td><form:input path="city" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="state">State / Zip</label></th>
			<td>
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="--" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</td>
		</tr>
		<tr>
			<th><label id="altEmail">Alternative Email</label></th>
			<td>
				<form:input path="altEmail" size="40" maxlength="200" />
				<p>An additional non-Google email to use for email communications.</p>
			</td>
		</tr>
		<cfif ArrayLen( chapters )>
			<tr>
				<th><label id="chapterId">Chapter</label></th>
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
			<td><form:hidden name="googleEmail" path="googleEmail" /></td>
			<td><form:button type="submit" name="save" value="Save Registration Info" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>