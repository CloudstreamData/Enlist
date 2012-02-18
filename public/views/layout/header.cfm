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

$Id: header.cfm 181 2011-06-16 04:56:27Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("eventName=${event.getName()},${properties.udfs}") />
</cfsilent>
<cfoutput>
<h2><view:a event="home" title="Back to Home">Enlist</view:a></h2>
<div id="menu">
	<ul>
		<li><view:a event="home" class="#variables.udfs.highlightLevel("home", variables.eventName)#">Home</view:a></li>
	<!--- <cfif variables.googleUserService.isUserLoggedIn()> --->
		<li><a href="" id="logout">Logout</a></li>
		<li><view:a event="register">Register</view:a></li>
	<!--- <cfelse> --->
		<li><a href="">Login</a></li>
	<!--- </cfif> --->
	</ul>
</div>
</cfoutput>