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
	displayname="Activity"
	output="false">

	<!--- PROPERTIES --->
	<cfproperty name="id" type="string" />
	<cfproperty name="title" type="string"/>
	<cfproperty name="description" type="string" />
	<cfproperty name="numPeople" type="string"/>
	<cfproperty name="startDate" type="string"/>
	<cfproperty name="endDate" type="string"/>
	<cfproperty name="pointHours" type="string"/>
	<cfproperty name="location" type="string"/>
	<cfproperty name="event" type="Enlist.model.event.Event" />

	<cfset variables.id = "" />
	<cfset variables.title = ""/>
	<cfset variables.description = ""/>
	<cfset variables.numPeople = ""/>
	<cfset variables.startDate = ""/>
	<cfset variables.endDate = ""/>
	<cfset variables.pointHours = ""/>
	<cfset variables.location = ""/>


	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="Enlist.model.event.activity.Activity">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="title" type="string" required="false" default=""/>
		<cfargument name="description" type="string" required="false" default=""/>
		<cfargument name="numPeople" type="string" required="false" default=""/>
		<cfargument name="startDate" type="string" required="false" default=""/>
		<cfargument name="endDate" type="string" required="false" default=""/>
		<cfargument name="pointHours" type="string" required="false" default=""/>
		<cfargument name="location" type="string" required="false" default=""/>
		<cfargument name="event" type="Enlist.model.event.Event" required="false"/>
		<cfset setInstanceMemento(arguments) />

	   <cfreturn this />
	</cffunction>


	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true" />
		<cfset setId( arguments.data.id ) />
		<cfset setDescription( arguments.data.description ) />
		<cfset setTitle(arguments.data.title)/>
		<cfset setDescription(arguments.data.description)/>
		<cfset setNumPeople(arguments.data.numPeople)/>
		<cfset setStartDate(arguments.data.startDate)/>
		<cfset setEndDate(arguments.data.endDate)/>
		<cfset setPointHours(arguments.data.pointHours)/>
		<cfset setLocation(arguments.data.location)/>
		<cfif structKeyExists(arguments.data, "event")>
			<cfset setEvent(arguments.data.event)/>
		</cfif>
	</cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structnew() />
		<cfset var fieldname = "" />

		<cfloop list="id,eventId,title,description,numPeople,startDate,endDate,pointHours,location" index="fieldname">
			<cfset data[fieldname] = variables[fieldname]>
		</cfloop>

		<cfreturn data />
	</cffunction>


	<!---
	ACCESSORS/MUTATORS
	--->
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.id />
	 </cffunction>
	 <cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = arguments.id />
	 </cffunction>

	<cffunction name="getTitle" returntype="string" access="public" output="false">
		<cfreturn variables.title/>
	</cffunction>
	<cffunction name="setTitle" returntype="void" access="public" output="false">
		<cfargument name="title" type="string" required="true"/>
		<cfset variables.title = arguments.title/>
	</cffunction>

	<cffunction name="getDescription" returntype="string" access="public" output="false">
		<cfreturn variables.description/>
	</cffunction>
	<cffunction name="setDescription" returntype="void" access="public" output="false">
		<cfargument name="description" type="string" required="true"/>
		<cfset variables.description = arguments.description/>
	</cffunction>

	<cffunction name="getNumPeople" returntype="string" access="public" output="false">
		<cfreturn variables.numPeople/>
	</cffunction>
	<cffunction name="setNumPeople" returntype="void" access="public" output="false">
		<cfargument name="numPeople" type="string" required="true"/>
		<cfset variables.numPeople = arguments.numPeople/>
	</cffunction>

	<cffunction name="getStartDate" returntype="string" access="public" output="false">
		<cfreturn variables.startDate/>
	</cffunction>
	<cffunction name="setStartDate" returntype="void" access="public" output="false">
		<cfargument name="startDate" type="string" required="true"/>
		<cfset variables.startDate = arguments.startDate/>
	</cffunction>

	<cffunction name="getEndDate" returntype="string" access="public" output="false">
		<cfreturn variables.endDate/>
	</cffunction>
	<cffunction name="setEndDate" returntype="void" access="public" output="false">
		<cfargument name="endDate" type="string" required="true"/>
		<cfset variables.endDate = arguments.endDate/>
	</cffunction>

	<cffunction name="getPointHours" returntype="string" access="public" output="false">
		<cfreturn variables.pointHours/>
	</cffunction>
	<cffunction name="setPointHours" returntype="void" access="public" output="false">
		<cfargument name="pointHours" type="string" required="true"/>
		<cfset variables.pointHours = arguments.pointHours/>
	</cffunction>

	<cffunction name="getLocation" returntype="string" access="public" output="false">
		<cfreturn variables.location/>
	</cffunction>
	<cffunction name="setLocation" returntype="void" access="public" output="false">
		<cfargument name="location" type="string" required="true"/>
		<cfset variables.location = arguments.location/>
	</cffunction>

	<cffunction name="getEvent" access="public" returntype="Enlist.model.event.Event" output="false">
		<cfreturn variables.event />
	</cffunction>
	<cffunction name="setEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="Enlist.model.event.Event" required="true" />
		<cfset variables.event = arguments.event />
		<cfset variables.eventId = arguments.event.getId() />
	</cffunction>
	<cffunction name="getEventId" access="public" output="false" returntype="string">
		<cfreturn variables.eventId />
	</cffunction>

</cfcomponent>