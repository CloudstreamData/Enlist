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
$Id: AdminApiAdapterBD.cfc 2853 2011-09-09 04:46:04Z peterjfarrell $

Created version: 1.9.0

Notes:
--->
<cfcomponent
	displayname="AdminApiAdapterBD"
	extends="AdminApiAdapter"
	output="false"
	hint="Abstract API that adapters a CFML engine API for Open BlueDragon.">

	<!---
	PROPERTIES
	--->
	<cfset variables.admin = createObject("component", "bluedragon.adminapi.Administrator") />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="AdminApiAdapter" output="false"
		hint="Initializes the adapter.">

		<cfset session.auth.loggedIn = true/>
		<cfset session.auth.password = createObject("java", "com.naryx.tagfusion.cfm.engine.cfEngine").getConfig().getCFMLData().server.system.password />
		<cfset variables.admin.login(session.auth.password) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getScheduledTasks" access="public" returntype="struct" output="false"
		hint="Gets a struct of all scheduled tasks.">
		<cfargument name="searchPattern" type="string" required="false"
			default="*"
			hint="Allows you to filter by task name using simple patern matching syntax." />

		<cfset var scheduleTaskService = createObject("component", "bluedragon.adminapi.ScheduledTasks") />
		<cfset var rawTasks = "" />
		<cfset var results = StructNew() />
		<cfset var taskName = "" />
		<cfset var i = 0 />

		<cftry>
			<cfset rawTasks = scheduleTaskService.getScheduledTasks() />

			<cfloop from="1" to="#ArrayLen(rawTasks)#" index="i">
				<cfset taskName = rawTasks[i].name />

				<cfif variables.matcher.match(arguments.searchPattern, taskName)>
					<cfset results[taskName] = rawTasks[i] />

					<!--- Normalize task name into key "task" --->
					<cfset results[taskName].task = rawTasks[i].name />
					<cfset results[taskName].url = rawTasks[i].urlToUse />
				</cfif>
			</cfloop>
			<cfcatch type="bluedragon.adminapi.scheduledtasks">
				<!--- Catch exception where there is no scheduled tasks --->
			</cfcatch>
		</cftry>

		<cfreturn results />
	</cffunction>

	<!--- deleteTasks is inherited --->

	<!--- addTask is inherited --->

</cfcomponent>