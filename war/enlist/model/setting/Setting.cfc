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
	displayname="Setting"
	output="false"
	hint="A bean which models the Setting for the application.">


	<!---
	PROPERTIES
	--->
	<cfset variables.id = "" />
	<cfset variables.pointName = "" />
	<cfset variables.defaultPointValue = "" />
	<cfset variables.orgName = "" />
	<cfset variables.orgDesc = "" />
	<cfset variables.orgAddress = "" />
	<cfset variables.sendEmail = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Setting" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="pointName" type="string" required="false" default="Point" />
		<cfargument name="defaultPointValue" default="1" type="numeric" required="false">
		<cfargument name="orgName" type="string" required="false" default="Your Organization Name" />
		<cfargument name="orgDesc" type="string" required="false" default="Some text about your organization" />
		<cfargument name="orgAddress" type="string" required="false" default="Your organization address" />
		<cfargument name="sendEmail" type="string" required="false" default="true" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="validate" access="public" returntype="struct" output="false">
		<cfscript>
			var errors = StructNew();

			if (Len(Trim(getPointName())) eq 0) {
				errors.pointName = "You must enter a name for your points";
			}

			if (Len(Trim(getDefaultPointValue())) eq 0 or not isNumeric(getDefaultPointValue())) {
				errors.defaultPointValue = "Enter your default points value";
			}

			if (Len(Trim(getOrgName())) eq 0) {
				errors.orgName = "You must enter an Organization name";
			}

			if (Trim(getOrgName()) eq "Your Organization Name") {
				errors.orgName = "Please enter your organizations name";
			}

			if (Len(Trim(getOrgDesc())) eq 0) {
				errors.orgDesc = "You must enter an Organization description";
			}

			if (Trim(getOrgDesc()) eq "Some text about your organization") {
				errors.orgDesc = "Please enter your organizations description";
			}

			if (Len(Trim(getOrgDesc())) eq 0) {
				errors.orgAddress = "You must enter an Organization address";
			}

			if (Trim(getOrgDesc()) eq "Your organization address") {
				errors.orgAddress = "Please enter your organizations address";
			}

			return errors;
		</cfscript>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true"/>
		<cfset setId(arguments.data.id) />
		<cfset setPointName(arguments.data.pointName) />
		<cfset setDefaultPointValue(arguments.data.defaultPointValue) />
		<cfset setOrgName(arguments.data.orgName) />
		<cfset setOrgDesc(arguments.data.orgDesc) />
		<cfset setOrgAddress(arguments.data.orgAddress) />
		<cfset setSendEmail(arguments.data.sendEmail) />
	</cffunction>
	<cffunction name="getInstanceMemento" access="public"returntype="struct" output="false" >
		<cfreturn variables />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = trim(arguments.id) />
	</cffunction>
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.id />
	</cffunction>

	<cffunction name="setPointName" access="public" returntype="void" output="false">
		<cfargument name="pointName" type="string" required="true" />
		<cfset variables.pointName = trim(arguments.pointName) />
	</cffunction>
	<cffunction name="getPointName" access="public" returntype="string" output="false">
		<cfreturn variables.pointName />
	</cffunction>

	<cffunction name="setDefaultPointValue" access="public" returntype="void" output="false">
		<cfargument name="defaultPointValue" type="string" required="true" />
		<cfset variables.defaultPointValue = trim(arguments.defaultPointValue) />
	</cffunction>
	<cffunction name="getDefaultPointValue" access="public" returntype="string" output="false">
		<cfreturn variables.defaultPointValue />
	</cffunction>

	<cffunction name="setOrgName" access="public" returntype="void" output="false">
		<cfargument name="orgName" type="string" required="true" />
		<cfset variables.orgName = trim(arguments.orgName) />
	</cffunction>
	<cffunction name="getOrgName" access="public" returntype="string" output="false">
		<cfreturn variables.orgName />
	</cffunction>

	<cffunction name="setOrgDesc" access="public" returntype="void" output="false">
		<cfargument name="orgDesc" type="string" required="true" />
		<cfset variables.orgDesc = trim(arguments.orgDesc) />
	</cffunction>
	<cffunction name="getOrgDesc" access="public" returntype="string" output="false">
		<cfreturn variables.orgDesc />
	</cffunction>

	<cffunction name="setOrgAddress" access="public" returntype="void" output="false">
		<cfargument name="orgAddress" type="string" required="true" />
		<cfset variables.orgAddress = trim(arguments.orgAddress) />
	</cffunction>
	<cffunction name="getOrgAddress" access="public" returntype="string" output="false">
		<cfreturn variables.orgAddress />
	</cffunction>

	<cffunction name="setSendEmail" access="public" returntype="void" output="false">
		<cfargument name="sendEmail" type="string" required="true" />
		<cfset variables.sendEmail = trim(arguments.sendEmail) />
	</cffunction>
	<cffunction name="getSendEmail" access="public" returntype="string" output="false">
		<cfreturn variables.sendEmail />
	</cffunction>

</cfcomponent>