<cfcomponent output="false" extends="tests.mxunit.BaseTest">

	<cffunction name="setup" returntype="void" access="public" output="false">
		<cfset super.setup()/>
	</cffunction>

	<cffunction name="testLifecycle" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>
		<cfset var result = structNew()/>
		<cfset var eventGateway = getServiceBean("eventGateway")/>

		<cfset result.newEvent = createObject("component", "Enlist.model.event.Event").init(argumentCollection=cfg.testData.event)/>
		<cfset assertBeanProperty(structKeyList(cfg.testData.event), result.newEvent)/>

		<cfset eventGateway.saveEvent(result.newEvent)/>

		<cfset result.savedEvent = eventGateway.getEvent(result.newEvent.getId())/>

		<cfset assertBeanProperty(structKeyList(cfg.testData.event), result.savedEvent)/>
	</cffunction>

</cfcomponent>