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
	
	<cffunction name="getStateList" access="public" returntype="array" output="false">
		<cfscript>
			var states = ArrayNew(1);
			
			states[1].abbr = "AL";
			states[1].name = "Alabama";
			
			states[2].abbr = "AK";
			states[2].name = "Alaska";
			
			states[3].abbr = "AS";
			states[3].name = "American Samoa";
			
			states[4].abbr = "AZ";
			states[4].name = "Arizona";

			states[5].abbr = "AR";
			states[5].name = "Arkansas";
			
			states[6].abbr = "CA";
			states[6].name = "California";

			states[7].abbr = "CO";
			states[7].name = "Colorado";

			states[8].abbr = "CT";
			states[8].name = "Connecticut";

			states[9].abbr = "DE";
			states[9].name = "Delaware";

			states[10].abbr = "DC";
			states[10].name = "District of Columbia";

			states[11].abbr = "FM";
			states[11].name = "Federated States of Micronesia";

			states[12].abbr = "FL";
			states[12].name = "Florida";

			states[13].abbr = "GA";
			states[13].name = "Georgia";

			states[14].abbr = "GU";
			states[14].name = "Guam";
			
			states[15].abbr = "HI";
			states[15].name = "Hawaii";

			states[16].abbr = "ID";
			states[16].name = "Idaho";

			states[17].abbr = "IL";
			states[17].name = "Illinois";

			states[18].abbr = "IN";
			states[18].name = "Indiana";

			states[19].abbr = "IA";
			states[19].name = "Iowa";

			states[20].abbr = "KS";
			states[20].name = "Kansas";

			states[21].abbr = "KY";
			states[21].name = "Kentucky";

			states[22].abbr = "LA";
			states[22].name = "Louisiana";

			states[23].abbr = "ME";
			states[23].name = "Maine";

			states[24].abbr = "MH";
			states[24].name = "Marshall Islands";

			states[25].abbr = "MD";
			states[25].name = "Maryland";

			states[26].abbr = "MA";
			states[26].name = "Massachusetts";

			states[27].abbr = "MI";
			states[27].name = "Michigan";

			states[28].abbr = "MN";
			states[28].name = "Minnesota";

			states[29].abbr = "MS";
			states[29].name = "Mississippi";

			states[30].abbr = "MO";
			states[30].name = "Missouri";

			states[31].abbr = "MT";
			states[31].name = "Montana";

			states[32].abbr = "NE";
			states[32].name = "Nebraska";

			states[33].abbr = "NV";
			states[33].name = "Nevada";

			states[34].abbr = "NH";
			states[34].name = "New Hampshire";

			states[35].abbr = "NJ";
			states[35].name = "New Jersey";

			states[36].abbr = "NM";
			states[36].name = "New Mexico";

			states[37].abbr = "NY";
			states[37].name = "New York";

			states[38].abbr = "NC";
			states[38].name = "North Carolina";

			states[39].abbr = "ND";
			states[39].name = "North Dakota";

			states[40].abbr = "MP";
			states[40].name = "Northern Mariana Islands";

			states[41].abbr = "OH";
			states[41].name = "Ohio";

			states[42].abbr = "OK";
			states[42].name = "Oklahoma";

			states[43].abbr = "OR";
			states[43].name = "Oregon";

			states[44].abbr = "PW";
			states[44].name = "Palau";

			states[45].abbr = "PA";
			states[45].name = "Pennsylvania";

			states[46].abbr = "PR";
			states[46].name = "Puerto Rico";

			states[47].abbr = "RI";
			states[47].name = "Rhode Island";

			states[48].abbr = "SC";
			states[48].name = "South Carolina";

			states[49].abbr = "SD";
			states[49].name = "South Dakota";

			states[50].abbr = "TN";
			states[50].name = "Tennessee";

			states[51].abbr = "TX";
			states[51].name = "Texas";

			states[52].abbr = "UT";
			states[52].name = "Utah";

			states[53].abbr = "VT";
			states[53].name = "Vermont";

			states[54].abbr = "VI";
			states[54].name = "Virgin Islands";

			states[55].abbr = "VA";
			states[55].name = "Virginia";

			states[56].abbr = "WA";
			states[56].name = "Washington";

			states[57].abbr = "WV";
			states[57].name = "West Virginia";
			
			states[58].abbr = "WI";
			states[58].name = "Wisconsin";

			states[59].abbr = "WY";
			states[59].name = "Wyoming";

			return states;
		</cfscript>
	</cffunction>

</cfcomponent>