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