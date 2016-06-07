"use strict"
SDP = {}

###
Enums: enumerable objects
###
SDP.Enum = {}

SDP.Enum.ResearchCategory = SDP.Util.Enum.Generate('ResearchCategory',
'Engine',
'Gameplay',
'Story/Quests',
'Dialogs',
'Level Design',
'AI',
'World Design',
'Graphic',
'Sound')

SDP.Enum.Audience = SDP.Util.Enum.Generate('Audience',
'young',
'everyone',
'mature')

SDP.Enum.Genre = SDP.Util.Enum.Generate('Genre',
'Action',
'Adventure',
'RPG',
'Simulation',
'Strategy',
'Casual')

###
Addition Functions: adds basic game objects
###
SDP.GDT = {}

SDP.GDT.addResearchItem = (item) ->
	item = item.toInput() if SDP.GDT.Research? and item instanceof SDP.GDT.Research
	if item.v? then GDT.addResearchItem(item) else
		Research.engineItems.push(item) if Checks.checkPropertiesPresent(item, ['id', 'name', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Research.getAllItems())
	return

SDP.GDT.addPlatform = (item) ->
	item = item.toInput() if SDP.GDT.Platform? and item instanceof SDP.GDT.Platform
	if item.iconUri? then GDT.addPlatform(item) else
		if Checks.checkPropertiesPresent(item, ['id', 'name', 'company', 'startAmount', 'unitsSold', 'licencePrize', 'published', 'platformRetireDate', 'developmentCosts', 'genreWeightings', 'audienceWeightings', 'techLevel', 'baseIconUri', 'imageDates']) and Checks.checkUniqueness(item, 'id', Platforms.allPlatforms) and Checks.checkAudienceWeightings(item.audienceWeightings) and Checks.checkGenreWeightings(item.genreWeightings) and Checks.checkDate(item.published) and Checks.checkDate(item.platformRetireDate)
			if item.marketPoints then for point in item.marketPoints
				return unless Checks.checkDate(point.date)
			if Checks.checkUniqueness(item.name, 'name', Companies.getAllCompanies())
				SDP.GDT.addCompany(item.name).addPlatform(item)
			else Platforms.allPlatforms.push(item)
			if item.events then for event of item.events
				GDT.addEvent(event) unless event instanceof SDP.GDT.Event then event.add()
	return

SDP.GDT.addTopic = (item) ->
	item = item.toInput() if SDP.GDT.Topic? and item instanceof SDP.GDT.Topic
	item.genreWeightings = item.genreWeightings.toGenre().get() if SDP.GDT.Weight? and item.genreWeightings instanceof SDP.GDT.Weight
	item.audienceWeightings = item.audienceWeightings.toAudience().get() if SDP.GDT.Weight? and item.audienceWeightings instanceof SDP.GDT.Weight
	GDT.addTopic(item)

SDP.GDT.addResearchProject = (item) ->
	item = item.toInput() if SDP.GDT.ResearchProject? and item instanceof SDP.GDT.ResearchProject
	item.canResearch = ((company)->true) unless item.canResearch?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'iconUri', 'description', 'targetZone']) and Checks.checkUniqueness(item, 'id', Research.bigProjects)
		Research.bigProjects.push(item)
	return

SDP.GDT.triggerNotification = (item) ->
	item.header = '?' unless item.header?
	item.text = '?' unless item.text?
	if not item instanceof Notification
		item = new Notification {
			header: item.header ? '?'
			text: item.text ? '?'
			buttonText: item.buttonText
			weeksUntilFired: item.weeksUntilFired
			image: item.image
			options: item.options.slice(0, 3)
			sourceId: item.sourceId
		}
	if GameManager?.company?.notifications? then GameManager.company.notifications.push(item) else SDP.GDT.Internal.notificationsToTrigger.push(item)

SDP.GDT.addEvent = (item) ->
	if SDP.GDT.Event? and item instanceof SDP.GDT.Event then item = item.toInput() else
		item = item.getEvent() if item.getEvent?
		item = item.event if item.event?
	GDT.addEvent(item)

SDP.GDT.addCompany = (item) ->
	if item.constructor is String then item = Companies.createCompany(item)
	item = item.toInput() if SDP.GDT.Company? and item instanceof SDP.GDT.Company
	item.sort = ->
		item.platforms.sort (a,b) ->
			General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
	item.addPlatform = (platform) ->
		platform.company = item.name
		SDP.GDT.addPlatform(platform)
		item.platforms.push(platform)
		item.sort()
		platform
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', Companies.getAllCompanies())
		Companies.moddedCompanies.push(item)
	return item

###
GDT Utility: Functions which are for utility of GDT
###
SDP.GDT.getOverridePositions = (genre, category) ->
	genre = genre.replace(/\s/g, "")
	category = category.replace(/\s/g, "")
	for g, i in SDP.Enum.Genre.toArray()
		if genre is g
			for c, ci in SDP.Enum.ResearchCategory.toArray()
				if c is category then return [i,ci]
			break
	return undefined

###
Adds company tracking system
###
Companies = {}
Companies.createCompany = (item) ->
	if item.constructor is String then item = {name: item}
	if not item.id? and item.name? then item.id = name.replace(/\s/g,"")
	item.platforms = []
	item.platforms.push(p) for p of Platforms.allPlatforms when p.company is item.name
	item.sort = ->
		item.platforms.sort (a,b) ->
			General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
	item.addPlatform = (platform) ->
		platform.company = item.name
		SDP.GDT.addPlatform(platform)
		item.platforms.push(platform)
		item.sort()
		platform
	item.sort()
	item
Companies.createVanillaCompany = (item) ->
	Companies.createCompany(item)
	item.isVanilla = true
	item
Companies.vanillaCompanies = [
	Companies.createVanillaCompany("Micronoft")
	Companies.createVanillaCompany("Grapple")
	Companies.createVanillaCompany("Govodore")
	Companies.createVanillaCompany("Ninvento")
	Companies.createVanillaCompany("Vena")
	Companies.createVanillaCompany("Vonny")
	Companies.createVanillaCompany("KickIT")
]
Companies.moddedCompanies = []
Companies.getAllCompanies = ->
	c = Companies.vanillaCompanies.filter (val) -> val.id?
	c.push(Companies.moddedCompanies.filter (val) -> val.id?)
	for comp of c
		comp.sort = ->
			comp.platforms.sort (a,b) ->
				General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
		comp.sort()
	c.sort (a,b) ->
		General.getWeekFromDateString(a.platforms[0].published) - General.getWeekFromDateString(b.platforms[0].published)
	c
Companies.getAvailableCompanies = (company) ->
	week = Math.floor(company.currentWeek)
	Companies.getAllCompanies().filter (val) ->
		General.getWeekFromDateString(val.platforms[0].published) <= week
