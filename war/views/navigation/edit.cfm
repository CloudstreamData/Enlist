<cfimport prefix="form" taglib="/MachII/customtags/form">
<cfset >
<cfoutput>
<cfif event.getArg("message") neq "">
	<p class="alert">#event.getArg("message")#</p>	
</cfif>
</cfoutput>

<cfoutput>
<form:form actionEvent="navigation.save" bind="event">
	<table>
		<tr>
			<th>Name:</th>
			<td><form:input path="name" size="40" maxlength="200" value="#event.getArg( "navigation" ).getName()#"/></td>
		</tr>
		<tr>
			<th>Location:</th>
			<td><form:input path="eventName" size="40" maxlength="200" value="#event.getArg( "navigation" ).getEventName()#"/></td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" value="#event.getArg( "navigation" ).getID()#" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="Save Navigation" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>