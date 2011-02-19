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
<cfcomponent displayname="Udfs"
	output="false">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Udfs" output="false"
		hint="Initializes the Udfs.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="highlightLevel" access="public" returntype="string" output="false"
		hint="Highlights the current navigation level.">
		<cfargument name="eventList" type="string" required="true" />
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="match" type="boolean" required="false" default="FALSE" />
		<cfargument name="attribute" type="string" required="false" default="current" />

		<cfset var l = ListLen(arguments.eventList, ".") />
		<cfset var i = "" />
		<cfset var result = "" />

		<cfif arguments.match>
			<cfif NOT CompareNoCase(arguments.eventList, arguments.eventName)>
				<cfset result =  arguments.attribute />
			</cfif>
		<cfelse>
			<cfset result = arguments.attribute  />
			<cfif Len(arguments.eventName)>
				<cfloop from="1" to="#l#" index="i">
					<cfif i NEQ l AND listGetAt(arguments.eventList, i, ".") NEQ listGetAt(arguments.eventName, i, ".")>
						<cfset result = "" />
						<cfbreak />
					<cfelseif i GT ListLen(arguments.eventName, ".")>
						<cfset result = "" />
						<cfbreak />
					<cfelseif i EQ l AND listGetAt(arguments.eventList, i, ".") NEQ ListFirst(listGetAt(arguments.eventName, i, "."), "_")>
						<cfset result = "" />
						<cfbreak />
					</cfif>
				</cfloop>
			<cfelse>
				<cfset result = "" />
			</cfif>
		</cfif>

		<cfreturn result />
	</cffunction>

</cfcomponent>