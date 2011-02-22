<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="setup" returntype="void" access="private" output="false">
		<cfset var config = structNew()/>

		<cfset config.coldspring = structNew()/>
		<cfset config.coldspring.configFile = "/Enlist/config/services.xml"/>
		<cfset config.coldspring.attributes = structNew()/>
		<cfset config.coldspring.properties = structNew()/>
		<cfset config.coldspring.factory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init(config.coldspring.attributes, config.coldspring.properties)/>
		<cfset config.coldspring.factory.loadBeansFromXmlFile(config.coldspring.configFile)/>

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

	<cffunction name="getServiceBean" returntype="any" access="private" output="false">
		<cfargument name="name" type="string" required="true"/>

		<cfset var cfg = getConfig()/>

		<cfreturn cfg.coldspring.factory.getBean(arguments.name)/>
	</cffunction>

	<cffunction name="getTestData" returntype="struct" access="private" output="false">
		<cfset var data = structNew()/>
		<cfset var activity = structNew()/>
		<cfset var event = structNew()/>
		<cfset var volunteer = structNew()/>
		<cfset var admin = structNew()/>

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

		<cfset volunteer.id = createUUID()/>
		<cfset volunteer.status = "valid"/>
		<cfset volunteer.role = "volunteer"/>
		<cfset volunteer.firstName = "Test"/>
		<cfset volunteer.lastName = "Volunteer"/>
		<cfset volunteer.googleEmail = "enlist-volunteer@gmail.com"/>
		<cfset volunteer.altEmail = ""/>
		<cfset volunteer.importHashCaod = createUUID()/>
		<cfset data.volunteer = data/>

		<cfset admin.id = createUUID()/>
		<cfset admin.status = "valid"/>
		<cfset admin.role = "admin"/>
		<cfset admin.firstName = "Test"/>
		<cfset admin.lastName = "Administrator"/>
		<cfset admin.googleEmail = "enlist-admin@gmail.com"/>
		<cfset admin.altEmail = ""/>
		<cfset admin.importHashCaod = createUUID()/>
		<cfset data.admin = data/>

		<cfreturn data/>
	</cffunction>

</cfcomponent>