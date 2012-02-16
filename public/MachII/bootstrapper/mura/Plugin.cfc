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

$Id: Plugin.cfc 2858 2011-09-09 05:12:17Z peterjfarrell $

Created version: 1.9.0
Updated version: 1.9.0

Notes:
This file provides the 'plugin' for the open source Mura CMS (http://getmura.com/).
--->
<cfcomponent
	displayname="MuraPlugin"
	extends="mura.cfobject"
	output="false"
	hint="This CFC represents the requirements to install, update and deleta a Mura plugin.">

	<!---
	PROPERTIES
	--->
	<cfset variables.pluginConfig = "" />

	<!---
	INIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="void" output="false"
		hint="Initializes the plugin for Mura CMS.">
		<cfargument name="pluginConfig"  type="any" required="true" />

		<cfset variables.pluginConfig = arguments.pluginConfig />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="install" access="public" returntype="void" output="false"
		hint="Executed by the Mura PluginManager when the plugin is installed.">

		<cfset var moduleId = variables.pluginConfig.getModuleId() />

		<cfif getInstallationCount() NEQ 1>
			<cfset variables.pluginConfig.getPluginManager().deletePlugin(moduleId) />
		</cfif>

		<cfset application.appInitialized = false />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false"
		hint="Executed by the Mura PluginManager when the plugin is updated.">
		<cfset application.appInitialized = false />
	</cffunction>

	<cffunction name="delete" access="public returntype="void"" output="false"
		hint="Execute by the Mura PluginManager when the plugin is delete.">
		<cfset application.appInitialized = false />
	</cffunction>

</cfcomponent>