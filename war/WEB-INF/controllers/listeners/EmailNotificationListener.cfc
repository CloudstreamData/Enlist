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
			to:getProperty("defaultEmail"),
			from:event.getArg("user").getGoogleEmail(),
			subject:"New User Notification",
			message: event.getArg("email.message")
		) />
	</cffunction>

	<cffunction name="buildI18NArgs" output="false" access="public" returntype="string"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = createObject('component','Enlist.model.user.User') />
		<cfset event.setArg('user', user) />

		<cfset user.setFirstName("andrew")/>
		<cfset user.setLastName("Leaf")/>
		<cfset user.setGoogleEmail("andrew.leaf@gmail.com")/>
		<cftry>
			<cfset t = getEmailService().buildI18NArgs(event.getArg('user')) />
			<cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>

		</cftry>
		<cfreturn t />
	</cffunction>
</cfcomponent>