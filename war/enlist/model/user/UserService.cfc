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
	displayname="UserService"
	extends="enlist.model.BaseService"
	output="false">

	<!---
	PROPERTIES
	--->
	<cfset variables.googleUserService = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="UserService" output="false">

		<cfset var googleUserFactory = CreateObject("java", "com.google.appengine.api.users.UserServiceFactory") />

		<cfset super.init( argumentCollection = arguments ) />

		<cfset variables.googleUserService = googleUserFactory.getUserService() />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getUser" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn getGateway().read( arguments.id ) />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="array" output="false">
		<cfreturn getGateway().list() />
	</cffunction>

	<cffunction name="getUsersBySearch" access="public" returntype="array" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />
		<cfargument name="role" type="string" required="false" default="" />
		<cfargument name="chapterId" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="googleEmail" type="string" required="false" default="" />
		<cfargument name="altEmail" type="string" required="false" default="" />
		<cfargument name="phone" type="string" required="false" default="" />
		<cfargument name="address1" type="string" required="false" default="" />
		<cfargument name="address2" type="string" required="false" default="" />
		<cfargument name="city" type="string" required="false" default="" />
		<cfargument name="state" type="string" required="false" default="" />
		<cfargument name="zip" type="string" required="false" default="" />
		<cfreturn getGateway().listByPropertyMap( arguments ) />
	</cffunction>

	<cffunction name="getUserByGoogleEmail" access="public" returntype="any" output="false"
		hint="Gets an User from the datastore by Google Email.">
		<cfargument name="googleEmail" type="string" required="true" />
		<cfreturn getGateway().readByProperty( "googleEmail", arguments.googleEmail ) />
	</cffunction>

	<cffunction name="logoutUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">
		<cfset getSessionFacade().deleteProperty("authentication") />
	</cffunction>

	<cffunction name="registerUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">
		<cfset saveUser( arguments.user )>
		<cfset getSessionFacade().getProperty("authentication").setUser( arguments.user ) />
	</cffunction>

	<cffunction name="saveUser" access="public" returntype="any" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">

		<cfif not len( arguments.user.getGoogleEmail() )>
			<cfif not variables.googleUserService.isUserLoggedIn()>
				<cfthrow message="Unable to save user without googleEmail." />
			</cfif>
			<cfset arguments.user.setGoogleEmail( variables.googleUserService.getCurrentUser().getEmail() ) />
		</cfif>

		<cfset var errors = arguments.user.validate() />

		<cfif (structIsEmpty(errors))>
			<cfset getGateway().save( arguments.user ) />
			<cfset getSessionFacade().getProperty("authentication").setUser( arguments.user ) />
		</cfif>

		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="getGoogleUserService" access="public" returntype="any" output="false">
		<cfreturn variables.googleUserService />
	</cffunction>
	<cffunction name="setGoogleUserService" access="public" returntype="void" output="false">
		<cfargument name="googleUserService" type="any" required="true" />
		<cfset variables.googleUserService = arguments.googleUserService />
	</cffunction>

</cfcomponent>