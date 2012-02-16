<!---

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2010 GreatBizTools, LLC

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

	As a special exception, the copyright holders of this library give you
	permission to link this library with independent modules to produce an
	executable, regardless of the license terms of these independent
	modules, and to copy and distribute the resultant executable under
	the terms of your choice, provided that you also meet, for each linked
	independent module, the terms and conditions of the license of that
	module.  An independent module is a module which is not derived from
	or based on this library and communicates with Mach-II solely through
	the public interfaces* (see definition below). If you modify this library,
	but you may extend this exception to your version of the library,
	but you are not obligated to do so. If you do not wish to do so,
	delete this exception statement from your version.


	* An independent module is a module which not derived from or based on
	this library with the exception of independent module components that
	extend certain Mach-II public interfaces (see README for list of public
	interfaces).

Author: Peter J. Farrell (peter@mach-ii.com)
$Id: ParserUtils.cfc 2853 2011-09-09 04:46:04Z peterjfarrell $

Created version: 1.9.0
Updated version: 1.9.0

Notes:
--->
<cfcomponent
	displayname="ParserUtils"
	output="false"
	hint="Performs generic parsing utility functions.">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ParserUtils" output="false"
		hint="Initializes the parser.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="parseRequestBodyParameters" returntype="struct" output="false"
		hint="Parses body request parameters.">
		<cfargument name="rawRequestBody" type="string" required="true"
			hint="The raw request body from "/>
		<cfargument name="decode" type="boolean" required="false" default="true"
			hint="Parameter to set if UrlDecode is run on the body key and value. Only required for application/x-www-form-urlencoded content-type." />
		<cfargument name="decodeEncoding" type="string" required="false" default="#GetEncoding("form")#"
			hint="The encoding type to use with UrlDecode. Defaults to the encoding set for the 'form' scope." />

		<cfset var parameters = StructNew() />
		<cfset var token = "" />
		<cfset var key = "" />
		<cfset var value = "" />
		<cfset var i = 0 />

		<cfloop array="#ListToArray(arguments.rawRequestBody, "&")#" index="token">

			<cfset i = token.indexOf("=") />
			<cfset key = Left(token, i) />
			<cfset value = Mid(token, i + 2, Len(token)) />

			<cfif arguments.decode>
				<cfset parameters[UrlDecode(key, arguments.decodeEncoding)] = UrlDecode(value, arguments.decodeEncoding) />
			<cfelse>
				<cfset parameters[key] = value />
			</cfif>
		</cfloop>

		<cfreturn parameters />
	</cffunction>

</cfcomponent>