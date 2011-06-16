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
	<cfset copyToScope("${event.navigations}") />
</cfsilent>
<cfoutput>
<p><view:a event="navigation.edit">Create a new navigation</view:a></p>

<table>
	<tr>
		<th>Name</th>
		<th>Event</th>
	</tr>
<cfloop from="1" to="#ArrayLen(variables.navigations)#" index="i">
	<tr>
		<td>#variables.navigations[i].getName()#</td>
		<td>#variables.navigations[i].geteventName()#</td>
		<td><view:a event="navigation.edit" p:id="#variables.navigations[i].getID()#">Edit</view:a></td>
		<td><view:a event="navigation.delete" p:id="#variables.navigations[i].getID()#" onClick="return confirm('Sure?')">Delete</view:a></td>
	</tr>	
</cfloop> 
</table>

<p><view:a event="navigation.edit">Create a new navigation</view:a></p>
</cfoutput>