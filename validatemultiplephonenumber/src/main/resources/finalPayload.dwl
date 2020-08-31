%dw 2.0
output application/json

---
{
	telephones: payload.ScrubbedResults map ( scrubbedResult , indexOfScrubbedResult ) -> {
		
		phoneNumber: scrubbedResult.PhoneNumber,
		isStateDNC: if(scrubbedResult.Filters.Flag == "SNC") true else false as Boolean,
		isVOIP:if (scrubbedResult.Filters.Flag == "VOP") true else false,
		isFarmersDNC: if (scrubbedResult.Filters.Flag == "MST") true else false,
		isNationalDNC:if(scrubbedResult.Filters.Flag == null )
		false else (if((matches(scrubbedResult.Filters.Flag[0],/^N.*[^1]$/))) true else false),
		isWireless: if(scrubbedResult.Filters.Flag == null )
		false else (if((matches(scrubbedResult.Filters.Flag[0],/^W.*[^1]$/))) true else false),
		filterFlags: if(scrubbedResult.Filters.Flag == null) "No Filters " else scrubbedResult.Filters.Flag
	}
}