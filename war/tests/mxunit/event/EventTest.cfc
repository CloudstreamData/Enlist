<cfcomponent output="false" extends="tests.mxunit.BaseTest">

	<cffunction name="setup" returntype="void" access="public" output="false">
		<cfset super.setup()/>
	</cffunction>

	<cffunction name="testLifecycle" returntype="void" access="public" output="false">
		<cfset var cfg = getConfig()/>
		<cfset var result = structNew()/>

		<cfset result.event = createObject("component", "Enlist.model.event.Event").init(argumentCollection=cfg.testData.event)/>
		<cfset assertBeanProperty(structKeyList(cfg.testData.event), result.event)/>
	</cffunction>

</cfcomponent>