###
Publishers who will request game contracts

SDP.GDT.Company.companies can also be included as publishers


###

class SDP.GDT.Publisher
	topicOverride: []
	platformOverride: []
	genreWeightings: SDP.GDT.Weight.Default()
	audWeightings: SDP.GDT.Weight.Default(false)
	
	addTopicOverride: (id, weight) =>
		@topicOverride.push {id: id, weight: weight.clamp(0,1)} if Topics.topics.findIndex((val) -> val.id is id) isnt -1
		
	addPlatformOverride: (id, weight) =>
		@platformOverride.push {id: id, weight: weight.clamp(0,1)} if Platforms.allPlatforms.findIndex((val) -> val.id is id) isnt -1
		
	setWeight: (weight) =>
		@genreWeightings = weight if weight.isGenre()
		@audWeightings = weight if weight.isAudience()
	
	constructor: (name, id) ->
		@getName = -> name
		id = name.replace(/\s/g,"") unless id?
		@getId = -> id
		@isCompany = -> false
		
	@getCompany: (company) ->
		p = new Publisher(company.getName())
		p.isCompany = -> true
		p.company = company
		p
	
	@ACTIVEV = new Publisher("Active Visionaries")
	@EM = new Publisher("Electronic Mass Productions", "ea")
	@ROCKVILLE = new Publisher("Rockville Softworks")
	@BLUEBIT = new Publisher("Blue Bit Games")
	@CAPECOM = new Publisher("CapeCom")
	@CODEMEISTERS = new Publisher("Codemeisters")
	@DEEP = new Publisher("Deep Platinum")
	@INFRO = new Publisher("Infro Games")
	@LOWOOD = new Publisher("LoWood Productions")
	@TGQ = new Publisher("TGQ")
	@UBER = new Publisher("\u00dcberSoft")
	
	@[c.getName().toUpperCase()] = @getCompany(c) for c in SDP.GDT.Company.companies.toArray()
	
	toString: => @getName()
	
	getAudience: (random) =>
		auds = SDP.Enum.Audience.toArray()
		auds.forEach (val, i, arr) -> arr.push(val, val)
		for a in SDP.Enum.Audience.toArray()
			v = Math.floor(General.getAudienceWeighting(@audWeightings.get(), a)*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				auds.push(a)
				v--
			while v < 0
				auds.splice(auds.findIndex((val) -> val is a), 1)
				v++
		auds.pickRandom(random)
		
	getGenre: (random) =>
		defGenres = SDP.Enum.Genre.toArray()
		genres = SDP.Enum.Genre.toArray()
		genres.forEach (val, i, arr) -> arr.push(val, val)
		for g in defGenres
			v = Math.floor(General.getGenreWeighting(@genreWeightings.get(), g)*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				genres.push(g)
				v--
			while v < 0
				genres.splice(genres.findIndex((val) -> val is g), 1)
				v++
		genres.pickRandom(random)
		
	getPlatform: (random, defPlats) =>
		defPlats = defPlats.filter (p) -> @platformOverride.findIndex((v) -> v.id is p.id) isnt -1
		return unless defPlats
		platforms = defPlats.splice()
		platforms.forEach (val, i, arr) -> arr.push(val, val)
		for p in defPlats
			v = Math.floor(@platformOverride.find((val) -> val.id is p.id).weight*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				platforms.push(p)
				v--
			while v < 0
				platforms.splice(platforms.findIndex((val) -> val is g), 1)
				v++
		platforms.pickRandom(random)
		
	getTopic: (random, defTopics) =>
		defTopics = defTopics.filter (t) -> @topicOverride.findIndex((v) -> v.id is t.id) isnt -1
		return unless defPlats
		topics = defTopics.map (val) -> val
		topics.forEach (val, i, arr) -> arr.push(val, val)
		for p in defTopics
			v = Math.floor(@topicOverride.find((val) -> val.id is p.id).weight*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				topics.push(p)
				v--
			while v < 0
				topics.splice(topics.findIndex((val) -> val is g), 1)
				v++
		topics.pickRandom(random)