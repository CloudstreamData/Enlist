<cfif thisTag.ExecutionMode IS "start">
	<cfparam name="attributes.errors" type="struct" default="#structNew()#" />
	<cfif (not StructIsEmpty(attributes.errors))>
		<cfloop collection="#attributes.errors#" item="error">
			<p class="alert">
				<cfoutput>#attributes.errors[error]#</cfoutput>
			</p>
		</cfloop>
	</cfif>
</cfif>