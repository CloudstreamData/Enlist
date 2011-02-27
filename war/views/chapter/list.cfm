<cfimport prefix="view" taglib="/MachII/customtags/view">

<cfset chapters = event.getArg("chapters")>

<p><view:a event="chapter.edit">Create a new chapter</view:a></p>

<table>
<tr>
	<th>Chapter</th>
	<th>Location</th>
	<th>Status</th>
</tr>
<cfoutput>
<cfloop from="1" to="#arrayLen(chapters)#" index="i">
	<tr>
		<td>#chapters[i].getName()#</td>
		<td>#chapters[i].getLocation()#</td>
		<td>#chapters[i].getStatusCode()#</td>
		<td><view:a event="chapter.edit" p:id="#chapters[i].getID()#">Edit</view:a></td>
	</tr>
</cfloop>
</cfoutput>
</table>

<p><view:a event="chapter.edit">Create a new chapter</view:a></p>