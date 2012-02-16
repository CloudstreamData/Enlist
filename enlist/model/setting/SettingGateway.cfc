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
<cfcomponent
	displayname="SettingGateway"
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.dsn = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="SettingGateway" output="false"
		hint="Initializes the gateway.">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getSetting" access="public" returntype="any" output="false">
		<cfargument name="id" type="numeric" required="true" />
		<cfset var setting = 0 />
		<cfif arguments.id neq 0>
			<cfset setting = read( arguments.id ) />
		<cfelse>
			<cfset setting = createObject("component", "enlist.model.setting.Setting").init() />
		</cfif>
		<cfreturn setting />
	</cffunction>

	<cffunction name="getSettings" access="public" returntype="query" output="false">
		<cfargument name="settingID" type="string" required="false" default="">
		<cfset var qSettings = 0>
		<cfquery name="qSettings" datasource="#variables.dsn#">
		SELECT 	id, defaultpointvalue, orgname, orgdesc, orgaddress, sendemail
		FROM 	setting
		WHERE 	(1=1)
			<cfif arguments.settingID neq "0">
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.settingID#"
							null="#yesnoformat(len(arguments.settingID) eq 0)#" />
			</cfif>
		</cfquery>
		<cfreturn qSettings />
	</cffunction>

	<cffunction name="saveSetting" access="public" returntype="void" output="false">
		<cfargument name="setting" type="enlist.model.setting.Setting" required="true">
		<cfif arguments.setting.getID() neq 0>
			<cfset update(arguments.setting)>
		<cfelse>
			<cfset create(arguments.setting)>
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="setting" type="enlist.model.setting.Setting" required="yes">
		<cfset var data = setting.getInstanceMemento()>
		<cfset var newsetting = 0>
		<cftransaction>
		<cfquery name="newsetting" datasource="#variables.dsn#">
		INSERT INTO setting (defaultpointvalue, orgname, orgdesc, orgaddress, sendemail)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#data.defaultpointvalue#"
				null="#yesnoformat(len(data.defaultpointvalue) eq 0)#" maxlength="11">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.orgname#"
				null="#yesnoformat(len(data.orgname) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#data.orgdesc#"
				null="#yesnoformat(len(data.orgdesc) eq 0)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.orgaddress#"
				null="#yesnoformat(len(data.orgaddress) eq 0)#" maxlength="100">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.sendemail#"
				null="#yesnoformat(len(data.sendemail) eq 0)#" maxlength="100">
		)
		</cfquery>
		<cfquery name="qMaxID" datasource="#variables.dsn#">
		SELECT LAST_INSERT_ID() as maxID
		</cfquery>
		</cftransaction>
		<cfset setting.setId(qMaxID.maxID)>

	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="setting" type="enlist.model.setting.Setting" required="yes">
		<cfset var data = setting.getInstanceMemento()>
		<cfset var updatesetting = 0>
		<cfquery name="updatesetting" datasource="#variables.dsn#">
		UPDATE setting
		SET 
			defaultpointvalue = 
				<cfqueryparam cfsqltype="cf_sql_integer" value="#data.defaultpointvalue#"
					null="#yesnoformat(len(data.defaultpointvalue) eq 0)#" maxlength="11">,
			orgname = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.orgname#"
					null="#yesnoformat(len(data.orgname) eq 0)#" maxlength="100">,
			orgdesc = 
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#data.orgdesc#"
					null="#yesnoformat(len(data.orgdesc) eq 0)#">,
			orgaddress = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.orgaddress#"
					null="#yesnoformat(len(data.orgaddress) eq 0)#" maxlength="100">,
			sendemail = 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.sendemail#"
					null="#yesnoformat(len(data.sendemail) eq 0)#" maxlength="100">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="private" returntype="enlist.model.setting.Setting" output="false">
		<cfargument name="settingID" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var setting = 0>
		<cfset var readsetting = 0>
		<cfquery name="readsetting" datasource="#variables.dsn#">
		SELECT id, defaultpointvalue, orgname, orgdesc, orgaddress, sendemail
		FROM setting
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#settingID#">
		</cfquery>
		<cfloop list="#readsetting.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readsetting.#field#')>
		</cfloop>
		<cfset setting = createObject("component", "enlist.model.setting.Setting").init(argumentcollection=data)>
		<cfreturn setting>
	</cffunction>

</cfcomponent>