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


	<cffunction name="init" access="public" output="false" returntype="EmailService">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="buildI18NArgs" access="public" output="false" returntype="string">
		<cfargument name="user" required="true" type="any" hint="User object" />
		<cfargument name="activity" required="false" type="any" hint="Activity object" />

		<cfset var list = user.getFirstName() & ';' & user.getLastName() & ';' & user.getGoogleEmail() />

		<cfif structKeyexists(arguments,"activity") and isObject(arguments.activity)>
			<cfset list = list & ';' & activity.getName() & ";" & activity.getEvent().getName() & ";" & activity.getEvent().description()  & ";" & activity.getEvent().getstartDate()>
		</cfif>

		<cfreturn list/>
	</cffunction>

	<cffunction name="send" access="public" output="false" returntype="void">
		<cfargument name="to" 		required="true" type="string" hint="To email address" />
		<cfargument name="from" 	required="true" type="string" hint="from email address" />
		<cfargument name="subject" 	required="true" type="string" hint="subject of email" />
		<cfargument name="message" 	required="true" type="string" hint="Message of mail" />
		
		<cftry>
			 <cfmail to="#arguments.to#" from="#arguments.from#" subject="#arguments.subject#"> 
	                <cfmailpart type="text" wraptext="74"> 
						#stripHTML(buildmessage(arguments.message))#
				    </cfmailpart> 
				    <cfmailpart type="html">
						#buildmessage(arguments.message)#
				    </cfmailpart>
	        </cfmail>
		<cfcatch><cflog application="true" text="Attempt to send email failed: message #cfcatch.message#"></cfcatch>
		</cftry>

		<cfreturn />
	</cffunction>
	
	<cffunction name="buildMessage" access="public" output="false" returntype="string">
		<cfset var strHTML = "">
		<cfsavecontent variable="strHTML"><cfinclude template="/views/email/buildMessage.cfm"></cfsavecontent>
		<cfreturn strHTML/>
	</cffunction>
	
	<cffunction name="stripHTML" access="private" output="false" returntype="string">
		<cfargument name="str" type="string" required="true" hint="email message." />
		
		<cfscript>
		/**
		* Function to strip HTML tags, with options to preserve certain tags.
		* v2 by Ray Camden, fix to closing tag
		* 
		* @param str      String to manipulate. (Required)
		* @param action      Strip or preserve. Default is strip. (Optional)
		* @param tagList      Tags to strip or perserve. (Optional)
		* @return Returns a string. 
		* @author Rick Root (rick@webworksllc.com) 
		* @version 2, July 2, 2008 
		*/
		
		    var i = 1;
		    var action = 'strip';
		    var tagList = '';
		    var tag = '';
		    
		    if (ArrayLen(arguments) gt 1 and lcase(arguments[2]) eq 'preserve') {
		        action = 'preserve';
		    }
		    if (ArrayLen(arguments) gt 2) tagList = arguments[3];
		
		    if (trim(lcase(action)) eq "preserve") {
		        // strip only those tags in the tagList argument
		        for (i=1;i lte listlen(tagList); i = i + 1) {
		            tag = listGetAt(tagList,i);
		            str = REReplaceNoCase(str,"</?#tag#.*?>","","ALL");
		        }
		    } else {
		        // strip all, except those in the tagList argument
		        // if there are exclusions, mark them with NOSTRIP
		        if (tagList neq "") {
		            for (i=1;i lte listlen(tagList); i = i + 1) {
		                tag = listGetAt(tagList,i);
		                str = REReplaceNoCase(str,"<(/?#tag#.*?)>","___TEMP___NOSTRIP___\1___TEMP___ENDNOSTRIP___","ALL");
		            }
		        }
		        // strip all remaining tsgs. This does NOT strip comments
		        str = reReplaceNoCase(str,"</{0,1}[A-Z].*?>","","ALL");
		        // convert unstripped back to normal
		        str = replace(str,"___TEMP___NOSTRIP___","<","ALL");
		        str = replace(str,"___TEMP___ENDNOSTRIP___",">","ALL");
		    }
		    
		    return str;    
		
		</cfscript>

	</cffunction>
</cfcomponent>