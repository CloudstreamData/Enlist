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

$Id$

Notes:
--->
<cfcomponent output="false">

	<cffunction name="getChapter" access="public" returntype="enlist.model.chapter.Chapter" output="false">
		<cfargument name="chapterID" type="numeric" required="false" default="0">

		<cfset var chapter = 0 />
		<cfset var chapterQry = 0 />
		<cfset var data = structNew() />

		<cfif arguments.chapterID eq 0>
			<cfset chapter = createObject("component", "enlist.model.chapter.Chapter").init() />
		<cfelse>
			<cfquery name="chapterQry">
			select 	id, name, location, statusCode
			from	chapter
			where 	id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.chapterID#" />
			</cfquery>
			<cfloop list="#chapterQry.columnList#" index="field">
				<cfset 'data.#field#' = evaluate('chapterQry.#field#')>
			</cfloop>
			<cfset chapter = createObject("component", "enlist.model.chapter.Chapter").init(argumentcollection=data) />
		</cfif>

		<cfreturn chapter />
	</cffunction>

	<cffunction name="getChapters" access="public" returntype="query" output="false">
		<cfset var chapters = 0>
		<cfquery name="chapters">
		select 	id, name, location, statusCode
		from	chapter
		order by name
		</cfquery>
		<cfreturn chapters />
	</cffunction>

	<cffunction name="saveChapter" access="public" returntype="void" output="false">
		<cfargument name="chapter" type="enlist.model.chapter.Chapter" required="true">
		<cfif arguments.chapter.getID() neq 0>
			<cfset update(arguments.chapter)>
		<cfelse>
			<cfset create(arguments.chapter)>
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="chapter" type="enlist.model.chapter.chapter" required="yes">
		<cfset var data = chapter.getInstanceMemento()>
		<cfset var newchapter = 0>
		<cftransaction>
		<cfquery name="newchapter">
		INSERT INTO chapter (name, location, statuscode)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
				null="#yesnoformat(len(data.name) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
				null="#yesnoformat(len(data.location) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.statuscode#"
				null="#yesnoformat(len(data.statuscode) eq 0)#" maxlength="50">
		)
		</cfquery>
		<cfquery name="qMaxID">
		SELECT LAST_INSERT_ID() as maxID
		</cfquery>
		</cftransaction>
		<cfset chapter.setId(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="chapter" type="enlist.model.chapter.chapter" required="yes">
		<cfset var data = chapter.getInstanceMemento()>
		<cfset var updatechapter = 0>
		<cfquery name="updatechapter">
		UPDATE chapter
		SET 
			name = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
					null="#yesnoformat(len(data.name) eq 0)#" maxlength="100">,
			location = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
					null="#yesnoformat(len(data.location) eq 0)#" maxlength="100">,
			statuscode = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.statuscode#"
					null="#yesnoformat(len(data.statuscode) eq 0)#" maxlength="50">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>

</cfcomponent>