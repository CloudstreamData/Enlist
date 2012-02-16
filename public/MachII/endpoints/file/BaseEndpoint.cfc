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
$Id: BaseEndpoint.cfc 2850 2011-09-09 04:05:10Z peterjfarrell $

Created version: 1.9.0

Notes:

Information on mod x-sendfile for Apache can be found here:
http://tn123.ath.cx/mod_xsendfile/

Configuration Notes:

<endpoints>
	<endpoint name="dashboard.serveAsset" type="MachII.endpoints.file.BaseEndpoint">
		<parameters>
			<!-- Whether or not to use the urlBaseSecure value for HTTPS urls or normal urlBase value -->
			<parameter name="secure" value="false"/>
			<parameter name="basePath" value="/MachII/dashboard/assets"/>
			<parameter name="servingEngineType" value="cfcontent|sendfile" />
			<!--
			Uses Apache "style" syntax which supports "access" or "modified" with
			days,hours,minutes,seconds timespan format or the value of "none" if
			no expires header should be used.
			-->
			<parameter name="expiresDefault" value="access plus 365,0,0,0" />
			<parameter name="attachmentDefault" value="false" />
			<parameter name="timestampDefault" value="true" />
			<parameter name="fileTypeSettings">
				<struct>
					<key name=".js,.css,.jpg,.gif,.png">
						<struct>
							<key name="expires" value="access plus 365,0,0,0"/>
							<key name="attachment" value="false" />
						</struct>
					</key>
					<key name=".pdf">
						<struct>
							<key name="expires" value="access plus 0,0,0,0"/>
							<key name="attachment" value="true" />
							<key name="timestamp" value="false" />
						</struct>
					</key>
				</struct>
			</parameter>
			<!-- By default, the endpoint will not serve .cfm file unless you indicate a "safe" list -->
			<parameter name="cfmFiles" value="/css/basic.cfm,/css/dialog.cfm" />
			<!-- Or an array -->
			<parameter name="cfmFiles">
				<array>
					<element value="/css/basic.cfm" />
					<element value="/css/dialog.cfm" />
				</array>
			</parameter>
			<!-- Or the least secure which indicates all .cfm files in the base path can be served -->
			<parameter name="cfmFiles" value="*" />
		</parameters>
	</endpoint>
</endpoints>

--->
<cfcomponent
	displayname="FileEndpoint"
	extends="MachII.endpoints.AbstractEndpoint"
	output="false"
	hint="Base endpoint for all file serve endpoints to be exposed directly by Mach-II.">

	<!---
	PROPERTIES
	--->
	<cfset variables.basePath = "" />
	<cfset variables.servingEngineType = "cfcontent" />
	<cfset variables.expiresDefault = StructNew() />
	<cfset variables.attachmentDefault = false />
	<cfset variables.timestampDefault = true />
	<cfset variables.expireMap = StructNew() />
	<cfset variables.attachmentMap = StructNew() />
	<cfset variables.timestampMap = StructNew() />
	<cfset variables.cfmSafePatterns = ArrayNew(1) />
	<!--- We need case sensitive keys so fallback to Java Hash Map --->
	<cfset variables.cfmFileMatchCache = CreateObject("java", "java.util.HashMap").init() />
	<cfset variables.urlBase = "" />
	<cfset variables.matcher = "" />

	<!---
	CONSTANTS
	--->
	<!--- Epoch timestamp in UTC --->
	<cfset variables.EPOCH_TIMESTAMP = DateConvert("local2Utc", CreateDatetime(1970, 1, 1, 0, 0, 0)) />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the file serve endpoint. Override to provide custom functionality and call super.preProcess().">

		<cfset var temp = "" />

		<!--- Test for getFileInfo() --->
		<cftry>
			<cfset getFileInfo("ExpandPath(./BaseEndpoint.cfc)") />
			<cfcatch type="any">
				<cfset variables.getFileInfo = getUtils().getFileInfo_cfdirectory />
				<cfset this.getFileInfo = getUtils().getFileInfo_cfdirectory />
			</cfcatch>
		</cftry>

		<cfif getParameter("secure", false)>
			<cfset setUrlBase(getProperty("urlBaseSecure")) />
		<cfelse>
			<cfset setUrlBase(getProperty("urlBase")) />
		</cfif>
		<cfset setBasePath(getParameter("basePath")) />
		<cfset setServiceEngineType(getParameter("serviceEngineType", "cfcontent")) />
		<cfset setExpiresDefault(getParameter("expiresDefault", "access plus 365,0,0,0")) />
		<cfset setAttachmentDefault(getParameter("attachmentDefault", "false")) />
		<cfset setTimestampDefault(getParameter("timestampDefault", "true")) />

		<cfset variables.matcher = CreateObject("component", "MachII.util.matching.SimplePatternMatcher").init() />

		<!--- Setup the lookup maps --->
		<cfset buildFileSettingsMap() />
		<cfset buildCfmSafePatterns() />
	</cffunction>

	<cffunction name="buildFileSettingsMap" access="private" returntype="void" output="false"
		hint="Builds the file settings map for expire and attachment settings by file type.">

		<cfset var rawSettings = getParameter("fileTypeSettings", StructNew()) />
		<cfset var expireMap = StructNew() />
		<cfset var attachmentMap = StructNew() />
		<cfset var timestampMap = StructNew() />
		<cfset var fileExtensionsArray = "" />
		<cfset var key = "" />
		<cfset var temp = "" />
		<cfset var fileExtension = "" />
		<cfset var expires = "" />
		<cfset var attachment = "" />
		<cfset var timestamp = "" />
		<cfset var i = 0 />

		<cfloop collection="#rawSettings#" item="key">

			<cfset temp = StructFind(rawSettings, key) />

			<cfif StructKeyExists(temp, "expires")>
				<cfset expires = parseExpiresLanguage(temp.expires) />
			<cfelse>
				<cfset expires = getExpiresDefault() />
			</cfif>

			<cfif StructKeyExists(temp, "attachment")>
				<cfset attachment = temp.attachment />
			<cfelse>
				<cfset attachment = getAttachmentDefault() />
			</cfif>

			<cfif StructKeyExists(temp, "timestamp")>
				<cfset timestamp = temp.timestamp />
			<cfelse>
				<cfset timestamp = getTimestampDefault() />
			</cfif>

			<cfset fileExtensionsArray = ListToArray(key) />

			<cfloop from="1" to="#ArrayLen(fileExtensionsArray)#" index="i">
				<cfset fileExtension = ReplaceNoCase(fileExtensionsArray[i], ".", "", "all") />
				<cfset expireMap[fileExtension] = expires />
				<cfset attachmentMap[fileExtension] = attachment />
				<cfset timestampMap[fileExtension] = timestamp />
			</cfloop>
		</cfloop>

		<cfset variables.expireMap = expireMap />
		<cfset variables.attachmentMap = attachmentMap />
		<cfset variables.timestampMap = timestampMap />
	</cffunction>

	<cffunction name="buildCfmSafePatterns" access="private" returntyp="void" output="false"
		hint="Builds the .cfm safe patterns.">

		<cfset var rawSettings = getParameter("cfmFiles", "") />

		<!--- We allow lists or array --->
		<cfif IsSimpleValue(rawSettings)>
			<cfset rawSettings = ListToArray(rawSettings) />
		</cfif>

		<cfset variables.cfmSafePatterns = rawSettings />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="false"
		hint="Runs when an endpoint request begins. Override to provide custom functionality and call super.preProcess().">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset var pathInfo = getUtils().cleanPathInfo(cgi.PATH_INFO, cgi.SCRIPT_NAME) />
		<cfset var filePath = "" />
		<cfset var fileExtension = "" />
		<cfset var pipeExtension = "" />

		<!---
		Get file path with support URIs where the file is defined in the pathInfo
		Checking the length of the path info is required in case the url looks like
		/index.cfm/dashboard.serveAsset/?file=/some/path/to/file.txt
		--->
		<cfif Len(pathInfo) AND ListLen(pathInfo, "/") GT 1>
			<!--- By default, cleanPathInfo() uses URLDecode() which helps against directory transversal attacks using unicode --->
			<cfset filePath = ListDeleteAt(pathInfo, 1, "/") />
		<cfelse>
			<!--- Manually decode the file argument to help protect against directory transversal attacks using unicode --->
			<cfset filePath = URLDecode(arguments.event.getArg("file")) />
		</cfif>

		<!--- Clean up the file path for directory transveral type attacks --->
		<cfset filePath = getUtils().filePathClean(filePath) />

		<!--- Setup the file extension and any piping extension --->
		<cfset fileExtension = ListFirst(ListLast(filePath, "."), ":") />
		<cfset arguments.event.setArg("fileExtension", fileExtension) />

		<!--- Clean up any piping extension on the file path --->
		<cfset arguments.event.setArg("file", ListFirst(filePath, ":")) />
		<cfif fileExtension EQ "cfm">
			<cfset arguments.event.setArg("fileFullPath", getBasePath() & ListFirst(filePath, ":")) />
		<cfelse>
			<cfset arguments.event.setArg("fileFullPath", ExpandPath(getBasePath()) & ListFirst(filePath, ":")) />
		</cfif>

		<!--- Set up the piping --->
		<cfif ListLen(filePath, ":") EQ 2>
			<cfset pipeExtension =  ListLast(filePath, ":") />
			<cfif NOT Len(pipeExtension)>
				<cfset pipeExtension = "htm" />
			</cfif>
			<cfset arguments.event.setArg("pipe", pipeExtension) />
		</cfif>

		<!--- Set expiry type and value --->
		<cfif fileExtension EQ "cfm" AND StructKeyExists(variables.expireMap, pipeExtension)>
			<cfset arguments.event.setArg("expires", variables.expireMap[pipeExtension]) />
		<cfelseif StructKeyExists(variables.expireMap, fileExtension)>
			<cfset arguments.event.setArg("expires", variables.expireMap[fileExtension]) />
		<cfelse>
			<cfset arguments.event.setArg("expires", getExpiresDefault()) />
		</cfif>

		<!--- Process attachment type --->
		<cfif NOT arguments.event.isArgDefined("attachment")>
			<cfif StructKeyExists(variables.attachmentMap, arguments.event.getArg("pipe", fileExtension)) AND variables.attachmentMap[arguments.event.getArg("pipe", fileExtension)]>
				<cfset arguments.event.setArg("attachment", getFileFromPath(ReplaceNoCase(arguments.event.getArg("file"), "." & fileExtension, "." & pipeExtension))) />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="handleRequest" access="public" returntype="void" output="true"
		hint="Serves the file request.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfif arguments.event.getArg("fileExtension") EQ "cfm">
			<cfif matchCfmFile(arguments.event.getArg("file"))>
				<cfcontent reset="true"><cfsetting enablecfoutputonly="false" /><cfoutput>#serveCfmFile(arguments.event.getArg("fileFullPath"), arguments.event.getArg("expires"), arguments.event.getArg("attachment"), arguments.event.getArg("pipe", "htm"))#</cfoutput><cfsetting enablecfoutputonly="true" />
			<cfelse>
				<cfthrow type="MachII.endpoints.file.cfmNotAuthorized"
					message="The file path '#arguments.event.getArg("file")#' is not an allowed .cfm file." />
			</cfif>
		<cfelse>
			<cfset serveStaticFile(arguments.event.getArg("fileFullPath"), arguments.event.getArg("expires"), arguments.event.getArg("attachment")) />
		</cfif>
	</cffunction>

	<cffunction name="onException" access="public" returntype="void" output="true"
		hint="Runs when an exception occurs in the endpoint.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true"
			hint="The Exception that was thrown/caught by the endpoint request processor." />

		<!--- Handle notFound --->
		<cfif arguments.exception.getType() EQ "MachII.endpoints.file.notFound" AND NOT (arguments.event.isArgDefined("throw") AND getEnableThrow())>
			<cfset addHTTPHeaderByStatus(404) />
			<cfset addHTTPHeaderByName("machii.endpoint.error", arguments.exception.getMessage()) />
			<cfsetting enablecfoutputonly="false" /><cfoutput>404 Not Found - #arguments.exception.getMessage()#</cfoutput><cfsetting enablecfoutputonly="true" />
		<!--- Handle cfmNotAuthorized --->
		<cfelseif arguments.exception.getType() EQ "MachII.endpoints.file.cfmNotAuthorized" AND NOT (arguments.event.isArgDefined("throw") AND getEnableThrow())>
			<cfset addHTTPHeaderByStatus(401) />
			<cfset addHTTPHeaderByName("machii.endpoint.error", arguments.exception.getMessage()) />
			<cfsetting enablecfoutputonly="false" /><cfoutput>401 Not Authorized- #arguments.exception.getMessage()#</cfoutput><cfsetting enablecfoutputonly="true" />
		<!--- Default exception handling --->
		<cfelse>
			<cfset super.onException(arguments.event, arguments.exception) />
		</cfif>
	</cffunction>

	<cffunction name="buildEndpointUrl" access="public" returntype="string" output="false"
		hint="Builds an URL formatted for file server endpoint. Arguments that are passed that do not match the method signature will be appended to the query string of this URL.">
		<cfargument name="file" type="string" required="true"
			hint="The path to the file." />
		<cfargument name="pipe" type="string" required="false"
			hint="The pipe extension for the URL (e.g. css, js, etc.)." />
		<cfargument name="attachment" type="string" required="false"
			hint="The file name to use if an attachment download is requested. If boolean 'true', the file name is be computed using the pipe extension if applicable." />
		<!--- Any other arugments will be appended as query string params --->

		<cfset var builtUrl = "" />
		<cfset var urlBase = getUrlBase() />
		<cfset var fileName = "" />
		<cfset var fileExtension = ListFirst(ListLast(arguments.file, "."), ":") />
		<cfset var queryString = "" />
		<cfset var assetTimestamp = "" />
		<cfset var key = "" />

		<cfif NOT getProperty("urlParseSES")>
			<cfset builtUrl = urlBase />
			<cfset queryString = ListAppend(queryString, "endpoint=" & getParameter("name"), "&") />
			<cfset queryString = ListAppend(queryString, "file=" & arguments.file, "&") />
		<cfelse>
			<cfif NOT urlBase.endsWith("/")>
				<cfset urlBase = urlBase & "/" />
			</cfif>
			<cfset builtUrl = urlBase & getParameter("name") />
			<cfif NOT arguments.file.startsWith("/")>
				<cfset builtUrl = builtUrl & "/" />
			</cfif>
			<cfset builtUrl = builtUrl & arguments.file />
		</cfif>

		<!--- Add in pipe if availanble --->
		<cfif StructKeyExists(arguments, "pipe")>
			<cfset builtUrl = builtUrl & ":" & arguments.pipe />
		</cfif>

		<!---
		Build optional query string parameters
		* Attachment
		* Timestamp
		--->
		<cfif StructKeyExists(arguments, "attachment")>
			<cfif IsBoolean(arguments.attachment) AND arguments.attachment>
				<cfset fileName = getFileFromPath(arguments.file) />
				<cfset arguments.attachment = ReplaceNoCase(getFileFromPath(fileName), "." & fileExtension, "." & arguments.pipe) />
			</cfif>

			<cfset queryString = ListAppend(queryString, "attachment=" & arguments.attachment, "&") />
		</cfif>

		<!--- Append additional developer passed query string params --->
		<cfloop collection="#arguments#" item="key">
			<!--- Append if the argument isn't one in the block list because they are preprocessed differently --->
			<cfif NOT ListFindNoCase("endpoint,file,pipe,attachment", key)>
				<cfset queryString = ListAppend(queryString, key & "=" & arguments[key], "&") />
			</cfif>
		</cfloop>

		<!--- Alwasy append the asset timestamp on to the query string last --->
		<cfif (StructKeyExists(variables.timestampMap, fileExtension) AND variables.timestampMap[fileExtension]) OR (NOT StructKeyExists(variables.timestampMap, fileExtension) AND getTimestampDefault())>
			<cfset assetTimestamp = fetchAssetTimestamp(ListFirst(arguments.file, ":")) />
			<cfif assetTimestamp NEQ 0>
				<cfset queryString = ListAppend(queryString, assetTimestamp, "&") />
			</cfif>
		</cfif>

		<!--- Append query string if any optional parameters were construct --->
		<cfif Len(queryString)>
			<cfset builtUrl = builtUrl & "?" & queryString />
		</cfif>

		<cfreturn builtUrl />
	</cffunction>

	<!---
	PROTECTED FUNCTIONS - GENERAL
	--->
	<cffunction name="serveCfmFile" access="private" returntype="string" output="false"
		hint="Serves a cfm file.">
		<cfargument name="fileFullPath" type="string" required="true"
			hint="The full path to the file." />
		<cfargument name="expires" type="struct" required="true"
			hint="The expires struct." />
		<cfargument name="attachment" type="string" required="true"
			hint="The name of the file if an attachment. Zero-length string means not to send as attachment." />
		<cfargument name="pipeExtension" type="string" required="true"
			hint="The file extension type to pipe the output to (.cfm -> .css)." />

		<cfset var contentType = getContentTypeFromFilePath(arguments.pipeExtension) />
		<cfset var fileInfo = "" />
		<cfset var output = "" />

		<!--- Read file info for last-modified headers --->
		<cftry>
			<cfset fileInfo = getFileInfo(ExpandPath(fileFullPath)) />

			<!--- Assert the requested file was found (only throw the relative path for security reasons) --->
			<cfif fileInfo.type NEQ "file">
				<cfthrow />
			</cfif>
			<cfcatch type="any">
				<cfthrow type="MachII.endpoints.file.notFound"
					message="Cannot fetch file information for the request file path because it cannot be located. Check for your file path."
					detail="File path: '#getFileFromPath(fileFullPath)#'." />
			</cfcatch>
		</cftry>

		<cfset addHTTPHeaderByName("Content-Type", contentType) />

		<!--- Set the expires header using either access or modified --->
		<cfif arguments.expires.type EQ "access">
			<cfset addHTTPHeaderByName("Expires", GetHttpTimeString(Now() + arguments.expires.amount)) />
		<cfelseif arguments.expires.type EQ "modified">
			<cfset addHTTPHeaderByName("Expires", GetHttpTimeString(fileInfo.lastModified + arguments.expires.amount)) />
		</cfif>

		<cfif Len(arguments.attachment)>
			<cfset addHTTPHeaderByName("Content-Disposition", "attachment; filename=#arguments.attachment#") />
		</cfif>

		<cfsavecontent variable="output"><cfinclude template="#arguments.fileFullPath#" /></cfsavecontent>

		<cfreturn output />
	</cffunction>

	<cffunction name="serveStaticFile" access="private" returntype="void" output="false"
		hint="Serves a static file via cfcontent or mod x-sendfile.">
		<cfargument name="fileFullPath" type="string" required="true"
			hint="The full path to the file." />
		<cfargument name="expires" type="struct" required="true"
			hint="The expires struct." />
		<cfargument name="attachment" type="string" required="true"
			hint="The name of the file if an attachment. Zero-length string menas not to send as attachment." />

		<cfset var fullFilePath =  arguments.fileFullPath />
		<cfset var contentType = getContentTypeFromFilePath(arguments.fileFullPath) />
		<cfset var fileInfo = "" />
		<cfset var httpRequestHeaders = getHttpRequestData().headers />

		<!--- Read file info for content-length and last-modified headers --->
		<cftry>
			<cfset fileInfo = getFileInfo(fileFullPath) />

			<!--- Assert the requested file was found (only throw the relative path for security reasons) --->
			<cfif fileInfo.type NEQ "file">
				<cfthrow />
			</cfif>
			<cfcatch type="any">
				<cfthrow type="MachII.endpoints.file.notFound"
					message="Cannot fetch file information for the request file path because it cannot be located. Check for your file path."
					detail="File path: '#getFileFromPath(fileFullPath)#'." />
			</cfcatch>
		</cftry>

		<cfset addHTTPHeaderByName("Content-Length", fileInfo.size) />

		<!--- Set the expires header using either access or modified --->
		<cfif arguments.expires.type EQ "access">
			<cfset addHTTPHeaderByName("Expires", GetHttpTimeString(Now() + arguments.expires.amount)) />
		<cfelseif arguments.expires.type EQ "modified">
			<cfset addHTTPHeaderByName("Expires", GetHttpTimeString(fileInfo.lastModified + arguments.expires.amount)) />
		</cfif>

		<cfif Len(arguments.attachment)>
			<cfset addHTTPHeaderByName("Content-Disposition", "attachment; file='#arguments.attachment#'") />
		</cfif>

		<cfif getServiceEngineType() EQ "cfcontent">
			<!--- Return a 304 No Modified if the passed header and file modified timestamp are not the same --->
			<cfif StructKeyExists(httpRequestHeaders ,"If-Modified-Since") AND DateCompare(getUtils().createDatetimeFromHttpTimeString(httpRequestHeaders["If-Modified-Since"]), fileInfo.lastModified) NEQ 0>
				<cfcontent reset="true" />
				<cfset addHTTPHeaderByStatus(304) />
			<!--- Serve the file using cfcontent --->
			<cfelse>
				<cfset addHTTPHeaderByName("Last-Modified", GetHttpTimeString(fileInfo.lastModified)) />
				<cfcontent file="#fullFilePath#" type="#contentType#" />
			</cfif>
		<cfelse>
			<!--- x-sendfile correctly handles ETags and modified since headers itself --->
			<cfset addHTTPHeaderByName("X-Sendfile", arguments.fullFilePath) />
		</cfif>
	</cffunction>

	<!---
	PROTECTED FUNCTIONS - UTILS
	--->
	<cffunction name="getContentTypeFromFilePath" access="private" returntype="string" output="false"
		hint="Reuturns the MIME type from a file path.">
		<cfargument name="filePath" type="string" required="true"
			hint="The full path to the file." />

		<cfset var fileName = getFileFromPath(arguments.filePath) />
		<cfset var fileExtension = "." & ListLast(arguments.filePath, ".") />

		<!--- Get MIME type only if we have an extension --->
		<cfif ListLen(fileName, ".")>
			<cfreturn getUtils().getMimeTypeByFileExtension("." & ListLast(fileName, "."), variables.customMimeTypeMap) />
		<!--- If no file extension, then serve as plain text --->
		<cfelse>
			<cfreturn getUtils().getMimeTypeByFileExtension(".txt", variables.customMimeTypeMap) />
		</cfif>
	</cffunction>

	<cffunction name="parseExpiresLanguage" access="private" returntype="struct" output="false"
		hint="Parses expires language into an uniform structure with keys of 'type' and 'amount' (via createTimespan() BIF).">
		<cfargument name="inputString" type="string" required="true" />

		<cfset var amountRaw = "" />
		<cfset var result = StructNew() />

		<cfif REFindNoCase("^((access|modified) plus ([0-9]{1,}\,){3}[0-9]{1,})$", arguments.inputString)>

			<cfset amountRaw = ListToArray(ListGetAt(arguments.inputString, 3, " ")) />

			<cfset result.type = ListGetAt(arguments.inputString, 1, " ") />
			<cfset result.amount = CreateTimespan(amountRaw[1], amountRaw[2], amountRaw[3], amountRaw[4]) />
		<cfelseif arguments.inputString EQ "none">
			<cfset result.type = "none" />
			<cfset result.amount = 0 />
		<cfelse>
			<cfthrow type="MachII.endpoint.file.UnableToParseExpiresString"
				message="Unable to parse expires string of '#arguments.inputString#'." />
		</cfif>

		<cfreturn result />
	</cffunction>

	<cffunction name="fetchAssetTimestamp" access="private" returntype="numeric" output="false"
		hint="Fetches the asset timestamp (seconds from epoch) from the passed target asset path.">
		<cfargument name="filePath" type="string" required="true"
			hint="This is the file path." />

		<cfset var fullPath = ReplaceNoCase(ExpandPath(getBasePath()) & arguments.filePath, "//", "/", "all") />
		<cfset var fileInfo = "" />

		<cftry>
			<cfset fileInfo = getFileInfo(fullPath) />

			<!--- Assert the requested file was found (only throw the relative path for security reasons) --->
			<cfif fileInfo.type NEQ "file">
				<cfthrow />
			</cfif>

			<!--- Convert current time to UTC because epoch is essentially UTC --->
			<cfreturn DateDiff("s", variables.EPOCH_TIMESTAMP, DateConvert("local2Utc", fileInfo.lastModified)) />

			<!--- Log an exception if asset cannot be found and only soft fail --->
			<cfcatch type="any">
				<cfset getLog().warn("Cannot fetch a timestamp for an asset because it cannot be located. Check for your asset path. Resolved asset path: '#fullPath#'") />

				<cfreturn 0 />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="matchCfmFile" access="private" returntype="boolean" output="false"
		hint="Finds a match CFML file in the patterns and manages a cache.">
		<cfargument name="filePath" type="string" required="true"
			hint="This is the file path." />

		<cfset var i = 0 />
		<cfset var result = false />

		<!--- Check the cache first --->
		<cfif variables.cfmFileMatchCache.containsKey(arguments.filePath)>
			<cfreturn variables.cfmFileMatchCache.get(arguments.filePath) />
		</cfif>

		<!--- If not cache value, then search for match (the matcher can take an array of patterns)--->
		<cfif variables.matcher.match(variables.cfmSafePatterns, arguments.filePath)>
			<cfset result = true />
		</cfif>

		<!--- Set a cache value for the file path --->
		<cfset variables.cfmFileMatchCache.put(arguments.filePath, result) />

		<cfreturn result />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setBasePath" access="public" returntype="void" output="false">
		<cfargument name="basePath" type="string" required="true" />
		<cfset variables.basePath = arguments.basePath />
	</cffunction>
	<cffunction name="getBasePath" access="public" returntype="string" output="false">
		<cfreturn variables.basePath />
	</cffunction>

	<cffunction name="setUrlBase" access="public" returntype="void" output="false">
		<cfargument name="urlBase" type="string" required="true" />
		<cfset variables.urlBase = arguments.urlBase />
	</cffunction>
	<cffunction name="getUrlBase" access="public" returntype="string" output="false">
		<cfreturn variables.urlBase />
	</cffunction>

	<cffunction name="setServiceEngineType" access="public" returntype="void" output="false">
		<cfargument name="serviceEngineType" type="string" required="true" />
		<cfset variables.serviceEngineType = arguments.serviceEngineType />
	</cffunction>
	<cffunction name="getServiceEngineType" access="public" returntype="string" output="false">
		<cfreturn variables.serviceEngineType />
	</cffunction>

	<cffunction name="setExpiresDefault" access="private" returntype="void" output="false">
		<cfargument name="expiresDefaultAsString" type="string" required="true" />
		<cfset variables.expiresDefault = parseExpiresLanguage(arguments.expiresDefaultAsString) />
	</cffunction>
	<cffunction name="getExpiresDefault" access="public" returntype="struct" output="false">
		<cfreturn variables.expiresDefault />
	</cffunction>

	<cffunction name="setExpiresDefaultAsString" access="public" returntype="void" output="false">
		<cfargument name="expiresDefaultAsString" type="string" required="true" />
		<cfset variables.expiresDefaultAsString = arguments.expiresDefaultAsString />
		<cfset setExpiresDefault(variables.expiresDefaultAsString) />
	</cffunction>
	<cffunction name="getExpiresDefaultAsString" access="public" returntype="string" output="false">
		<cfreturn variables.expiresDefaultAsString />
	</cffunction>

	<cffunction name="setAttachmentDefault" access="private" returntype="void" output="false">
		<cfargument name="attachmentDefault" type="boolean" required="true" />
		<cfset variables.attachmentDefault = arguments.attachmentDefault />
	</cffunction>
	<cffunction name="getAttachmentDefault" access="public" returntype="boolean" output="false">
		<cfreturn variables.attachmentDefault />
	</cffunction>

	<cffunction name="setTimestampDefault" access="private" returntype="void" output="false">
		<cfargument name="timestampDefault" type="boolean" required="true" />
		<cfset variables.timestampDefault = arguments.timestampDefault />
	</cffunction>
	<cffunction name="getTimestampDefault" access="public" returntype="boolean" output="false">
		<cfreturn variables.timestampDefault />
	</cffunction>

</cfcomponent>