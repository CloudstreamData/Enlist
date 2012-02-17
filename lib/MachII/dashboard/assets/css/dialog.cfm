<cfoutput>/*
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
$Id: basic.cfm 2325 2010-08-21 22:39:20Z peterjfarrell $

Created version: 1.0.0
Updated version: 1.0.0
*/

##modalDlgOverlay
	{
}
	
.DlgContainer
{
	font-family:			Tahoma,Verdana,Arial,Helvetica,"Bitstream Vera Sans",sans-serif;
	padding:				0.5em;
	-moz-border-radius:		10px;
	-webkit-border-radius:	10px;
}
.DlgFrame
{
	-moz-border-radius:		5px;
	-webkit-border-radius:	5px;
}

.DlgHeader
{
	padding: .5em .25em .5em .5em;
	font-weight:	bold;
	-moz-border-radius-topleft:		5px;
	-moz-border-radius-topright:	5px;
	-webkit-border-top-left-radius:	5px;
	-webkit-border-top-right-radius: 5px;
	color: ##CC0000;
}

.DlgHeader>.DlgClosebox
{
	cursor:		pointer;
	color:		##666;
}
.DlgHeader>.DlgClosebox:hover
{	color:		black;
}

.DlgHeader>.DlgTitle
{	font-weight:	bold;
	padding:	5px 2em 5px 5px;
	border:	green dotted 1px;
}

.DlgButtonArea
{
padding-top: 1em;
padding-bottom: 1em;
}</cfoutput>