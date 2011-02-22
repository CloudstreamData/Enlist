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
<cfcomponent output="false">
	
	
	<cffunction name="init" access="public" returntype="NavigationLinkGateway" output="false"> 
		<cfscript>
			createDefaultNavigationSet();
			return this;
		</cfscript>
	</cffunction>
	
	
	
	<cffunction name="getNavigationLink" access="public" returntype="Enlist.model.navigation.NavigationLink" output="false">
		<cfargument name="navigationLinkID" type="string" required="false" default="">
		
		<cfif len( arguments.navigationLinkID )>
			<cfset var navigationLinks = GoogleQuery("select from navigationLink where id == '#arguments.navigationLinkID#'") />
			<cfif arrayLen( navigationLinks )>
				<cfreturn navigationLinks[1] />
			</cfif>
		</cfif>
		
		<cfreturn createObject("component", "Enlist.model.navigation.NavigationLink").init() />
	</cffunction> 
	
	<cffunction name="getNavigationLinks" access="public" returntype="array" output="false">
		<cfreturn googleQuery("select from navigationLink order by name") />
	</cffunction>
	
	
	<cffunction name="deleteNavigationLink" access="public" returntype="void" output="false">
		<cfargument name="navigationLink" type="Enlist.model.navigation.NavigationLink" required="true">
		<cfif len(navigationLink.getID()) GT 0>
			<cfset googleDelete(arguments.navigationLink) />
		</cfif>
	</cffunction> 
	

	<cffunction name="saveNavigationLink" access="public" returntype="void" output="false">
		<cfargument name="navigationLink" type="Enlist.model.navigation.NavigationLink" required="true">

		<cfset var currentObjectToDelete = "" />
		
		<cfif arguments.navigationLink.getID() eq "">
			<cfset arguments.navigationLink.setID(createUUID()) />
		<cfelse>
			<!--- Peter said this is a necessary workaround, because googleWrite() will not currently update, but always insert a new record: --->
			<cfset googleDelete(getNavigationLink(arguments.navigationLink.getID())) />
		</cfif>
		<cfset key = arguments.navigationLink.googleWrite("navigationLink") />
	</cffunction> 
	
	
	<cffunction name="createDefaultNavigationSet" returntype="any" access="public" output="false">
		<cfscript>
			var navigationLink = '';
			var defaultNavigation = listToArray('Events,event.list;Activities,activity.list;Navigation,navigation.list;My Activities,activityvolunteer.list', ";");
			var i = 0;
			//check if any navigation exists
			if(arrayLen(getNavigationLinks()) EQ 0) {
				for (i=1; i LTE arrayLen(defaultNavigation); i=i+1) {
					navigationLink = getNavigationLink();
					navigationLink.setName(listFirst(defaultNavigation[i]));
					navigationLink.setEventName(listLast(defaultNavigation[i]));
					saveNavigationLink(navigationLink);
				}
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>