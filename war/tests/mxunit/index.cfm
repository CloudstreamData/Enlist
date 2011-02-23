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