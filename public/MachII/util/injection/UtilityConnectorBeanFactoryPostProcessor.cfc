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
$Id: UtilityConnectorBeanFactoryPostProcessor.cfc 2853 2011-09-09 04:46:04Z peterjfarrell $

Created version: 1.9.0
Updated version: 1.9.0

Notes:
--->
<cfcomponent
	displayname="UtilityConnectorBeanFactoryPostProcessor"
	output="false"
	extends="coldspring.beans.factory.config.BeanFactoryPostProcessor"
	hint="Used to wire in the correct AppManager into any UtilityConnector definitions">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="UtilityConnectorBeanFactoryPostProcessor" output="false"
		hint="Initializes the post processor.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="postProcessBeanFactory" access="public" returntype="void" output="false"
		hint="Configures utility connectors.">
		<cfargument name="beanFactory" type="coldspring.beans.BeanFactory" required="true"/>

		<cfset var utilityConnectorBeanName = arguments.beanFactory.findBeanNameByType("MachII.util.UtilityConnector") />
		<cfset var utilityConnector = "" />
		<cfset var defaultProperties = arguments.beanFactory.getDefaultProperties() />
		<cfset var appManager = defaultProperties["_MachIIAppManager"]>

		<cfif Len(utilityConnectorBeanName)>
			<cfset utilityConnector = arguments.beanFactory.getBean(utilityConnectorBeanName) />
			<cfset utilityConnector.setAppManager(appManager) />
		</cfif>
	</cffunction>

</cfcomponent>