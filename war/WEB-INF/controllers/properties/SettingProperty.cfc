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
		<cfset setting = getSetting() />
		<cfset setProperty('setting',setting) />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getSetting" access="public" returntype="Enlist.model.setting.Setting" output="false">
		<cfset var setting = variables.settingService.getLastSetting() />
		<!--- if this is a new app without any settings, save the defaults --->
		<cfif not len(setting.getID())>
			<cfset variables.settingService.saveSetting(setting) />
			<cfset setting = variables.settingService.getLastSetting() />
		</cfif>
		<cfreturn setting />
	</cffunction>
</cfcomponent>
