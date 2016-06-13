class SDP.GDT.Date

	REQUIRED_VALS = 3

	constructor: (@year = 1, @month = 1, @week = 1) ->
		if typeof @year is 'string'
			val = @year.split("/")
			val.push(1) while val.length < REQUIRED_VALS
			@year = val[0]
			@month = val[1]
			@week = val[2]

		if typeof @year is 'object' and typeof @year.week is 'number' and typeof @year.month is 'number' and typeof @year.year is 'number'
			@week = @year.week
			@month = @year.month
			@year = @year.year

		@year = 1 if typeof @year isnt 'number'
		@month = 1 if typeof @month isnt 'number'
		@week = 1 if typeof @week isnt 'number'
	
	MAX_DATE = SDP.GDT.Date(260,12,4)

	@Max: ->
		return Date(MAX_DATE)

	equals: (date) ->
		return true if this is date
		if not date then return false
		return @year is date.year and @month is date.month and @week is date.week

	toString: ->
		return "{0}/{1}/{2}".format(@year, @month, @week)