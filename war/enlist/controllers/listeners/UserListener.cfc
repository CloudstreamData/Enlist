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
	displayname="UserListener" 
	extends="MachII.framework.Listener" 
	output="false" 
	depends="userService">
	
	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="saveUser" access="public" returntype="void" output="false" 
		hint="Processes the user forms (registration, admin new/edit user) and saves the user">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var user = arguments.event.getArg("user");
			var existingUser = getUserService().getUserByGoogleEmail(user.getGoogleEmail());
			var errors = StructNew();
			
			// set a default message if necessary since this is hit a couple of different ways
			if (not arguments.event.isArgDefined("message")) {
				arguments.event.setArg("message", "User saved");
			}
			
			// make sure the user isn't already registered
			if (existingUser.getID() neq "") {
				errors.alreadyRegistered = "A user is already registered with this application using this email address.";
			} else {
				// validate the rest of the user input
				errors = user.validate();
			}
			
			if (not StructIsEmpty(errors)) {
				exitEvent = "register";
				arguments.event.setArg("message", "Please correct the following errors:");
				arguments.event.setArg("errors", errors);
				redirectEvent("fail", "", true);
			} else {
				try {
					getUserService().saveUser(user);
				} catch (Any e) {
					arguments.event.setArg("message", "Saving the user data failed. " & e.message);
					redirectEvent("fail", "", true);
				}
				
				arguments.event.removeArg("user");
				redirectEvent("pass", "", true);
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>