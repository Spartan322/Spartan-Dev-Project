__notificationRep = Notification

class SDP.GDT.Notification

	constructor: (args...) ->
		if args.length is 1
			obj = args[0]
			if obj instanceof __notificationRep
				@header = obj.header
				@text = obj.text
				@buttonTxt = obj.buttonText
				@weeksUntilFire = obj.weeksUntilFire
				@image = obj.image
				@options = obj.options.slice()
				id = obj.sourceId
			else if obj instanceof Notification
				@header = obj.header
				@text = obj.text
				@buttonTxt = obj.buttonText
				@weeksUntilFire = obj.weeksUntilFire
				@image = obj.image
				@options = obj.options.slice()
				id = obj.getSourceId()
				event = obj.getEvent()
		else
			if args[0].constructor is String
				@header = args[0]
				@text = args[1]
				@buttonText = args[2]
				@weeksUntilFire = args[3]
				@image = args[4]
				event = args[5]
			else
				event = args[0]
				@header = args[1]
				@text = args[2]
				@buttonText = args[3]
				@weeksUntilFire = args[4]
				@image = args[5]
			id = if SDP.GDT.Event? and event instanceof SDP.GDT.Event then event.getId() else if event.id? then event.id else 0
			@options = []
		@sourceId = -> id
		@getEvent = (-> event) if event?

	addOption: (text) =>
		@options.push(text.localize("decision action button")) if @options.length < 3
		this

	addOptions: (txts...) =>
		if txts.length + @options.length < 3 then @options.push(txts) else
			index = 0
			@options.push(txts[index++].localize("decision action button")) while @options.length < 3
		this

	removeOption: (index) =>
		@options.splice(index, 1)
		this

	toInput: =>
		new Notification {
			header: @header
			text: @text
			buttonText: @buttonText
			weeksUntilFire: @weeksUntilFire
			image: @image
			options: @options
			sourceId: @sourceId
			event: @getEvent()
		}

	addAsEvent: =>
		SDP.GDT.addEvent(@) if @getEvent()?

	trigger: =>
		SDP.GDT.triggerNotification(@)