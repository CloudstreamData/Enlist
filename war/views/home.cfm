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
	<view:meta type="title" content="Home" />
</cfsilent>
<cfoutput>
<h2>Welcome to Enlist for #getProperty('setting').getOrgName()#</h2>
<p>#getProperty('setting').getOrgName()# is #getProperty('setting').getOrgDesc()#</p>

<h3>Let's assume everyone's an admin for now and build this stuff out ...</h3>

<cfif event.isArgDefined("message")>
<p>#event.getArg("message")#</p>
</cfif>

<p><strong>Users</strong></p>
<ul>
	<li><a href="#BuildUrl('user.edit')#">Add New User</a></li>
	<li><a href="#BuildUrl('user.list')#">List All Users</a></li>
	<li><a href="#BuildUrl('user.search')#">Search Users</a></li>
</ul>

<p><strong>Events</strong></p>
<ul>
	<li><a href="#BuildUrl('event.edit')#">Add New Event</a></li>
	<li><a href="#BuildUrl('event.list')#">List Events</li>
	<li><a href="#BuildUrl('event.search')#">Search Events</a></li>
</ul>
</cfoutput>