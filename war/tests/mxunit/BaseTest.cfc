<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="setup" returntype="void" access="private" output="false">
		<cfset var config = structNew()/>

		<cfset config.testData = getTestData()/>
		<cfset setConfig(config)/>
		<cfset addAssertDecorator("tests.mxunit.assert.BeanPropertyAssertion")/>
	</cffunction>

	<cffunction name="getConfig" returntype="struct" access="private" output="false">
		<cfreturn variables.config/>
	</cffunction>
	<cffunction name="setConfig" returntype="void" access="private" output="false">
		<cfargument name="config" type="struct" required="true"/>
		<cfset variables.config = arguments.config/>
	</cffunction>

	<cffunction name="getTestData" returntype="struct" access="private" output="false">
		<cfset var data = structNew()/>
		<cfset var activity = structNew()/>
		<cfset var event = structNew()/>

		<cfset event.name = "Test Event"/>
		<cfset event.startDate = createDateTime(2011, 7, 4, 7, 0, 0)/>
		<cfset event.endDate = createDateTime(2011, 7, 4, 14, 0, 0)/>
		<cfset event.location = "Minneapolis, MN"/>
		<cfset event.status = "valid"/>
		<cfset data.event = event/>

		<cfset activity.title = "Test Activity"/>
		<cfset activity.description = "This is a test activity."/>
		<cfset activity.numPeople = 5/>
		<cfset activity.startDate = createDateTime(2011, 7, 4, 8, 0, 0)/>
		<cfset activity.endDate = createDateTime(2011, 7, 4, 10, 0, 0)/>
		<cfset activity.pointHours = 4/>
		<cfset activity.location = "Minneapolis, MN"/>
		<cfset data.activity = activity/>

		<cfreturn data/>
	</cffunction>

</cfcomponent>