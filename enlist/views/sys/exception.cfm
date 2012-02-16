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
	<cfset copyToScope("${event.exception}") />
	<view:meta type="title" content="Exception" />
</cfsilent>
<cfoutput>
<h3>Mach-II Exception</h3>
<table>
	<tr>
		<td><h4>Message</h4></td>
		<td><p>#variables.exception.getMessage()#</p></td>
	</tr>
	<tr>
		<td><h4>Detail</h4></td>
		<td><p>#variables.exception.getDetail()#</p></td>
	</tr>
	<tr>
		<td><h4>Extended Info</h4></td>
		<td><p>#variables.exception.getExtendedInfo()#</p></td>
	</tr>
	<tr>
		<td><h4>Tag Context</h4></td>
		<td>
			<cfset variables.tagCtxArr = variables.exception.getTagContext() />
			<cfloop index="i" from="1" to="#ArrayLen(variables.tagCtxArr)#">
				<cfset variables.tagCtx = variables.tagCtxArr[i] />
				<p>#variables.tagCtx['template']# (#variables.tagCtx['line']#)</p>
			</cfloop>
		</td>
	</tr>
	<tr>
		<td><h4>Caught Exception</h4></td>
		<td><cfdump var="#variables.exception.getCaughtException()#" expand="false" /></td>
	</tr>
</table>
</cfoutput>