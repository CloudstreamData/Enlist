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
<cfcomponent extends="BaseSecurityObject" output="false">

	<cfset variables.action = ""/>
	<cfset variables.roleRequired = ""/>
	<cfset variables.permissionRequired = ""/>
	<cfset variables.eventName = ""/>
	<cfset variables.eventPattern = ""/>
	<cfset variables.events = arrayNew(1)/>
	<cfset variables.environmentNames = arrayNew(1)/>
	<cfset variables.environmentGroups = arrayNew(1)/>

	<cffunction name="init" returntype="EventSecurityRule" access="public" output="false">
		<cfargument name="action" type="string" required="false"/>
		<cfargument name="roleRequired" type="string" required="false"/>
		<cfargument name="permissionRequired" type="string" required="false"/>
		<cfargument name="eventName" type="string" required="false"/>
		<cfargument name="eventPattern" type="string" required="false"/>
		<cfargument name="events" type="any" required="false"/>
		<cfargument name="environment" type="string" required="false"/>

		<cfset super.init()/>
		<cfif structKeyExists(arguments, "action")>
			<cfset setAction(arguments.action)/>
		</cfif>
		<cfif structKeyExists(arguments, "roleRequired")>
			<cfset setRoleRequired(arguments.roleRequired)/>
		</cfif>
		<cfif structKeyExists(arguments, "permissionRequired")>
			<cfset setPermissionRequired(arguments.permissionRequired)/>
		</cfif>
		<cfif structKeyExists(arguments, "eventName")>
			<cfset setEventName(arguments.eventName)/>
		</cfif>
		<cfif structKeyExists(arguments, "eventPattern")>
			<cfset setEventPattern(arguments.eventPattern)/>
		</cfif>
		<cfif structKeyExists(arguments, "events")>
			<cfif isArray(arguments.events)>
				<cfset setEvents(arguments.events)/>
			<cfelse>
				<cfset setEvents(listToArray(arguments.events))/>
			</cfif>
		</cfif>
		<cfif structKeyExists(arguments, "environment")>
			<cfset setEnvironment(arguments.environment)/>
		</cfif>

		<cfreturn this/>
	</cffunction>

	<cffunction name="getSummary" returntype="string" access="public" output="false">
		<cfset var summary = ""/>
		<cfset var groups = getEnvironmentGroups()/>
		<cfset var names = getEnvironmentNames()/>

		<cfif hasAction()>
			<cfset summary = listAppend(summary, "action='#getAction()#'", ";")/>
		</cfif>
		<cfif hasRoleRequired()>
			<cfset summary = listAppend(summary, "roleRequired='#getRoleRequired()#'", ";")/>
		</cfif>
		<cfif hasPermissionRequired()>
			<cfset summary = listAppend(summary, "permissionRequired='#getPermissionRequired()#'", ";")/>
		</cfif>
		<cfif hasEventName()>
			<cfset summary = listAppend(summary, "eventName='#getEventName()#'", ";")/>
		</cfif>
		<cfif hasEventPattern()>
			<cfset summary = listAppend(summary, "eventPattern='#getEventPattern()#'", ";")/>
		</cfif>
		<cfif hasEvents()>
			<cfset summary = listAppend(summary, "events='#arrayToList(getEvents())#'", ";")/>
		</cfif>
		<cfif arrayLen(groups) gt 0>
			<cfset summary = listAppend(summary, "environmentGroups='#arrayToList(groups)#'", ";")/>
		</cfif>
		<cfif arrayLen(names) gt 0>
			<cfset summary = listAppend(summary, "environmentNames='#arrayToList(names)#'", ";")/>
		</cfif>
		<cfreturn summary/>
	</cffunction>

	<cffunction name="isActionMatch" returntype="boolean" access="public" output="false">
		<cfargument name="action" type="string" required="true"/>

		<cfif arguments.action eq "">
			<cfthrow type="SecurityRuleException" message="The action argument must be defined for an action match."/>
		</cfif>

		<cfif hasAction()>
			<cfif compareNoCase(getAction(), arguments.action) eq 0>
				<cfreturn true/>
			</cfif>
		</cfif>
		<cfreturn false/>
	</cffunction>

	<cffunction name="isEventMatch" returntype="boolean" access="public" output="false">
		<cfargument name="eventName" type="string" required="false" default=""/>

		<cfset var isMatch = false/>

		<cfif hasEventName() and compareNoCase(getEventName(), arguments.eventName) eq 0>
			<cfset isMatch = true/>
		<cfelseif hasEventPattern() and reFindNoCase(getEventPattern(), arguments.eventName) gt 0>
			<cfset isMatch = true/>
		<cfelseif hasEvents()>
			<cfif arrayFindNoCase(getEvents(), arguments.eventName) gt 0>
				<cfset isMatch = true/>
			</cfif>
		</cfif>
		<cfreturn isMatch/>
	</cffunction>

	<cffunction name="hasEventName" returntype="boolean" access="public" output="false">
		<cfreturn len(variables.eventName) gt 0/>
	</cffunction>
	<cffunction name="getEventName" returntype="string" access="private" output="false">
		<cfreturn variables.eventName/>
	</cffunction>
	<cffunction name="setEventName" returntype="void" access="private" output="false">
		<cfargument name="eventName" type="string" required="true"/>
		<cfset variables.eventName = arguments.eventName/>
	</cffunction>

	<cffunction name="hasEventPattern" returntype="boolean" access="public" output="false">
		<cfreturn len(variables.eventPattern) gt 0/>
	</cffunction>
	<cffunction name="getEventPattern" returntype="string" access="private" output="false">
		<cfreturn variables.eventPattern/>
	</cffunction>
	<cffunction name="setEventPattern" returntype="void" access="private" output="false">
		<cfargument name="eventPattern" type="string" required="true"/>
		<cfset variables.eventPattern = arguments.eventPattern/>
	</cffunction>

	<cffunction name="hasEvents" returntype="boolean" access="public" output="false">
		<cfreturn arrayLen(variables.events) gt 0/>
	</cffunction>
	<cffunction name="getEvents" returntype="array" access="private" output="false">
		<cfreturn variables.events/>
	</cffunction>
	<cffunction name="setEvents" returntype="void" access="private" output="false">
		<cfargument name="events" type="array" required="true"/>
		<cfset variables.events = arguments.events/>
	</cffunction>

	<cffunction name="isEnvironmentMatch" returntype="boolean" access="public" output="false">
		<cfargument name="environment" type="struct" required="false"/>
		<cfargument name="name" type="string" required="false" default=""/>
		<cfargument name="group" type="string" required="false" default=""/>

		<cfset var _name = ""/>
		<cfset var _group = ""/>
		<cfset var log = getLog()/>

		<cfif structKeyExists(arguments, "environment")>
			<cfset _name = arguments.environment.name/>
			<cfset _group = arguments.environment.group/>
		<cfelse>
			<cfset _name = arguments.name/>
			<cfset _group = arguments.group/>
		</cfif>

		<cfif _name eq "" and _group eq "">
			<cfthrow type="InvalidArgumentException" message="The environment name or group must be defined for an environment match."/>
		</cfif>

		<cfif not hasEnvironment()>
			<cfif log.isInfoEnabled()>
				<cfset log.info("No environment defined; returning isEnvironmentMatch() true as rule applies to any environment")/>
			</cfif>
			<cfreturn true/>
		</cfif>

		<cfif len(_name) gt 0>
			<cfif arrayFindNoCase(variables.environmentNames, _name) gt 0>
				<cfif log.isInfoEnabled()>
					<cfset log.info("Rule matched environment name '#_name#'")/>
				</cfif>
				<cfreturn true/>
			</cfif>
		</cfif>

		<cfif len(_group) gt 0>
			<cfif arrayFindNoCase(variables.environmentGroups, _group) gt 0>
				<cfif log.isInfoEnabled()>
					<cfset log.info("Rule matched environment group '#_group#'")/>
				</cfif>
				<cfreturn true/>
			</cfif>
		</cfif>

		<cfif log.isInfoEnabled()>
			<cfset log.info("Rule did not match defined environment.")/>
		</cfif>
		<cfreturn false/>
	</cffunction>


	<cffunction name="hasEnvironment" returntype="boolean" access="public" output="false">
		<cfreturn not (arrayLen(variables.environmentNames) eq 0 and arrayLen(variables.environmentGroups) eq 0)/>
	</cffunction>
	<cffunction name="getEnvironmentNames" returntype="array" access="private" output="false">
		<cfreturn variables.environmentNames/>
	</cffunction>
	<cffunction name="getEnvironmentGroups" returntype="array" access="private" output="false">
		<cfreturn variables.environmentGroups/>
	</cffunction>
	<cffunction name="setEnvironment" returntype="void" access="private" output="false">
		<cfargument name="environment" type="string" required="true"/>

		<cfset var atom = ""/>

		<cfloop list="#arguments.environment#" index="atom">
			<cfset atom = trim(atom)/>
			<cfif reFindNoCase("^group:", atom) gt 0>
				<cfset arrayAppend(variables.environmentGroups, reReplaceNoCase(atom, "^group:", ""))/>
			<cfelse>
				<cfset arrayAppend(variables.environmentNames, atom)/>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="hasAction" returntype="boolean" access="public" output="false">
		<cfreturn len(variables.action) gt 0/>
	</cffunction>
	<cffunction name="getAction" returntype="string" access="public" output="false">
		<cfreturn variables.action/>
	</cffunction>
	<cffunction name="setAction" returntype="void" access="private" output="false">
		<cfargument name="action" type="string" required="true"/>
		<cfset variables.action = arguments.action/>
	</cffunction>

	<cffunction name="hasRoleRequired" returntype="boolean" access="public" output="false">
		<cfreturn len(variables.roleRequired) gt 0/>
	</cffunction>
	<cffunction name="getRoleRequired" returntype="string" access="public" output="false">
		<cfreturn variables.roleRequired/>
	</cffunction>
	<cffunction name="setRoleRequired" returntype="void" access="private" output="false">
		<cfargument name="roleRequired" type="string" required="true"/>
		<cfset variables.roleRequired = arguments.roleRequired/>
	</cffunction>

	<cffunction name="hasPermissionRequired" returntype="boolean" access="public" output="false">
		<cfreturn len(variables.permissionRequired) gt 0/>
	</cffunction>
	<cffunction name="getPermissionRequired" returntype="string" access="public" output="false">
		<cfreturn variables.permissionRequired/>
	</cffunction>
	<cffunction name="setPermissionRequired" returntype="void" access="private" output="false">
		<cfargument name="permissionRequired" type="string" required="true"/>
		<cfset variables.permissionRequired = arguments.permissionRequired/>
	</cffunction>


	<cffunction name="arrayFindNoCase" returntype="numeric" access="private" output="false">
		<cfargument name="array" type="array" required="true"/>
		<cfargument name="value" type="string" required="true"/>

		<cfset var i = 0/>

		<cfloop from="1" to="#arrayLen(arguments.array)#" index="i">
			<cfif compareNoCase(arguments.array[i], arguments.value) eq 0>
				<cfreturn i/>
			</cfif>
		</cfloop>
		<cfreturn 0/>
	</cffunction>

</cfcomponent>