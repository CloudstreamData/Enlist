<cfsavecontent variable="variables.result"><cfoutput><cffunction name="test">
  <cfdump var="#arguments#"/>
  <cfabort>
</cffunction>

<cfset test("temp", "a", "b", "c") />


</cfoutput></cfsavecontent>
