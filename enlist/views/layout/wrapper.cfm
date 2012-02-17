<cfsilent>
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
	
	==========================================================
		Created by Devit Schizoper                          
		Created HomePages http://LoadFoo.starzonewebhost.com
		Created Day 01.12.2006                              
	==========================================================

	--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
</cfsilent>
<cfoutput>
<view:doctype />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<view:style href="style.css" media="screen"/>
	<view:style href="south-street/jquery-ui-1.8.9.custom.css" media="screen"/>
	<view:link type="icon" href="/favicon.ico" />
	<view:asset package="jquery" outputType="inline" />
</head>

<body>
<div id="wrap">
	<div id="top">
		#event.getArg("layout.header")#
	</div>

	<div id="content">
		<div id="left">
			#event.getArg("layout.content")#
		</div>
		
		<div id="right">
			#event.getArg("layout.nav")#
		</div>
		
		<div id="clear"></div>
	</div>
	
	<div id="footer">
		#event.getArg("layout.footer")#
	</div>
</div>
</body>
</html>
</cfoutput>