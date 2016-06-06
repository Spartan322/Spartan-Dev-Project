class SDP.GDT.Notification
	options: []
	
	constructor: (args...) ->
		for a, i in args
			if a instanceof SDP.GDT.Event
				event = a
				args[i] = undefined
		@header = if args[0]? then args[0] else '?'
		@text = if args[1]? then a[1] else '?'
		@buttonTxt = args[2]
		@untilFire = args[3]
		@image = args[4]
		@getSourceId = -> if event instanceof SDP.GDT.Event then event.getId() else 0
		@getEvent = -> if event instanceof SDP.GDT.Event then event else undefined
		
	addOption: (text) =>
		options.push(text.localize("decision action button")) if options.length < 3
		this
		
	addOptions: (txts...) =>
		if txts.length + options.length < 3 then @options.push(txts) else
			index = 0
			@options.push(txts[index++].localize("decision action button")) while @options.length < 3
		this
		
	setOptions: (options...) =>
		@options = options
		this
		
	toInput: =>
		new Notification {
			header: @header
			text: @text
			buttonText: @buttonTxt
			weeksUntilFire: @untilFire
			image: @image
			options: @options
			sourceId: @getSourceId()
			event: @getEvent()
		}
		
	addAsEvent: =>
		SDP.GDT.addEvent(this)
		
	trigger: =>
		SDP.GDT.triggerNotification(i)