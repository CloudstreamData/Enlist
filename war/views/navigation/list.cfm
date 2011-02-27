<cfimport prefix="view" taglib="/MachII/customtags/view">

<cfset navigations = event.getArg("navigations")>

<p><view:a event="navigation.edit">Create a new navigation</view:a></p>

<table>
<tr>
	<th>Name</th>
	<th>Event</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(navigations)#" index="i">
	<tr>
		<td>#navigations[i].getName()#</td>
		<td>#navigations[i].geteventName()#</td>
		<td><view:a event="navigation.edit" p:id="#navigations[i].getID()#">Edit</view:a></td>
		<td><view:a event="navigation.delete" p:id="#navigations[i].getID()#" onClick="return confirm('Sure?')">Delete</view:a></td>
	</tr>	
</cfloop> 
</cfoutput>
</table>

<p><view:a event="navigation.edit">Create a new navigation</view:a></p>