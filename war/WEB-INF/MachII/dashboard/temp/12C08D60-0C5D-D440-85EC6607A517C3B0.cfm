<cfsavecontent variable="variables.result"><cfoutput><cffunction name="test">
  <cfargument name="endpointName" type="string" required="true"/>
  <cfdump var="#arguments#"/>
  <cfabort>
</cffunction>

    <cfset test(endpointname:"temp", file:"a") />


</cfoutput></cfsavecontent>
