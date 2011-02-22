<cfsilent>

	<cfset pageTitle = "MXUnit Test Cases"/>
	<cfset testsPath = "/tests/mxunit"/>

	<cfset testCases = arrayNew(1)/>
	<cfset arrayAppend(testCases, createTestCase("EventTest", "#testsPath#/event/EventTest.cfc"))/>
	<cfset arrayAppend(testCases, createTestCase("ActivityTest", "#testsPath#/event/ActivityTest.cfc"))/>
	<cfset arrayAppend(testCases, createTestCase("SecurityManagerTest", "#testsPath#/security/SecurityManagerTest.cfc"))/>

	<cffunction name="createTestCase">
		<cfargument name="name"/>
		<cfargument name="path"/>
		<cfset var testCase = structNew()/>
		<cfset testCase.name = arguments.name/>
		<cfset testCase.path = arguments.path/>
		<cfreturn testCase/>
	</cffunction>

</cfsilent>
<cfoutput>
<html>
<head>
	<title>#pageTitle#</title>
</head>
<body>
	<h1>#pageTitle#</h1>

	<ol>
		<cfloop array="#testCases#" index="testCase">
			<li><a href="#testCase.path#?method=runTestRemote">#testCase.name#</a></li>
		</cfloop>
	</ol>

</body>
</html>
</cfoutput>