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
	<<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="tags" taglib="/enlist/customtags" />
	<cfset copyToScope("${event.users}") />
	
	<cfif event.getName() EQ "user.doSearch">
		<cfset variables.title = "Users Search Results" />
	<cfelse>
		<cfset variables.title = "List Users" />
	</cfif>
	<view:meta type="title" content="#variables.title#" />
</cfsilent>
<cfoutput>
<p><view:a event="user.search">Search Users</view:a></p>
<p><view:a event="user.edit">Create a new user</view:a></p>

<h3>#variables.title#</h3>

<table>
	<tr>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Google Email</th>
		<th>Role</th>
		<th>Status</th>
		<th>Actions</th>
	</tr>

<cfif ArrayLen(users)>
<cfloop array="#variables.users#" index="user">
	<tr>
		<td>#user.getFirstName()#</td>
		<td>#user.getLastName()#</td>
		<td>#user.getGoogleEmail()#</td>
		<td>#user.getRole()#</td>
		<td>#user.getStatus()#</td>
		<td><view:a event="user.edit" p:id="#user.getID()#">Edit</view:a></td>
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