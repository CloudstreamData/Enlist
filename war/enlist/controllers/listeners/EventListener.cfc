<cfcomponent
	displayname="EventListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="eventService">

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
	<cffunction name="getEventsAsStruct" output="false" access="public" returntype="struct"
		hint="This method returns a struct of ID:Name for use in the form:select tag">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset var events = StructNew() />
		<cfset var thisEvent = "" />
		
		<cfloop array="#getEventService().getEvents()#" index="thisEvent">
			<cfset events[ thisEvent.getId() ] = thisEvent.getName() />
		</cfloop>
		
		<cfreturn events />
	</cffunction>
	
</cfcomponent>