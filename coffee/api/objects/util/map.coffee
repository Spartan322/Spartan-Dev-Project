class SDP.Util.Map
	constructor: (@origArr...) ->
		@nameArray = []
		@map = {}
		for obj in @origArr
			@add(obj)
	
	add: (obj, getterName = "getName") =>
		if typeof obj[getterName] is 'function'
			@addByName(obj[getterName](), obj)
		else if typeof obj.toString is 'function'
			@addByName(obj.toString(), obj)
			
	addByName: (name, obj) =>
		name = String(name)
		@map[name] = obj
		@nameArray.push(name)
		
	get: (name) =>
		@map[String(name)]
		
	containsKey: (name) =>
		@map[String(name)]?
		
	containsVal: (val) =>
		for obj in @map
			return true if obj is val
		return false
	
	toArray: =>
		a = @cachedArray.slice(0)
		a.push(@get(n)) for n in @nameArray when a.indexOf(@get(n)) is -1
		@cachedArray = a.slice(0)
		a