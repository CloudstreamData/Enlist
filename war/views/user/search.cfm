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
	<cfimport prefix="form" taglib="/MachII/customtags/form">
	<cfset chapters = event.getArg("chapters") />
	<cfset states = getProperty("usStates") />
	<cfset roles= getProperty("userRoles") />
	<cfset statuses = getProperty("userStatuses") />
</cfsilent>
<form:form actionEvent="user.doSearch">
	<table>
		<tr>
			<th>First Name</th>
			<td><form:input path="firstName" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Last Name</th>
			<td><form:input path="lastName" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Google Email</th>
			<td><form:input path="googleEmail" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Phone</th>
			<td><form:input path="phone" size="40" maxlength="40" /></td>
		</tr>
		<tr>
			<th>Address</th>
			<td><form:input path="address1" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Address (cont.)</th>
			<td><form:input path="address2" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>City</th>
			<td><form:input path="city" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>State / Zip</th>
			<td>
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="--" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</td>
		</tr>
		<tr>
			<th>Alternative Email</th>
			<td><form:input path="altEmail" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Chapter</th>
			<td>
				<form:select path="chapterId">
					<form:option label="--Select to search--" value="" />
					<cfloop from="1" to="#arrayLen(chapters)#" index="i">
						<form:option value="#chapters[i].getID()#" label="#chapters[i].getName()#" />
					</cfloop>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>Status</th>
			<td>
				<form:select path="status" items="#statuses#">
					<form:option label="--Select to search--" value="" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th>Role</th>
			<td>
				<form:select path="role" items="#roles#">
					<form:option label="--Select to search--" value="" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><form:button type="submit" name="search" value="Search" /></td>
		</tr>
	</table>
</form:form>