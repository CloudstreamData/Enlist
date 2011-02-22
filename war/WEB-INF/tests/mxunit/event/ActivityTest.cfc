<cfcomponent output="false" extends="tests.mxunit.BaseTest">

	<cffunction name="setup" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>

		<!--- Tweaks to the test data could be done here. --->
	</cffunction>


	<cffunction name="testLifecycle" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>
		<cfset var result = structNew()/>

		<cfset result.event = createObject("component", "Enlist.model.event.Event").init(argumentCollection=cfg.testData.event)/>
		<cfset result.activity = createObject("component", "Enlist.model.event.activity.Activity").init(argumentCollection=cfg.testData.activity)/>
		<cfset result.activity.setEvent(result.event)/>
		<cfset assertEquals(cfg.testData.activity.title, result.activity.getTitle())/>
	</cffunction>

</cfcomponent>