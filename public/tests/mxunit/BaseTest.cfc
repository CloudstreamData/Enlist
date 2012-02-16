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
<cfcomponent extends="mxunit.framework.TestCase">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="setup" returntype="void" access="private" output="false">

		<cfset var config = structNew() />

		<cfset config.coldspring = structNew() />
		<cfset config.coldspring.configFile = "/enlist/config/services.xml" />
		<cfset config.coldspring.attributes = structNew() />
		<cfset config.coldspring.properties = structNew() />
		<cfset config.coldspring.factory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init(config.coldspring.attributes, config.coldspring.properties) />
		<cfset config.coldspring.factory.loadBeansFromXmlFile(config.coldspring.configFile) />

		<cfset config.testData = getTestData() />
		<cfset setConfig(config) />

		<cfset addAssertDecorator("tests.mxunit.assert.BeanPropertyAssertion") />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getConfig" returntype="struct" access="private" output="false">
		<cfreturn variables.config />
	</cffunction>
	<cffunction name="setConfig" returntype="void" access="private" output="false">
		<cfargument name="config" type="struct" required="true" />
		<cfset variables.config = arguments.config />
	</cffunction>

	<cffunction name="getServiceBean" returntype="any" access="private" output="false">
		<cfargument name="name" type="string" required="true" />

		<cfset var cfg = getConfig() />

		<cfreturn cfg.coldspring.factory.getBean(arguments.name) />
	</cffunction>

	<cffunction name="getTestData" returntype="struct" access="private" output="false">
		<cfset var data = structNew() />
		<cfset var activity = structNew() />
		<cfset var event = structNew() />
		<cfset var volunteer = structNew() />
		<cfset var admin = structNew() />

		<cfset event.name = "Test Event" />
		<cfset event.startDate = createDateTime(2011, 7, 4, 7, 0, 0) />
		<cfset event.endDate = createDateTime(2011, 7, 4, 14, 0, 0) />
		<cfset event.location = "Minneapolis, MN" />
		<cfset event.status = "valid" />
		<cfset data.event = event />

		<cfset activity.title = "Test Activity" />
		<cfset activity.description = "This is a test activity." />
		<cfset activity.numPeople = 5 />
		<cfset activity.startDate = createDateTime(2011, 7, 4, 8, 0, 0) />
		<cfset activity.endDate = createDateTime(2011, 7, 4, 10, 0, 0) />
		<cfset activity.pointHours = 4 />
		<cfset activity.location = "Minneapolis, MN" />
		<cfset data.activity = activity />

		<cfset volunteer.id = createUUID() />
		<cfset volunteer.status = "valid" />
		<cfset volunteer.role = "volunteer" />
		<cfset volunteer.firstName = "Test" />
		<cfset volunteer.lastName = "Volunteer" />
		<cfset volunteer.googleEmail = "enlist-volunteer@gmail.com" />
		<cfset volunteer.altEmail = "" />
		<cfset volunteer.importHashCaod = createUUID() />
		<cfset data.volunteer = volunteer />

		<cfset coordinator.id = createUUID() />
		<cfset coordinator.status = "valid" />
		<cfset coordinator.role = "volunteer,coordinator" />
		<cfset coordinator.firstName = "Test" />
		<cfset coordinator.lastName = "Coordinator" />
		<cfset coordinator.googleEmail = "enlist-coordinator@gmail.com" />
		<cfset coordinator.altEmail = "" />
		<cfset coordinator.importHashCaod = createUUID() />
		<cfset data.coordinator = coordinator />

		<cfset admin.id = createUUID() />
		<cfset admin.status = "valid" />
		<cfset admin.role = "admin" />
		<cfset admin.firstName = "Test" />
		<cfset admin.lastName = "Administrator" />
		<cfset admin.googleEmail = "enlist-admin@gmail.com" />
		<cfset admin.altEmail = "" />
		<cfset admin.importHashCaod = createUUID() />
		<cfset data.admin = admin />

		<cfreturn data />
	</cffunction>

</cfcomponent>