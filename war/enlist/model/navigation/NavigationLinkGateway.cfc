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
<cfcomponent 
	displayname="NavigationLinkGateway" 
	output="false" 
	extends="enlist.model.GenericDAO">
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="NavigationLinkGateway" output="false">
		<cfargument name="entityComponentPath" type="string" required="false" default="" />
		<cfargument name="kind" type="string" required="false" default="" />
		
		<cfscript>
			setEntityComponentPath(arguments.entityComponentPath);
			setKind(arguments.kind);
			super.init(getEntityComponentPath(), getKind());
			createDefaultNavigationSet();
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="setEntityComponentPath" access="public" returntype="void" output="false">
		<cfargument name="entityComponentPath" type="string" required="true" />
		<cfset variables.entityComponentPath = arguments.entityComponentPath />
	</cffunction>
	<cffunction name="getEntityComponentPath" access="public" returntype="string" output="false">
		<cfreturn variables.entityComponentPath />
	</cffunction>
	
	<cffunction name="setKind" access="public" returntype="void" output="false">
		<cfargument name="kind" type="string" required="true" />
		<cfset variables.kind = arguments.kind />
	</cffunction>
	<cffunction name="getKind" access="public" returntype="string" output="false">
		<cfreturn variables.kind />
	</cffunction>
	
	<cffunction name="list" access="public" returntype="array" output="false">
		<cfset var navArray = ArrayNew(1) />
		
		<cfif getKind() neq "">
			<cfset navArray = googleQuery("select from #getKind()# order by name") />
		</cfif>
		
		<cfreturn navArray />
	</cffunction>

	<cffunction name="createDefaultNavigationSet" returntype="any" access="public" output="false">
		<cfscript>
			var navigationLink = 0;
			var defaultNavigation = listToArray('Events,event.list;Activities,activity.list;Navigation,navigation.list;My Activities,activityvolunteer.list', ";");
			var i = 0;

			if (ArrayLen(list()) eq 0) {
				for (i = 1; i lte ArrayLen(defaultNavigation); i = i + 1) {
					navigationLink = CreateObject("component", "NavigationLink").init();
					navigationLink.setName(ListFirst(defaultNavigation[i]));
					navigationLink.setEventName(ListLast(defaultNavigation[i]));
					save(navigationLink);
				}
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>