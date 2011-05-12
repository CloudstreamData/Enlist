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

$Id: $

Notes:
--->
<cfcomponent output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.chapterGateway = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ChapterService" output="false"
		hint="Initializes the service.">
		<cfreturn this />
	</cffunction>

	<cffunction name="getChapterGateway" access="public" returntype="enlist.model.chapter.ChapterGateway" output="false">
		<cfreturn variables.chapterGateway />
	</cffunction>
	<cffunction name="setChapterGateway" access="public" returntype="void" output="false">
		<cfargument name="chapterGateway" type="enlist.model.chapter.ChapterGateway" required="true" />
		<cfset variables.chapterGateway = arguments.chapterGateway />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getChapter" access="public" returntype="enlist.model.chapter.Chapter" output="false">
		<cfargument name="chapterID" type="string" required="false" default="">
		<cfreturn getChapterGateway().getChapter(arguments.chapterID) />
	</cffunction>

	<cffunction name="getChapters" access="public" returntype="array" output="false">
		<cfreturn getChapterGateway().getChapters() />
	</cffunction>

	<cffunction name="saveChapter" access="public" returntype="any" output="false">
		<cfargument name="chapter" type="enlist.model.chapter.Chapter" required="true">
		<cfset var errors = arguments.chapter.validate() />
		<cfif (structIsEmpty(errors))>
			<cfset getChapterGateway().saveChapter(arguments.chapter) />
		</cfif>
		<cfreturn errors />
	</cffunction>

</cfcomponent>