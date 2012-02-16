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
<cfcomponent
	displayname="SettingService"
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.settingGateway = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="SettingService" output="false"
		hint="Initializes the service.">
		<cfreturn this />
	</cffunction>

	<cffunction name="setSettingGateway" access="public" returntype="void" output="false">
		<cfargument name="settingGateway" type="any" required="true" />
		<cfset variables.settingGateway = arguments.settingGateway />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->

	<cffunction name="getSetting" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn variables.settingGateway.getSetting( arguments.id ) />
	</cffunction>

	<cffunction name="getLastSetting" access="public" returntype="any" output="false">
		<cfset var settings = variables.settingGateway.getSettings() />
		<cfset var setting = 0 />
		<cfif settings.recordcount gt 0>
			<cfset setting = variables.settingGateway.getSetting(settings.id) />
		<cfelse>
			<cfset setting = getSetting(0) />
		</cfif>
		<cfreturn setting />
	</cffunction>

	<cffunction name="getSettings" access="public" returntype="query" output="false">
		<cfreturn variables.settingGateway.getSettings() />
	</cffunction>

	<cffunction name="registerSetting" access="public" returntype="void" output="false">
		<cfargument name="setting" type="enlist.model.setting.Setting" required="true">
		<cfset saveSetting( arguments.setting ) />
		<cfset variables.sessionFacade.setSetting( arguments.setting ) />
	</cffunction>

	<cffunction name="saveSetting" access="public" returntype="any" output="false">
		<cfargument name="setting" type="enlist.model.setting.Setting" required="true">
		<cfset var errors = arguments.setting.validate() />
		<cfif (structIsEmpty(errors))>
			<cfset variables.settingGateway.saveSetting( arguments.setting ) />
		</cfif>
		<cfreturn errors />
	</cffunction>

</cfcomponent>