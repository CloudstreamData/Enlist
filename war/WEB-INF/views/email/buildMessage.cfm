<cfimport prefix="view" taglib="/MachII/customtags/view" />
<cfoutput>
<!--- TODO: waiting on a fix in gae open bd so that globalization can be javacast string[] --->
<html>
	<head>
		<!--- <title><view:message key="#request.event.getArg('email.title')#" /></title> --->
	</head>
	<body>
		<!--- <view:message key="#request.event.getArg('email.message')#" arguments="#request.event.getArg('args')#" argumentSeparator=";" /> --->
	</body>
</html>
</cfoutput>