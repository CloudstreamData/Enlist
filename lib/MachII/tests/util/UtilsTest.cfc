<!---

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2010 GreatBizTools, LLC

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
 
	As a special exception, the copyright holders of this library give you 
	permission to link this library with independent modules to produce an 
	executable, regardless of the license terms of these independent 
	modules, and to copy and distribute the resultant executable under 
	the terms of your choice, provided that you also meet, for each linked 
	independent module, the terms and conditions of the license of that
	module.  An independent module is a module which is not derived from 
	or based on this library and communicates with Mach-II solely through 
	the public interfaces* (see definition below). If you modify this library, 
	but you may extend this exception to your version of the library, 
	but you are not obligated to do so. If you do not wish to do so, 
	delete this exception statement from your version.


	* An independent module is a module which not derived from or based on 
	this library with the exception of independent module components that 
	extend certain Mach-II public interfaces (see README for list of public 
	interfaces).

Author: Peter J. Farrell (peter@mach-ii.com)
$Id: UtilsTest.cfc 2663 2011-02-15 17:35:46Z peterjfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent
	displayname="Utils"
	extends="mxunit.framework.TestCase"
	hint="Test cases for MachII.util.Utils.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.utils = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="setup" access="public" returntype="void" output="false"
		hint="Logic to run to setup before each test case method.">
		<cfset variables.utils = CreateObject("component", "MachII.util.Utils").init() />
	</cffunction>
	
	<cffunction name="tearDown" access="public" returntype="void" output="false"
		hint="Logic to run to tear down after each test case method.">
		<!--- Does nothing --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - TEST CASES
	--->
	<cffunction name="testExpandRelativePath" access="public" returntype="void" output="false"
		hint="Test expandRelativePath().">

		<!--- Test move up directory with file--->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "../../Test.cfc"), "/a/b/c/Test.cfc") />
		<!--- Test same directory with file --->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "./1/2/3/Test.cfc"), "/a/b/c/d/e/1/2/3/Test.cfc") />
		
		<!--- Test move up directory with just a directory and trailing slash --->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "../../Test/"), "/a/b/c/Test/") />
		<!--- Test same directory with just a directory and trailing slash --->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "./1/2/3/Test/"), "/a/b/c/d/e/1/2/3/Test/") />

		<!--- Test move up directory with just a directory and no trailing slash --->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "../../Test"), "/a/b/c/Test") />
		<!--- Test same directory with just a directory and no trailing slash --->
		<cfset assertEquals(variables.utils.expandRelativePath("/a/b/c/d/e/", "./1/2/3/Test"), "/a/b/c/d/e/1/2/3/Test") />
	</cffunction>
	
	<cffunction name="testRecurseComplexValuesWithStruct" access="public" returntype="void" output="false"
		hint="Tests recurseComplexValues() with struct syntax.">
		
		<cfset var xml = XmlParse('<root><struct name="test"><key name="a" value="1"/><key name="b"><value>2</value></key></struct></root>') />
		<cfset var comparison = StructNew() />
		
		<!--- Create comparison data --->
		<!--- For some reason, not using quotes around the values causes the test case to fail on Open BD --->
		<cfset comparison.a = "1" />
		<cfset comparison.b = "2" />
		
		<cfset assertTrue(comparison.equals(variables.utils.recurseComplexValues(xml.root))) />
	</cffunction>

	<cffunction name="testRecurseComplexValuesWithArray" access="public" returntype="void" output="false"
		hint="Tests recurseComplexValues() with array syntax.">
		
		<cfset var xml = XmlParse('<root><array name="test"><element value="1"/><element><value>2</value></element></array></root>') />
		<cfset var comparison = ArrayNew(1) />
		
		<!--- Create comparison data --->
		<!--- For some reason, not using quotes around the values causes the test case to fail on Open BD --->
		<cfset comparison[1] = "1" />
		<cfset comparison[2] = "2" />
		
		<cfset assertTrue(comparison.equals(variables.utils.recurseComplexValues(xml.root))) />
	</cffunction>
	
	<cffunction name="testRecurseComplexValuesWithSimple" access="public" returntype="void" output="false"
		hint="Tests recurseComplexValues() with simple value syntax.">
		
		<cfset var xml = XmlParse('<root><value>simple</value></root>') />
		
		<cfset assertEquals(variables.utils.recurseComplexValues(xml.root), "simple") />
	</cffunction>
	
	<cffunction name="testRecurseComplexValuesWithNested" access="public" returntype="void" output="false"
		hint="Tests recurseComplexValues() with struct syntax.">
		
		<cfset var xml = XmlParse('<root><struct name="test"><key name="a" value="1"/><key name="b"><array name="test"><element value="1"/><element><value>2</value></element></array></key><key name="c"><value>simple</value></key></struct></root>') />
		<cfset var comparison = StructNew() />

		<!--- Create comparison data --->
		<!--- For some reason, not using quotes around the values causes the test case to fail on Open BD --->
		<cfset comparison.a = "1" />
		<cfset comparison.b = ArrayNew(1) />
		<cfset comparison.b[1] = "1" />
		<cfset comparison.b[2] = "2" />
		<cfset comparison.c = "simple" />
		
		<cfset assertTrue(comparison.equals(variables.utils.recurseComplexValues(xml.root))) />
	</cffunction>
	
	<cffunction name="testAssertSame" access="public" returntype="void" output="false"
		hint="Tests assertSame().">
		
		<cfset var obj1 = CreateObject("component", "MachII.framework.Event").init() />
		<cfset var obj2 = CreateObject("component", "MachII.framework.Event").init() />
		
		<!--- Compare the same object instance which usually would be a different variable name --->
		<cfset assertTrue(variables.utils.assertSame(obj1, obj1)) />
		
		<!--- This should fail because it's not the same object instance --->
		<cfset assertFalse(variables.utils.assertSame(obj1, obj2)) />
	</cffunction>
	
	<cffunction name="testTrimList" access="public" returntype="void" output="false"
		hint="Test trimList().">
		
		<cfset var comparisonList = "apples,oranges,pears" />
		<cfset var returnedList = variables.utils.trimList(" apples, oranges ,pears ") />
		
		<cfset assertEquals(returnedList, comparisonList) />
	</cffunction>
	
	<cffunction name="testEscapeHtml" access="public" returntype="void" output="false"
		hint="Test escapeHtml().">
		<cfset assertTrue(Compare(variables.utils.escapeHtml("< > Planchers de bambou, li&egrave;ge, ch&ecirc;ne FSC, &eacute;rable FSC, pin et eucalyptus &eacute;cologiques et durables &&& Peter&Matt"), "&lt; &gt; Planchers de bambou, li&egrave;ge, ch&ecirc;ne FSC, &eacute;rable FSC, pin et eucalyptus &eacute;cologiques et durables &amp;&amp;&amp; Peter&amp;Matt") EQ 0) />
	</cffunction>
	
	<cffunction name="testGetMimeTypeByFileExtension" access="public" returntype="void" output="false"
		hint="Test getMimeTypeByFileExtension()">
		
		<!--- Test single --->
		<cfset assertEquals(variables.utils.getMimeTypeByFileExtension(".jpg,"), "image/jpeg") />
		
		<!--- Test mixed file extensions and mime types --->
		<cfset assertEquals(variables.utils.getMimeTypeByFileExtension(".jpg,.gif,.zip,audio/x-wav"), "image/jpeg,image/gif,application/x-gzip,audio/x-wav") />

		<!--- Test mixed file extensions as array and mime types --->
		<cfset assertEquals(variables.utils.getMimeTypeByFileExtension(['.jpg','.gif','.zip','audio/x-wav']), "image/jpeg,image/gif,application/x-gzip,audio/x-wav") />

		<!--- Test treat all as file extensions (with or without '.' dots) --->
		<cfset assertEquals(variables.utils.getMimeTypeByFileExtension(".jpg,.gif,.zip,htm,html", StructNew(), true), "image/jpeg,image/gif,application/x-gzip,text/html,text/html") />
	</cffunction>

	<cffunction name="testCleanPathInfo" access="public" returntype="void" output="false"
		hint="Test cleanPathInfo()">
		<!--- Check for URL decoding "/test/../something"--->
		<cfset assertEquals("/test/../something", variables.utils.cleanPathInfo("/test/%2e%2e/something", "")) />
		<!--- Check that IIS6 bug "/index.cfm/test/something" --->
		<cfset assertEquals("/test/something", variables.utils.cleanPathInfo("index.cfm/test/something", "index.cfm")) />
		<!--- Check to see if URL decoding is off --->
		<cfset assertEquals("/test/%2e%2e/something", variables.utils.cleanPathInfo("/test/%2e%2e/something", "", false)) />
	</cffunction>
	
	<cffunction name="testCreateDatetimeFromHttpTimeString" access="public" returntype="void" output="false"
		hint="Test createDatetimeFromHttpTimeString()">
		<cfset assertEquals(CreateDateTime("2010", "8", "11", "17", "58", "48"), variables.utils.createDatetimeFromHttpTimeString("11 Aug 2010 17:58:48 GMT")) />
	</cffunction>

	<cffunction name="testConvertTimespanStringToSeconds" access="public" returntype="void" output="false"
		hint="Test convertTimespanStringToSeconds()">
		<!--- Zero --->
		<cfset assertEquals(0, variables.utils.convertTimespanStringToSeconds("0,0,0,0")) />
		<!--- Minute --->
		<cfset assertEquals(60, variables.utils.convertTimespanStringToSeconds("0,0,1,0")) />
		<!--- Hour --->
		<cfset assertEquals(3600, variables.utils.convertTimespanStringToSeconds("0,1,0,0")) />
		<!--- Day --->
		<cfset assertEquals(86400, variables.utils.convertTimespanStringToSeconds("1,0,0,0")) />
		<!--- Year --->
		<cfset assertEquals(31536000, variables.utils.convertTimespanStringToSeconds("365,0,0,0")) />
	</cffunction>
	
	<cffunction name="testFilePathClean" access="public" returntype="void" output="false"
		hint="Test filePathClean()">
		<!--- Test ./ and ../ --->
		<cfset assertEquals("/test/to/myfile.txt", variables.utils.filePathClean("/test/./../../to/../myfile.txt")) />
		<!--- Test doubl // angled hockey sticks --->
		<cfset assertEquals("/test/to/myfile.txt", variables.utils.filePathClean("/test/to//myfile.txt")) />
		<!--- Test leading ./ --->
		<cfset assertEquals("test/to/myfile.txt", variables.utils.filePathClean("./test/to/myfile.txt")) />
		<!--- Test leading ../ --->
		<cfset assertEquals("test/to/myfile.txt", variables.utils.filePathClean("../test/to/myfile.txt")) />
	</cffunction>

	<cffunction name="testGetHTTPHeaderStatusTextByStatusCode" access="public" returntype="void" output="false"
		hint="Test getHTTPHeaderStatusTextByStatusCode()">
		<cfset assertEquals("Not Modified", variables.utils.getHTTPHeaderStatusTextByStatusCode(304)) />
		<cfset assertEquals("", variables.utils.getHTTPHeaderStatusTextByStatusCode(999)) />
	</cffunction>
	
	<cffunction name="testLoadResourceData" access="public" returntype="void" output="false"
		hint="Test loadResourceData()">
		
		<cfset var results = "" />
		
		<cfset results = variables.utils.loadResourceData("/MachII/tests/dummy/resource/simple.properties") />
		
		<cfset debug(results) />
		
		<cfset assertEquals(1, results.a) />
		<cfset assertEquals(2, results.b) />
		<cfset assertEquals(3, results.c) />
		
		<cfset results = variables.utils.loadResourceData("/MachII/tests/dummy/resource/complexValues.properties", "first,second,third") />
		
		<cfset debug(results) />

		<cfset assertEquals(1, results.a.first) />
		<cfset assertEquals(5, results.b.second) />
		<cfset assertEquals(9, results.c.third) />
		<cfset assertEquals(10, results.d.first) />
		<cfset assertEquals("", results.d.second) />
		
	</cffunction>

</cfcomponent>