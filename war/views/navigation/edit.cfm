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
	<cfimport prefix="tags" taglib="/customtags" />
	
	<cfset copyToScope("${event.navigation}") />
	
	<cfif NOT Len(variables.navigation.getId())>
		<cfset variables.type = "New" />
		<view:meta type="title" content="New Navigation Link" />
	<cfelse>
		<cfset variables.type = "Edit" />
		<view:meta type="title" content="Edit Navigation Link | #variables.chapter.getName()#" />
	</cfif>

	<view:script>
		$(document).ready(function(){
			$("#navForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>
<tags:displaymessage />
<tags:displayerror />

<form:form actionEvent="navigation.save" bind="navigation" id="navForm">
	<table>
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th>Location:</th>
			<td><form:input path="eventName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" value="#event.getArg( "navigation" ).getID()#" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Navigation Link" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>