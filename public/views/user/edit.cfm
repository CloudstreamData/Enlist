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

$Id: edit.cfm 186 2011-08-20 21:22:32Z peterjfarrell $

Notes:
--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/customtags" />
	<cfset copyToScope("${event.user},${event.chapters},states=${properties.usStates},roles=${properties.userRoles},statuses=${properties.userStatuses}") />

	<cfif NOT Len(variables.user.getId())>
		<cfset variables.type = "New" />
		<cfset variables.title = "New User" />
	<cfelse>
		<cfset variables.type = "Edit" />
		<cfset variables.title = "Edit User | #variables.user.getDisplayName()#" />
	</cfif>
	
	<view:meta type="title" content="#variables.title#" />

	<view:script>
		$(document).ready(function(){
			$("#userForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>
<tags:displaymessage />
<tags:displayerror />

<h3>#variables.title#</h3>

<form:form actionEvent="user.save" bind="user" id="userForm">
	<table>
		<tr>
			<th><label id="status">Status *</label></th>
			<td>
				<form:select path="status" items="#statuses#" class="required">
					<form:option value="" label="" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th><label id="role">Role *</label></th>
			<td>
				<form:select path="role" items="#roles#" class="required">
					<form:option value="" label="" />
				</form:select>
			</td>
		</tr>	
		<tr>
			<th><label id="firstName">First Name *</label></th>
			<td><form:input path="firstName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="lastName">Last Name *</label></th>
			<td><form:input path="lastName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="googleEmail">Google Email *</label></th>
			<td><form:input path="googleEmail" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="altEmail">Alternative Email</label></th>
			<td><form:input path="altEmail" size="40" maxlength="200" /></td>
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
					<form:option value="" label="" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</td>
		</tr>
		<cfif ArrayLen( chapters )>
			<tr>
				<th><label id="chapterId">Chapter</label></th>
				<td>
					<form:select path="chapterId">
						<cfloop from="1" to="#ArrayLen(chapters)#" index="i">
							<form:option value="#chapters[i].getID()#" label="#chapters[i].getName()#" />
						</cfloop>
					</form:select>
				</td>
			</tr>
		</cfif>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save User" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>