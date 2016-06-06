"use strict"
SDP = {}
SDP.Enum = {}

# This enum follows the order for mission overrides so it can be enumerated on that
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

# This enum follows traditional orders found throughout the source
SDP.Enum.Audience = SDP.Util.Enum.Generate('Audience', 
'young', 
'everyone', 
'mature')

# This enum follows the order for mission overrides so it can be enumerated on that
SDP.Enum.Genre = SDP.Util.Enum.Generate('Genre', 
'Action', 
'Adventure', 
'RPG', 
'Simulation', 
'Strategy', 
'Casual')
	
SDP.GDT = {}

# Reimplements addResearchItem so if v is missing, research can be more flexible
SDP.GDT.addResearchItem = (item) ->
	item = item.toInput() if item instanceof SDP.GDT.Research
	if item.v? then GDT.addResearchItem(item) else
		Research.engineItems.push(item) if Checks.checkPropertiesPresent(item, ['id', 'name', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Research.getAllItems())
	return

# Reimplements addPlatform so iconUri can be replaced with baseIconUri and imageDates
SDP.GDT.addPlatform = (item) ->
	item = item.toInput() if item instanceof SDP.GDT.Platform
	if item.iconUri? then GDT.addPlatform(item) else
		if Checks.checkPropertiesPresent(item, ['id', 'name', 'startAmount', 'unitsSold', 'licencePrize', 'published', 'platformRetireDate', 'developmentCosts', 'genreWeightings', 'audienceWeightings', 'techLevel', 'baseIconUri', 'imageDates']) and Checks.checkUniqueness(item, 'id', Platforms.allPlatforms) and Checks.checkAudienceWeightings(item.audienceWeightings) and Checks.checkGenreWeightings(item.genreWeightings) and Checks.checkDate(item.published) and Checks.checkDate(item.platformRetireDate)
			if item.marketPoints then for point in item.marketPoints
				return unless Checks.checkDate(point.date)
			Platforms.allPlatforms.push(item)
			if item.events then for event of item.events
				GDT.addEvent(event) unless event instanceof SDP.GDT.Event then event.add()
	return

# Simply wraps GDT.addTopic, allowing object oriented inputs
SDP.GDT.addTopic = (item) ->
	item = item.toInput() if item instanceof SDP.GDT.Topic
	item.genreWeightings = item.genreWeightings.toGenre().get() if item.genreWeightings instanceof SDP.GDT.Weight
	item.audienceWeightings = item.audienceWeightings.toAudience().get() if item.audienceWeightings instanceof SDP.GDT.Weight
	GDT.addTopic(item)

# Adds a lab research project
SDP.GDT.addResearchProject = (item) ->
	item.canResearch = ((company)->true) unless item.canResearch?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'iconUri', 'description', 'targetZone']) and Checks.checkUniqueness(item, 'id', Research.bigProjects)
		Research.bigProjects.push(item)
	return

# Adds a type of training to the training list when staff can be trained
SDP.GDT.addTraining = (item) ->
	item.pointsCost = 0 unless item.pointsCost?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'duration', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Training.getAllTraining())
		Training.moddedTraining(item)
	return
	
# Triggers a notification (or clock if weeksUntilFired exists) only if you GameManager.company.notifications is available
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
	
# Simply wraps GDT.addEvent, allowing object oriented inputs
SDP.GDT.addEvent = (item) ->
	if item instanceof SDP.GDT.Event then item = item.toInput() else
		item = item.getEvent() if item.getEvent?
		item = item.event if item.event?
	GDT.addEvent(item)

# Adds publisher modifications with extensive control over them
SDP.GDT.addPublisher = (item) ->
	item = SDP.GDT.Publisher.getCompany(item) if item instanceof SDP.GDT.Company
	if Checks.checkPropertiesPresent(item, ['id', 'name'] and Checks.checkUniqueness(item, 'id', ProjectContracts.getAllPublishers())
		ProjectContracts.moddedPublishers.push(item)
	return
	
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
#
# Patches Sections: improves game modularbility and performance and kills bugs
# Should force patches on mod load
#
###
GDT.on(GDT.eventKeys.saves.loading, ->
SDP.GDT.Internal = {}
SDP.GDT.Internal.notificationsToTrigger = []

###
Triggers all notifications in the case they couldn't be triggered before (ie: before the GameManager.company.notification existed
###
GDT.on(GDT.eventKeys.saves.loaded, -> 
	GameManager.company.notifications.push(i) for i in SDP.GDT.Internal.notificationsToTrigger
	SDP.GDT.Internal.notificationsToTrigger = [])
GDT.on(GDT.eventKeys.saves.newGame, -> 
	GameManager.company.notifications.push(i) for i in SDP.GDT.Internal.notificationsToTrigger
	SDP.GDT.Internal.notificationsToTrigger = [])

###
Allows new platforms to incorporate different images based on the date
###
Platforms._oldGetPlatformImage = Platforms.getPlatformImage
Platforms.getPlatformImage = (platform, week) ->
	if platform.id is 'PC' then return Platforms._oldGetPlatformImage(platform, week)
	if not platform.imageDates? or not platform.baseIconUri? then return platform.iconUri
	baseUri = platform.baseIconUri
	image = null
	if week and platform.imageDates.constructor is Array
		image = "{0}/{1}-{2}.png".format(baseUri, platform.id, String(i+1)) for date, i in platform.imageDates when General.getWeekFromDateString(date) <= week and i isnt 0
	image = "{0}/{1}.png".format(baseUri, platform.id) unless image?
	return image
###
Forces getAllTraining to include modded training
###
Training._oldGetAllTraining = Training.getAllTraining
Training.moddedTraining = []
Training.getAllTraining = ->
	trainings = Training._oldGetAllTraining()
	for modT in Training.moddedTraining when modT.id? and (modT.pointsCost? or modT.duration?)
		modT.isTraining
		trainings.push(modT)
	return

###
Adds features to the publisher contracts which determine how they act
Also allows low chance for platform company to randomly give a publisher contract
###
ProjectContracts.moddedPublishers = []
ProjectContracts.publisherContracts.__oldGetContract = ProjectContracts.publisherContracts.getContract
ProjectContracts.getAllPublishers = ->
	results = SDP.GDT.Publisher.publishers.slice()
	results.push(ProjectContracts.moddedPublishers.slice())
	results

ProjectContracts.getAvailablePublisher = (company) ->
	week = Math.floor(company.currentWeek)
	ProjectContracts.getAllPublishers().filter((val) ->
		return (not val.startWeek? or week > General.getWeekFromDateString(val.startWeek, val.ignoreGameLengthModifier)) and (not val.retireWeek? or week < General.getWeekFromDateString(val.retireWeek, val.ignoreGameLengthModifier))
	)
	
SDP.GDT.Internal.getGenericContractsSettings = (company, type) ->
	key = "contracts#{type}"
	settings = company.flags[key]
	if not settings
		settings = {id: key}
		company.flags[key] = settings
	settings

SDP.GDT.Internal.generatePublisherContracts = (company, settings, maxNumber) ->
	contracts = []
	seed = settings.seed
	random = new MersenneTwister(SDP.Util.getSeed(settings))
	if settings.seed isnt seed
		settings.topic = undefined
		settings.researchedTopics = undefined
		settings.excludes = undefined
		settings.platforms = undefined
	if not settings.topics or not settings.researchedTopics or not settings.platforms
		topics = company.topics.slice()
		topics.addRange(General.getTopicsAvailableForResearch(company))
		settings.topics = topics.map (t) -> t.id
		researchedTopics = company.topics.map (t) -> t.id
		settings.researchedTopics = researchedTopics
		platforms = Platforms.getPlatformsOnMarket(company).filter (p) -> not p.isCustom and Platforms.doesPlatformSupportGameSize(p, "medium")
		settings.platforms = platforms.map (p) -> p.id
		settings.excludes = []
		lastGame = company.gameLog.last()
		settings.excludes.push {genre: lastGame.genre.id, topic: lastGame.topic.id} if lastGame
	else
		topics = settings.topics.map (id) -> Topics.topics.first (t) -> t.id is id
		researchedTopics = settings.researchedTopics.map (id) -> Topics.topics.first (t) -> t.id is id
		allPlatforms = Platforms.getPlatforms(company, true)
		platforms = settings.platforms.map (id) -> allPlatforms.first (p) -> p.id is id
	excludes = settings.excludes.slice()
	count = SDP.Util.getRandomInt(random, maxNumber)
	count = Math.max(1, count) if settings.intialSettings
	sizes = ["medium"]
	sizes.push("large","large","large") if company.canDevelopLargeGames()
	audiences = SDP.Enum.Audience.toArray()
	publishers = ProjectContracts.getAvailablePublisher(company)
	sizeBasePay = { medium:15E4, large:15E5/2 }
	for i in [0...count]
		if platform and (platform.company and random.random() <= 0.2)
			publisher = publishers.find((val) -> val.toString() is platform.company)
		else if random.random() <= 0.1
			publisher = publishers.pickRandom(random) # Adds a low chance for random platform company contracts
		else publisher = publishers.filter((val) -> not val.isCompany?()).pickRandom(random)
		diffculty = 0
		genre = undefined
		topic = undefined
		if random.random() <= 0.7
			genre = if publisher.getGenre? then publisher.getGenre(random) else General.getAvailableGenres(company).pickRandom(random)
			diffculty += 0.1
		if random.random() <= 0.7
			loop 
				if random.random() <= 0.7
					topic = if publisher.getTopic? then publisher.getTopic(random, topics.except(researchedTopics)) else topics.except(researchedTopics).pickRandom(random)
				else
					topic = if publisher.getTopic? then publisher.getTopic(random, topics) else topics.pickRandom(random)
				break if topic?
				break unless (excludes.some (e) -> (not genre? or e.genre is genre.id) and e.topic is topic.id)
			difficulty += 0.1 if topic?
		excludes.push({genre: genre?.id, topic: topic?.id}) if genre or topic
		platform = undefined
		if random.random() <= 0.7
			platform = if publisher.getPlatform? then publisher.getPlatform(random, platforms) else platform = platforms.pickRandom(random)
		audience = undefined
		if company.canSetTargetAudience() and random.random() <= 0.2
			audience = if publisher.getAudience? then publisher.getAudience(random) else audience = audiences.pickRandom(random)
		diffculty += 0.8 * random.random()
		minScore = 4 + Math.floor(5 * diffculty)
		loop
			size = sizes.pickRandom(random)
			break unless platform? and not Platforms.doesPlatformSupportGameSize(platform, size)
		basePay = sizeBasePay[size]
		pay = basePay * (minScore/10)
		pay /= 5E3
		pay = Math.max(1, Math.floor(pay)) * 5E3
		penalty = pay * 1.2 + pay * 1.8 * random.random()
		penalty /= 5E3
		penalty = Math.floor(penalty) * 5E3
		royaltyRate = Math.floor(7 + 8 * difficulty) / 100
		name = "#{if topic then topic.name else "Any Topic".localize()} / #{if genre then genre.name else "Any Genre".localize()}"
		if not platform or Platforms.getPlatformsOnMarket(company).first (p) -> p.id is platform.id
			pubName = if publisher.getName? then publisher.getName() else publisher.toString()
			contracts.push {
				id: "publisherContracts"
				refNumber: Math.floor(Math.random() * 65535)
				type: "gameContract"
				name: name
				description: "Publisher: {0}".localize().format(pubName)
				publisher: pubName
				topic: if topic then topic.id else topic
				genre: if genre then genre.id else genre
				platform: if platform then platform.id else undefined
				gameSize: size
				gameAudience: audience
				minScore: minScore
				payment: pay
				penalty: penalty
				royaltyRate: royaltyRate
			}
		else count++
	contracts
	
ProjectContracts.publisherContracts.getContract = (company) ->
	SDP.GDT.Internal.generatePublisherContracts(company, SDP.GDT.Internal.getGenericContractsSettings(company, "publisher"), 5).filter (c) -> not c.skip
	
###
Allows adding reviewer names to the reviewer list along with existing and retire dates
Allows adding review messages
###
Reviews.moddedReviewers = []
Reviews.moddedMessages = []
Reviews.vanillaReviewers = [
	{id: 'StarGames', name: 'Star Games'}
	{id: 'InformedGamer', name: 'Informed Game'}
	{id: 'GameHero', name: 'Game Hero'}
	{id: 'AllGames', name: 'All Games'}
]
Reviews.getAllReviewers = ->
	result = Reviews.vanillaReviewers.slice()
	result.push(Reviews.moddedReviewers.slice())
	result
	
Reviews.getAvailableReviewers = (company) ->
	week = Math.floor(company.currentWeek)
	Reviews.getAllReviewers().filter((val) ->
		return (not val.startWeek? or week > General.getWeekFromDateString(val.startWeek, val.ignoreGameLengthModifier)) and (not val.retireWeek? or week < General.getWeekFromDateString(val.retireWeek, val.ignoreGameLengthModifier))
	)
	
Reviews.getFourRandomReviewers = (company) ->
	reviews = Reviews.getAvailableReviewers(company)
	random = company.getRandom()
	first = reviews.pickRandom(random)
	reviews = reviews.except(first)
	second = reviews.pickRandom(random)
	reviews = reviews.except(second)
	third = reviews.pickRandom(random)
	reviews = reviews.except(third)
	forth = reviews.pickRandom(random)
	
Reviews.getReviews = (game, finalScore, positiveMessages, negativeMessages) ->
	intScore = Math.floor(finalScore).clamp(1, 10)
	if finalScore >= 9.5
		intScore = 10
	reviewers = Reviews.getFourRandomReviewers(game.company)
	reviews = []
	usedMessages = []
	scores = []
	variation = 1
	for i in [0...4] {
		if intScore is 5 or intScore is 6
			variation = if GameManager.company.getRandom() < 0.05 then 2 else 1
		scoreVariation = if Math.randomSign() is 1 then 0 else variation * Math.randomSign()
		score = (intScore + scoreVariation).clamp(1, 10)
		if score is 10 and (scores.length is 3 and scores.average() is 10)
			if not game.flags.psEnabled
				if Math.floor(finalScore) < 10 or GameManager.company.getRandom() < 0.8
					score--
			else if Math.floor(finalScore) is 10 and GameManager.company.getRandom() < 0.4
				score++
		message = undefined
		loop
			if GameManager.company.getRandom() <= 0.2
				if scoreVariation >= 0 and (score > 2 and positiveMessages.length isnt 0)
					message = positiveMessages.pickRandom()
				else
					if (scoreVariation < 0 and (score < 6 and negativeMessages.length isnt 0))
						message = negativeMessages.pickRandom()
			else
				message = undefined
			if not message
				message = Reviews.getGenericReviewMessage(game, score)
		break unless usedMessages.weakIndexOf(message) isnt -1
		usedMessages.push(message)
		scores.push(score)
		reviews.push {
			score : score
			message : message
			reviewerName : reviewers[i].name
		}
	}
	return reviews
	
###
Forces all games to contain the company
###
class Game extends Game 
	constructor: (company) ->
		@id = GameManager.getGUID()
		@title = undefined
		@genre = undefined
		@topic = undefined
		@platforms = []
		@engine = undefined
		@state = GameState.notStarted
		@gameSize = "small"
		@targetAudience = "everyone"
		@missionLog = []
		@salesCashLog = []
		@featureLog = null
		@score = 0
		@reviews = []
		@costs = 0
		@hypePoints = 0
		@technologyPoints = 0
		@bugs = 0
		@freeBugCount = 0
		@designPoints = 0
		@currentSalesCash = 0
		@totalSalesCash = 0
		@amountSold = 0
		@releaseWeek = 0
		@fansChangeTarget = 0
		@fansChanged = 0
		@initialSalesRank = 0
		@currentSalesRank = 0
		@topSalesRank = 0
		@researchFactor = 1
		@revenue = 0
		@flags = {}
		@soldOut = false
		if company.conferenceHype
			@hypePoints = company.conferenceHype
			company.conferenceHype = Math.floor(company.conferenceHype / 3)
# End of Patches
)