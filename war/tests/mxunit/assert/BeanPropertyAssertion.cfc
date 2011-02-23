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
<cfcomponent>

	<cffunction name="assertBeanProperty" returntype="boolean" access="public" output="false">
		<cfargument name="properties" type="string" required="true"/>
		<cfargument name="bean" type="any" required="true"/>

		<cfset var property = ""/>
		<cfset var value = ""/>

		<cfloop list="#arguments.properties#" index="property">
			<cftry>
				<cfinvoke component="#arguments.bean#" method="get#property#" returnVariable="value"/>
				<cfcatch>
					<cfreturn false/>
				</cfcatch>
			</cftry>
		</cfloop>
		<cfreturn true/>
	</cffunction>

</cfcomponent>