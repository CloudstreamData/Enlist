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
	
	$Id: search.cfm 188 2011-08-20 21:41:31Z peterjfarrell $
	
	Notes:
	--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("statuses=${properties.eventStatuses}") />
	
	<view:script>
		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</view:script>	
</cfsilent>
<cfoutput>

<h3>Search Events</h3>

<form:form actionEvent="event.doSearch">
	<table>
		<tr>
			<th>Name</th>
			<td><form:input path="name" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Location</th>
			<td><form:input path="location" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Start Date</th>
			<td><form:input path="startDate" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>End Date</th>
			<td><form:input path="endDate" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th>Status</th>
			<td>
				<form:select path="status" items="#statuses#">
					<form:option label="Any" value="" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><form:button type="submit" name="search" value="Search" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>