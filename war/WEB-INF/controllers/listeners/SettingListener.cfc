<cfcomponent
	displayname="SettingListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="SettingService">

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="updateSettingProperty" output="false" access="public" returntype="void"
		hint="This method returns a struct of ID:Name for use in the form:select tag">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset var setting = variables.settingService.getLastSetting() />
		<cfset setProperty('setting',setting) />
	</cffunction>

</cfcomponent>