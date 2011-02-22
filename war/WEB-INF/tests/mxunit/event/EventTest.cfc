<cfcomponent output="false" extends="tests.mxunit.BaseTest">

	<cffunction name="testLifecycle" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>
		<cfset var result = structNew()/>

		<cfset result.event = createObject("component", "Enlist.model.event.Event").init(argumentCollection=cfg.testData.event)/>
		<cfset assertEquals(cfg.testData.event.name, result.event.getName())/>
	</cffunction>

</cfcomponent>