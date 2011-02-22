<cfcomponent output="false">
	
	<!---
	PROPERTIES
	--->
	<cfproperty name="id" type="string" />
	<cfproperty name="user" type="Enlist.model.user.User" />
	<cfproperty name="event" type="Enlist.model.event.Event" />
	<cfproperty name="volunteeredOn" type="date" />
	<cfproperty name="scheduledStart" type="date" />
	<cfproperty name="scheduledEnd" type="date" />
	<cfproperty name="cancelledOn" type="date" />
	<cfproperty name="actualHours" type="numeric" />
	<cfproperty name="actualBones" type="numeric" />
	<cfproperty name="status" type="string" />
	
	<cfset variables.id = "" />
	<cfset variables.userId = "" />
	<cfset variables.eventId = "" />
	<cfset variables.volunteeredOn = "" />
	<cfset variables.scheduledStart = "" />
	<cfset variables.scheduledEnd = "" />
	<cfset variables.cancelledOn = "" />
	<cfset variables.actualHours = "" />
	<cfset variables.actualBones = "" />
	<cfset variables.status = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Enlist.model.event.Event" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="userId" type="string" required="false" default="" />
		<cfargument name="eventId" type="string" required="false" default="" />
		<cfargument name="volunteeredOn" type="string" required="false" default="" />
		<cfargument name="scheduledStart" type="string" required="false" default="" />
		<cfargument name="scheduledEnd" type="string" required="false" default="" />
		<cfargument name="cancelledOn" type="string" required="false" default="" />
		<cfargument name="actualHours" type="string" required="false" default="" />
		<cfargument name="actualBones" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
	</cffunction>


	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true" />	
		<cfset setId( arguments.data.id ) />
		<cfset setUserId( arguments.data.userId ) />
		<cfset setEventId( arguments.data.eventId ) />
		<cfset setVolunteeredOn( arguments.data.volunteeredOn ) />
		<cfset setScheduledStart( arguments.data.scheduledStart ) />
		<cfset setScheduledEnd( arguments.data.scheduledEnd ) />
		<cfset setCancelledOn( arguments.data.cancelledOn ) />
		<cfset setActualHours( arguments.data.actualHours ) />
		<cfset setActualBones( arguments.data.actualBones ) />
		<cfset setStatus( arguments.data.status ) />
	</cffunction>
	
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structnew() />
		<cfset var fieldname = "" />
		
		<cfloop list="id,userId,eventId,volunteeredOn,scheduledStart,scheduledStart,cancelledOn,actualHours,actualBones,status" index="fieldname">
			<cfset data[fieldname] = variables[fieldname]>
		</cfloop>
		
		<cfreturn data />	
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setId" returnformat="void" access="public" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = arguments.id />
	</cffunction>
	
	<cffunction name="getId" returntype="string" access="public" output="false">
		<cfreturn variables.id />
	</cffunction>
	
	
	<cffunction name="setUserId" returnformat="void" access="public" output="false">
		<cfargument name="userId" type="string" required="true" />
		<cfset variables.userId = arguments.userId />
	</cffunction>
	
	<cffunction name="getUserId" returntype="string" access="public" output="false">
		<cfreturn variables.userId />
	</cffunction>
	
	
	<cffunction name="setUser" returnformat="void" access="public" output="false">
		<cfargument name="user" type="Enlist.model.user.User" required="true" />
		<cfset variables.user = arguments.user />
	</cffunction>
		
	<cffunction name="getUser" returntype="Enlist.model.user.User" access="public" output="false">
		<cfreturn variables.user />
	</cffunction>
	
	
	<cffunction name="setEventId" returnformat="void" access="public" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfset variables.eventId = arguments.eventId />
	</cffunction>
		
	<cffunction name="getEventId" returntype="string" access="public" output="false">
		<cfreturn variables.eventId />
	</cffunction>
	
	<cffunction name="setEvent" returnformat="void" access="public" output="false">
		<cfargument name="event" type="Enlist.model.event.Event" required="true" />
		<cfset variables.event = arguments.event />
	</cffunction>
		
	<cffunction name="getEvent" returntype="Enlist.model.event.Event" access="public" output="false">
		<cfreturn variables.event />
	</cffunction>
	
	
	<cffunction name="setVolunteeredOn" returnformat="void" access="public" output="false">
		<cfargument name="volunteeredOn" type="string" required="true" />
		<cfset variables.volunteeredOn = arguments.volunteeredOn />
	</cffunction>
		
	<cffunction name="getVolunteeredOn" returntype="string" access="public" output="false">
		<cfreturn variables.volunteeredOn />
	</cffunction>
	
	
	<cffunction name="setScheduledStart" returnformat="void" access="public" output="false">
		<cfargument name="scheduledStart" type="string" required="true" />
		<cfset variables.scheduledStart = arguments.scheduledStart />
	</cffunction>
		
	<cffunction name="getScheduledStart" returntype="string" access="public" output="false">
		<cfreturn variables.scheduledStart />
	</cffunction>
	
	
	<cffunction name="setScheduledEnd" returnformat="void" access="public" output="false">
		<cfargument name="scheduledEnd" type="string" required="true" />
		<cfset variables.scheduledEnd = arguments.scheduledEnd />
	</cffunction>
		
	<cffunction name="getScheduledEnd" returntype="string" access="public" output="false">
		<cfreturn variables.scheduledEnd />
	</cffunction>
	
	
	<cffunction name="setCancelledOn" returnformat="void" access="public" output="false">
		<cfargument name="cancelledOn" type="string" required="true" />
		<cfset variables.cancelledOn = arguments.cancelledOn />
	</cffunction>
		
	<cffunction name="getCancelledOn" returntype="string" access="public" output="false">
		<cfreturn variables.cancelledOn />
	</cffunction>

	
	<cffunction name="setActualHours" returnformat="void" access="public" output="false">
		<cfargument name="actualHours" type="string" required="true" />
		<cfset variables.actualHours = arguments.actualHours />
	</cffunction>
		
	<cffunction name="getActualHours" returntype="string" access="public" output="false">
		<cfreturn variables.actualHours />
	</cffunction>
	
	
	<cffunction name="setActualBones" returnformat="void" access="public" output="false">
		<cfargument name="actualBones" type="string" required="true" />
		<cfset variables.actualBones = arguments.actualBones />
	</cffunction>
		
	<cffunction name="getActualBones" returntype="string" access="public" output="false">
		<cfreturn variables.actualBones />
	</cffunction>
	
	
	<cffunction name="setStatus" returnformat="void" access="public" output="false">
		<cfargument name="status" type="string" required="true" />
		<cfset variables.status = arguments.status />
	</cffunction>
		
	<cffunction name="getStatus" returntype="string" access="public" output="false">
		<cfreturn variables.status />
	</cffunction>
	
</cfcomponent>