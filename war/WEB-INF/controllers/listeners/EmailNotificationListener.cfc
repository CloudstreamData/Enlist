<cfcomponent
	displayname="EmailNotificationListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="EmailService"
	hint="A simple listener example.">

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="sendNotification" output="false" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset getEmailService().send(
			to:event.getArg("user").getGoogleEmail(),
			from:getProperty("defaultEmail"),
			subject:"New User Notification",
			message: event.getArg("email.message")
		) />
	</cffunction>

	<cffunction name="buildI18NArgs" output="false" access="public" returntype="string"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset var strResult = "" />
		<cftry>
			<cfset strResult = getEmailService().buildI18NArgs(event.getArg('user'),event.getArg('activity')) />
			<cfcatch><cflog application="true" text="Email Message was not able to be created."></cfcatch>
		</cftry>
		<cfreturn strResult />
	</cffunction>
</cfcomponent>