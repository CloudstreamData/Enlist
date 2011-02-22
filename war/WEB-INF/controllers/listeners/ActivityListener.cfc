<cfcomponent
	displayname="ActivityListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="ActivityService,EventService,sessionFacade">

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
	<cffunction name="getActivityVolunteerHistoryForUser" returntype="array" access="public" output="false">
		<cfargument name="event" type="MachII.framework.Event" />
		
		<cfset var user = getSessionFacade().getUser() />
		<cfreturn getActivityService().getActivityVolunteerHistoryByUser( user.getId() ) />
	</cffunction>

</cfcomponent>