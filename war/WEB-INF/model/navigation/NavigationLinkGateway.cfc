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
<cfcomponent output="false" extends="enlist.model.GenericDAO">
	
	
	<cffunction name="init" access="public" returntype="NavigationLinkGateway" output="false"> 
		<cfargument name="entityComponentPath" type="string" required="true" />
		<cfargument name="kind" type="string" required="false" />

		<cfscript>
			super.init(argumentCollection=arguments);
			createDefaultNavigationSet();
			return this;
		</cfscript>
	</cffunction>
	
	
	<cffunction name="list" access="public" returntype="array" output="false">
		<cfreturn googleQuery("select from #getKind()# order by name") />
	</cffunction>
	

	<cffunction name="createDefaultNavigationSet" returntype="any" access="public" output="false">
		<cfscript>
			var navigationLink = '';
			var defaultNavigation = listToArray('Events,event.list;Activities,activity.list;Navigation,navigation.list;My Activities,activityvolunteer.list', ";");
			var i = 0;
			//check if any navigation exists
			if(arrayLen(list()) EQ 0) {
				for (i=1; i LTE arrayLen(defaultNavigation); i=i+1) {
					//navigationLink = read('');
					navigationLink.setName(listFirst(defaultNavigation[i]));
					navigationLink.setEventName(listLast(defaultNavigation[i]));
					saveNavigationLink(navigationLink);
				}
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>