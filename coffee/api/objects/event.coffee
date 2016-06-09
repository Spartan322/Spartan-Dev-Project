
SDP.GDT.__notUniqueEvent = (id) ->
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', DecisionNotifications.modNotifications)

class SDP.GDT.Event

	constructor: (id, @date, @isRandomEvent,  @ignoreLenMod) ->
		unless id? then throw new TypeError("id can't be undefined")
		if id instanceof Event
			e = id
			id = e.getId()
			@getId = -> id
			@date = new SDP.GDT.Date(e.date) if e.date?
			@isRandomEvent = e.isRandomEvent
			@ignoreLenMod = e.ignoreLenMod
			@maxTriggers = e.maxTriggers
			@trigger = e.trigger?.bind(this)
			@complete = e.complete?.bind(this)
			@getNotification = e.getNotification
		else if id.id?
			e = id
			id = e.id
			@getId = -> id
			@date = e.date
			@isRandomEvent = e.isRandomEvent
			@ignoreLenMod = e.ignoreGameLengthModifier
			@maxTriggers = e.maxTriggers
			@trigger = e.trigger
			@complete = e.complete
			@getNotification = unless e.notification? then e.getNotification else ((company) -> e.notification)
		else
			@maxTriggers = 1
			@trigger = (company) -> false
			@complete = (decision) -> return
			@getNotification = (company) -> new SDP.GDT.Notification(this)
			@getId = -> id
		@getNotification.bind(this)
		id += '_' while SDP.GDT.__notUniqueEvent(id)
		@getId = -> id

	toInput: =>
		{
			id: @getId()
			date: @date unless @date instanceof SDP.GDT.Date then @date.toString()
			isRandomEvent: @isRandomEvent
			ignoreGameLengthModifier: @ignoreLenMod
			maxTriggers: @maxTriggers
			trigger: @trigger
			getNotification: @getNotification
			complete: @complete
		}

	add: =>
		GDT.addEvent(@)