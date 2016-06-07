###
Functions which require patches
###
SDP.GDT.addTraining = (item) ->
	item = item.toInput() if SDP.GDT.Training? and item instanceof SDP.GDT.Training
	item.pointsCost = 0 unless item.pointsCost?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'duration', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Training.getAllTraining())
		Training.moddedTraining(item)
	return

SDP.GDT.addPublisher = (item) ->
	item = item.toInput() if SDP.GDT.Publisher? and item instanceof SDP.GDT.Publisher
	return if not Checks.checkUniqueness(item, 'id', Companies.getAllCompanies())
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', ProjectContracts.getAllPublishers())
		ProjectContracts.moddedPublishers.push(item)
	return

SDP.GDT.addReviewer = (item) ->
	if item.constructor is String then item = {id: item.replace(/\s/g,""), name: item}
	item = item.toInput() if SDP.GDT.Reviewer? and item instanceof SDP.GDT.Reviewer
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', Reviews.getAllReviewers())
		Reviews.moddedReviewers.push(item)
	return

SDP.GDT.addReviewMessage = (item) ->
	if item.constructor is String then item = {message: item, isRandom: true}
	if item.message or item.getMessage
		Reviews.moddedMessages.push(item)
	return

###
#
# Patches: improves game modularbility and performance and kills bugs
# Should force patches on mod load
#
###
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
	for modT in Training.moddedTraining when modT.id? and modT.isTraining # provide more expected behavior
		trainings.push(modT)
	return

###
Adds features to the publisher contracts which determine how they act
Also allows low chance for platform company to randomly give a publisher contract
###
ProjectContracts.createPublisher = (item, id) ->
	if item.constructor is String then item = {name: item}
	if id? then item.id = id
	if not item.id? and item.name? then item.id = name.replace(/\s/g,"_").toUpperCase()
	item
ProjectContracts.vanillaPublishers = [
	ProjectContracts.createPublisher("Active Visionaries")
	ProjectContracts.createPublisher("Electronic Mass Productions", "ea")
	ProjectContracts.createPublisher("Rockville Softworks")
	ProjectContracts.createPublisher("Blue Bit Games")
	ProjectContracts.createPublisher("CapeCom")
	ProjectContracts.createPublisher("Codemeisters")
	ProjectContracts.createPublisher("Deep Platinum")
	ProjectContracts.createPublisher("Infro Games")
	ProjectContracts.createPublisher("LoWood Productions")
	ProjectContracts.createPublisher("TGQ")
	ProjectContracts.createPublisher("\u00dcberSoft")
]
ProjectContracts.moddedPublishers = []
ProjectContracts.publisherContracts.__oldGetContract = ProjectContracts.publisherContracts.getContract
ProjectContracts.getAllPublishers = ->
	results = ProjectContracts.vanillaPublishers.filter (val) -> val.id?
	results.push(ProjectContracts.moddedPublishers.filter (val) -> val.id?)
	results
ProjectContracts.getAvailablePublishers = (company) ->
	week = Math.floor(company.currentWeek)
	ProjectContracts.getAllPublishers().filter((val) ->
		return (not val.startWeek? or week > General.getWeekFromDateString(val.startWeek, val.ignoreGameLengthModifier)) and (not val.retireWeek? or val.retireWeek is '260/12/4' or week < General.getWeekFromDateString(val.retireWeek, val.ignoreGameLengthModifier))
	)
ProjectContracts.getPublishingCompanies = (company) ->
	c = Companies.getAllCompanies(company).filter (val) -> val.notPublisher? and not val.notPublisher
	c.forEach (val) -> val.isCompany = true
	c

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
	publishers = ProjectContracts.getAvailablePublishers(company)
	publishers.push(ProjectContracts.getPublishingCompanies(company))
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
				break unless excludes.some (e) -> (not genre? or e.genre is genre.id) and e.topic is topic.id
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
	if reviews.length < 4 then throw "Reviewers are missing"
	if reviews.length is 4 then return [reviews[0],reviews[1],reviews[2], reviews[3]]
	random = company._mersenneTwister
	first = reviews.pickRandom(random)
	reviews = reviews.except(first)
	second = reviews.pickRandom(random)
	reviews = reviews.except(second)
	third = reviews.pickRandom(random)
	reviews = reviews.except(third)
	forth = reviews.pickRandom(random)
	company.randomCalled += 4
	[first, second, third, forth]

Reviews.getModdedPositiveMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when m.isPositive and not m.isNegative
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else result.push(m.message)
	result

Reviews.getModdedNegativeMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else result.push(m.message)
	result

Reviews.getModdedGenericMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when not m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else result.push(m.message)
	result

Reviews.__oldGetGenericReviewMessage = Reviews.getGenericReviewMessage
Reviews.getGenericReviewMessage = (game, score) ->
	if game.company.getRandom() <= 0.5 then Reviews.getModdedGenericMessages(game, score) else Reviews.__oldGetGenericReviewMessage(game, score)

Reviews.getReviews = (game, finalScore, positiveMessages, negativeMessages) ->
	intScore = Math.floor(finalScore).clamp(1, 10)
	if finalScore >= 9.5
		intScore = 10
	reviewers = Reviews.getFourRandomReviewers(game.company)
	reviews = []
	usedMessages = []
	scores = []
	variation = 1
	positiveMessages.push(Reviews.getModdedPositiveMessages(game))
	negativeMessages.push(Reviews.getModdedNegativeMessages (game))
	for i in [0...4] {
		if intScore is 5 or intScore is 6
			variation = if game.company.getRandom() < 0.05 then 2 else 1
		scoreVariation = if Math.randomSign() is 1 then 0 else variation * Math.randomSign()
		score = (intScore + scoreVariation).clamp(1, 10)
		if score is 10 and (scores.length is 3 and scores.average() is 10)
			if not game.flags.psEnabled
				if Math.floor(finalScore) < 10 or game.company.getRandom() < 0.8
					score--
			else if Math.floor(finalScore) is 10 and game.company.getRandom() < 0.4
				score++
		message = undefined
		loop
			if game.company.getRandom() <= 0.2
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