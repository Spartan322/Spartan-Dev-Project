
SDP.GDT.__notUniquePlatform = (id) ->
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', Platforms.allPlatforms)

class SDP.GDT.Platform
	
	events: []
	marketPoints: []
	genreWeight: Weight.Default()
	audienceWeight: Weight.Default(false)
	
	constructor: (name, id = name) ->
		@getName = -> name.localize("game platform")
		@company = null
		@startAmount = 0
		@unitsSold = 0
		@licensePrice = 0
		@publishDate = SDP.GDT.Date(1,1,1)
		@retireDate = SDP.GDT.Date.Max()
		@devCost = 0
		@techLevel = 1
		@iconUri = undefined
		@baseIconUri = undefined
		@imageDates = undefined
		@getId = -> id
		
	addEvent: (e) ->
		@events.push(e) if e instanceof SDP.GDT.Event
		this
		
	removeEvent: (id) ->
		index = @events.findIndex((val) -> val.id is id)
		@events.splice(index, 1) if index isnt -1
		
	addMarketPoint: (date, amount) ->
		return unless date?
		if date instanceof SDP.GDT.Date then date = date.toString()
		else if date.week? and date.month? and date.year? then date = "{0}/{1}/{2}".format(date.year, date.month, date.week)
		if typeof date isnt 'string' then return
		@marketPoints.push {
			'date': date
			'amount': amount
		} if date? and amount?
		this
		
	removeMarketDate: (date) ->
		index = @marketPoints.findIndex((val) -> val.date is date)
		@marketPoints.splice(index, 1) if index isnt -1
		
	setWeight: (weight) ->
		unless weight instanceof Weight then return
		if weight.isGenre() then @genreWeight = weight else @audienceWeight = weight
		this
		
	getPrimEvents: ->
		arr = []
		arr.push(evt.toInput()) for evt in @events
		arr
		
	toInput: ->
		id = @getId()
		id += '_' while SDP.GDT.__notUniquePlatform(id)
		@getId = -> id
		{
			id: @getId()
			name: @getName()
			iconUri: @iconUri
			imageDates: @imageDates
			baseIconUri: @baseIconUri
			company: if typeof @company.getName is "function" then @company.getName() else @company.toString()
			startAmount: @startAmount
			unitsSold: @unitsSold
			marketKeyPoints: @marketPoints
			licensePrice: @licensePrice
			published: @publishDate
			platformRetireDate: @retireDate
			developmentCost: @devCost
			genreWeightings: @genreWeight.toGenre().get()
			audienceWeightings: @audienceWeight.toAudience().get()
			techLevel: @techLevel
			events: @getPrimEvents()
		}
		
	add: ->
		GDT.addPlatform(@toInput())
		return this