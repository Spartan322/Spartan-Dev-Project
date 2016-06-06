class SDP.GDT.Date
	
	MAX_DATE = SDP.GDT.Date(260,12,4)
	REQUIRED_VALS = 3
	
	constructor: (@year = 1, @month = 1, @week = 1) ->
		if typeof @year is 'string'
			val = @year.split("/")
			val.push(1) while val < REQUIRED_VALS
			@year = val[0]
			@month = val[1]
			@week = val[2]
	
		if typeof @year is 'object' and typeof @year.week is 'number' and typeof @year.month is 'number' and typeof @year.year is 'number'
			@week = @year.week
			@month = @year.month
			@year = @year.year
		
		if typeof @year isnt 'number' and typeof @month isnt 'number' and typeof @week isnt 'number'
			@year = 1
			@month = 1
			@week = 1
	
	@Max: ->
		return Date(MAX_DATE)
	
	equals: (date) ->
		if super(date) then return true
		if not date then return false
		return @year is date.year and @month is date.month and @week is date.week
		
	toString: ->
		return "{0}/{1}/{2}".format(@year, @month, @week)