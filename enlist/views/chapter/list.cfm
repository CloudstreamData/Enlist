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
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/enlist/customtags" />

	<cfset copyToScope("${event.chapters}") />
	
	<view:meta type="title" content="List Chapters" />
</cfsilent>
<cfoutput>
<p><view:a event="chapter.edit">Create a new chapter</view:a></p>

<table>
	<tr>
		<th>Chapter</th>
		<th>Location</th>
		<th>Status</th>
	</tr>
<cfloop from="1" to="#arrayLen(chapters)#" index="i">
	<tr>
		<td>#chapters[i].getName()#</td>
		<td>#chapters[i].getLocation()#</td>
		<td>#chapters[i].getStatusCode()#</td>
		<td><view:a event="chapter.edit" p:id="#chapters[i].getID()#">Edit</view:a></td>
	</tr>
</cfloop>
</table>

<p><view:a event="chapter.edit">Create a new chapter</view:a></p>
</cfoutput>