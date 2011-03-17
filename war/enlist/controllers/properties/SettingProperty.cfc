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
	displayname="SettingProperty"
	extends="MachII.framework.Property"
	output="false"
	hint="A property for the application specific settings">

	<!---
	PROPERTIES
	--->
	<cfset variables.settingService = "" />


	<!---
	INITIALIZATION / CONFIGURATION
	--->

	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the property.">
		<!--- Put custom configuration for this property here. --->
		<cfset variables.settingService = getProperty('settingService') />
		<cfset setProperty('setting', getSetting()) />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getSetting" access="public" returntype="enlist.model.setting.Setting" output="false">
		<cfset var setting = variables.settingService.getLastSetting() />
		<!--- if this is a new app without any settings, save the defaults --->
		<cfif not len(setting.getID())>
			<cfset variables.settingService.saveSetting(setting) />
			<cfset setting = variables.settingService.getLastSetting() />
		</cfif>
		<cfreturn setting />
	</cffunction>
</cfcomponent>
