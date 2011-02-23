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
--->
<cfcomponent output="false" extends="tests.mxunit.BaseTest">

	<cffunction name="setup" returntype="void" access="public" output="false">
		<cfset super.setup()/>
	</cffunction>


	<cffunction name="testLifecycle" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>
		<cfset var result = structNew()/>
		<cfset var activityGateway = getServiceBean("activityGateway")/>
		<cfset var eventGateway = getServiceBean("eventGateway")/>

		<cfset result.newEvent = createObject("component", "Enlist.model.event.Event").init(argumentCollection=cfg.testData.event)/>
		<cfset eventGateway.saveEvent(result.newEvent)/>

		<cfset result.newActivity = createObject("component", "Enlist.model.event.activity.Activity").init(argumentCollection=cfg.testData.activity)/>
		<cfset result.newActivity.setEvent(result.newEvent)/>

		<cfset activityGateway.saveActivity(result.newActivity)/>

		<cfset result.savedActivity = activityGateway.getActivity(result.newActivity.getId())/>
		<cfset assertBeanProperty(structKeyList(cfg.testData.activity), result.savedActivity)/>
	</cffunction>

</cfcomponent>