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
	<cfset copyToScope("${event.users}") />
</cfsilent>

<p><view:a event="user.search">Search Users</view:a></p>
<p><view:a event="user.edit">Create a new user</view:a></p>

<table>
	<tr>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Google Email</th>
		<th>Role</th>
		<th>Status</th>
	</tr>
<cfoutput>
<cfif arrayLen(users)>
<cfloop from="1" to="#arrayLen(users)#" index="i">
	<tr>
		<td>#users[i].getFirstName()#</td>
		<td>#users[i].getLastName()#</td>
		<td>#users[i].getGoogleEmail()#</td>
		<td>#users[i].getRole()#</td>
		<td>#users[i].getStatus()#</td>
		<td><view:a event="user.edit" p:id="#users[i].getID()#">Edit</view:a></td>
	</tr>
</cfloop>
<cfelse>
	<tr>
		<td colspan="6">No users found</td>
	</tr>
</cfif>
</cfoutput>
</table>

<p><view:a event="user.edit">Create a new user</view:a></p>