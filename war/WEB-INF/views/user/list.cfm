<cfimport prefix="view" taglib="/MachII/customtags/view">

<cfset users = event.getArg("users")>

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