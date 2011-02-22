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
	
	$Id: $
	
	Notes:
	--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
</cfsilent>

<cfscript>
	
	link1 = createObject("component", "Enlist.model.navigation.NavigationLink").init(1,'Events','event.list');
	link2 = createObject("component", "Enlist.model.navigation.NavigationLink").init(1,'Activities','activity.list');
	link3 = createObject("component", "Enlist.model.navigation.NavigationLink").init(1,'My Activities','activityvolunteer.list');
	
	//array of NavigationLink objects should come from user.getNavigaiton() or somethinglike that
	navLinks = arrayNew(1); //event.getArg('User').getNavigation(); 
	navLinks[1] = link1;
	navLinks[2] = link2;
	navLinks[3] = link3;
	displayNavigation(navLinks);
</cfscript>

<cffunction name="displayNavigation" returntype="any" access="public" output="true">
	<cfargument name="links" type="any" required="true" />
	<cfset var link = '' />
	
	<ul id="nav">
	<cfloop index="link" from="1" to="#arrayLen(arguments.links)#">
		<cfoutput>
		<li><view:a event="#arguments.links[link].getEvent()#">#arguments.links[link].getName()#</view:a></li>
		</cfoutput>
	</cfloop>
	</ul>
</cffunction>

