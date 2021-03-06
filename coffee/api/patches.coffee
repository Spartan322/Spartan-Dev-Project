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

SDP.GDT.addContract = (item) ->
	item = item.toInput() if SDP.GDT.Contract? and item instanceof SDP.GDT.Contract
	if Checks.checkPropertiesPresent(item, ['name', 'description', 'dF', 'tF'])
		ProjectContracts.moddedContracts.push(item)
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

SDP.GDT.addApplicantFunctor = (item) ->
	if Checks.checkPropertiesPresent(item, ['apply', 'forMale']) and typeof apply is "function"
		JobApplicants.moddedAlgorithims.push(item)
	return

SDP.GDT.addFamousFunctor = (item) ->
	if Checks.checkPropertiesPresent(item, ['apply', 'forMale']) and typeof apply is "function"
		JobApplicants.moddedFamous.push(item)
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
	if not item.id? and item.name? then item.id = name.replace(/\s/g,"")
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
	sizeBasePay = { medium:15e4, large:15e5/2 }
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
		pay /= 5e3
		pay = Math.max(1, Math.floor(pay)) * 5e3
		penalty = pay * 1.2 + pay * 1.8 * random.random()
		penalty /= 5e3
		penalty = Math.floor(penalty) * 5e3
		royaltyRate = Math.floor(7 + 8 * difficulty) / 100
		name = "#{if topic then topic.name else 'Any Topic'.localize()} / #{if genre then genre.name else 'Any Genre'.localize()}"
		if not platform or Platforms.getPlatformsOnMarket(company).first((p) -> p.id is platform.id)
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
Allows adding of standard contract work
###
ProjectContracts.moddedContracts = []
ProjectContracts.getAvailableModContractsOf = (company, size) ->
	contracts = []
	for c in ProjectContracts.moddedContracts when not c.isAvailable? or (c.isAvailable? and c.isAvailable(company))
		contracts.push(c) if c.size is size
	contracts

ProjectContracts.genericContracts.__oldGetContract = ProjectContracts.genericContracts.getContract
ProjectContracts.genericContracts.getContract = (company) ->
	settings = SDP.GDT.Internal.getGenericContractsSettings(company, "small")
	seed = SDP.Util.getSeed(settings)
	random = new MersenneTwister(seed)
	genCon = SDP.GDT.Internal.generateContracts
	resultContracts = []
	contracts = ProjectContracts.genericContracts.__oldGetContract(company)
	contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "small"), 4)
	if company.flags.mediumContractsEnabled
		settings = SDP.GDT.Internal.getGenericContractsSettings(company, "medium")
		contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "medium"), 3)
	if company.flags.largeContractsEnabled
		settings = SDP.GDT.Internal.getGenericContractsSettings(company, "large")
		contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "large"), 2)
	return contracts.shuffle(random).filter (c) -> not c.skip

SDP.GDT.Internal.generateContracts = (company, settings, sourceSet, size, maxNumber) ->
	seed = SDP.Util.getSeed(settings)
	random = new MersenneTwister(seed)
	contracts = []
	set = sourceSet.slice()
	count = SDP.Util.getRandomInt(random, maxNumber)
	count = Math.max(1, count) if settings.intialSettings
	for i in [0...count] when set.length > 0
		item = set.pickRandom(random)
		set.remove(item)
		contract = SDP.GDT.Internal.generateSpecificContract(company, item, size, random)
		contract.id = "genericContracts"
		contract.index = i
		contract.skip = true if settings.contractsDone and settings.contractsDone.indexOf(i) isnt -1
		contracts.push(contract)
	contracts

SDP.GDT.Internal.generateSpecificContract = (company, template, size, random) ->
	r = random.random()
	r += random.random() if random.random() > 0.8
	minPoints = 11
	minPoints = 30 if size is "medium"
	minPoints = 100 if size is "large"
	minPoints += 6 if minPoints is 12 and company.staff.length > 2
	factor = company.getCurrentDate().year / 25
	minPoints += minPoints * factor
	points = minPoints + minPoints * r
	pointPart = points / (template.dF + template.tF)
	d = pointPart * template.dF
	t = pointPart * template.tF
	d += d * 0.2 * random.random() * random.randomSign()
	t += t * 0.2 * random.random() * random.randomSign()
	d = Math.floor(d)
	t = Math.floor(t)
	pay = points * 1e3
	pay /= 1e3
	pay = Math.floor(pay) * 1e3
	weeks = Math.floor(3 + 7 * random.random())
	weeks = Math.floor(3 + 3 * random.random()) if size is "small"
	penalty = pay * 0.2 + pay * 0.3 * random.random()
	penalty /= 1e3
	penalty = Math.floor(penalty) * 1e3
	return {
		name : template.name,
		description : template.description
		requiredD : d
		requiredT : t
		spawnedD : 0
		spawnedT : 0
		payment : pay
		penalty : -penalty
		weeksToFinish : weeks
		rF : template.rF
		isGeneric : true
		size : size
	}

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
	result.addRange(Reviews.moddedReviewers.slice())
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
		else if m.message? then result.push(m.message)
	result

Reviews.getModdedNegativeMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else if m.message? then result.push(m.message)
	result

Reviews.getModdedGenericMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when not m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else if m.message? then result.push(m.message)
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
	positiveMessages.addRange(Reviews.getModdedPositiveMessages(game))
	negativeMessages.addRange(Reviews.getModdedNegativeMessages (game))
	for i in [0...4]
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
	return reviews

###
Forces all games to contain the company
###
`Game = (function(superClass) {
	var __extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; }
	__extend(Game, superClass);

	function Game(company) {
		this.id = GameManager.getGUID();
		this.title = void 0;
		this.genre = void 0;
		this.topic = void 0;
		this.platforms = [];
		this.engine = void 0;
		this.state = GameState.notStarted;
		this.gameSize = "small";
		this.targetAudience = "everyone";
		this.missionLog = [];
		this.salesCashLog = [];
		this.featureLog = null;
		this.score = 0;
		this.reviews = [];
		this.costs = 0;
		this.hypePoints = 0;
		this.technologyPoints = 0;
		this.bugs = 0;
		this.freeBugCount = 0;
		this.designPoints = 0;
		this.currentSalesCash = 0;
		this.totalSalesCash = 0;
		this.amountSold = 0;
		this.releaseWeek = 0;
		this.fansChangeTarget = 0;
		this.fansChanged = 0;
		this.initialSalesRank = 0;
		this.currentSalesRank = 0;
		this.topSalesRank = 0;
		this.researchFactor = 1;
		this.revenue = 0;
		this.flags = {};
		this.soldOut = false;
		this.company = company;
		if (company.conferenceHype) {
		  this.hypePoints = company.conferenceHype;
		  company.conferenceHype = Math.floor(company.conferenceHype / 3);
		}
	}

	return Game;

})(Game)`

###
Allow adding famous people and adding custom applicant algorithims
###
JobApplicants.moddedFamous = []
JobApplicants.moddedAlgorithims = []
JobApplicants.getRandomMale = (random) ->
	results = []
	JobApplicants.moddedAlgorithims.forEach (val) ->
		results.push(val.apply(random)) if val.forMale
	results.pickRandom(random)

JobApplicants.getRandomFemale = (random) ->
	results = []
	JobApplicants.moddedAlgorithims.forEach (val) ->
		results.push(val.apply(random)) if not val.forMale
	results.pickRandom(random)

JobApplicants.getFamousMale = (tech, design, random) ->
	results = []
	JobApplicants.moddedFamous.forEach (val) ->
		results.push(val.apply(random, tech, design)) if val.forMale
	results.pickRandom(random)

JobApplicants.getFamousFemale = (tech, design, random) ->
	results = []
	JobApplicants.moddedFamous.forEach (val) ->
		results.push(val.apply(random, tech, design)) if not val.forMale
	results.pickRandom(random)

JobApplicants.searchTests =
	[
		{
			id : "ComplexAlgorithms"
			name : "Complex Algorithms".localize()
			minT : 0.6
		}
		{
			id : "GameDemo"
			name : "Game Demo".localize()
			minD : 0.3,
			minT : 0.3
		}
		{
			id : "Showreel"
			name : "Showreel".localize()
			minD : 0.6
		}
	]
UI.__olgGenerateJobApplicants = UI._generateJobApplicants
UI._generateJobApplicants = ->
	oldApplicants = UI.__olgGenerateJobApplicants()
	settings = GameManager.uiSettings["findStaffData"]
	settings = {ratio : 0.1, tests : []} if not settings
	settings.seed = Math.floor(GameManager.company.getRandom() * 65535) if not settings.seed
	ratio = settings.ratio
	test = JobApplicants.searchTests.first (t) -> t.id is settings.tests.first()
	company = GameManager.company
	random = new MersenneTwister(settings.seed)
	newApplicants = []
	count = Math.floor(2 + 3 * (ratio + 0.2).clamp(0, 1))
	rerolls = 0
	maxRerolls = 2
	maxBonus = if company.currentLevel is 4 then 4 / 5 else 2 / 5
	takenNames = GameManager.company.staff.map (s) -> s.name
	for i in [0...count]
		qBonusFactor = ratio / 3 + (1 - ratio / 3) * random.random()
		maxBonus += 1 / 5 if random.random() >= 0.95
		q = 1 / 5 + maxBonus * qBonusFactor
		level = Math.floor(q * 5).clamp(1,5)
		maxD = 1
		minD = 0
		if test
			maxD -= test.minT if test.minT
			if test.minD
				minD = test.minD
				maxD -= minD
		baseValue = 200 * level
		d = baseValue * minD + baseValue * maxD * random.random()
		t = baseValue - d
		rBonusFactor = random.random()
		r = 1 / 5 + maxBonus * rBonusFactor
		sBonusFactor = random.random()
		s = 1 / 5 + maxBonus * sBonusFactor
		goodRoll = sBonusFactor > 0.5 && (qBonusFactor > 0.5 && rBonusFactor > 0.5)
		if not goodRoll and (rerolls < maxRerolls and random.random() <= (ratio + 0.1).clamp(0, 0.7))
			i--
			rerolls++
			continue
		rerolls = 0
		isFamous = false
		sex = "male"
		loop
			sex = "male"
			if goodRoll
				name = JobApplicants.getFamousMale(t, d, random) if (random.random() > 0.15)
				else
					name = JobApplicants.getFamousFemale(t, d, random)
					sex = "female"
				isFamous = true
			else
				name = JobApplicants.getRandomMale(random) if random.random() > 0.25
				else
					name = JobApplicants.getRandomFemale(random)
					sex = "female"
				isFamous = false
		break unless takenNames.indexOf(name) != -1
		takenNames.push(name)
		salary = Character.BASE_SALARY_PER_LEVEL * level
		salary += salary * 0.2 * random.random() * random.randomSign()
		salary = Math.floor(salary/1e3) * 1e3
		newApplicants.push {
			name : name,
			qualityFactor : q,
			technologyFactor : t / 500,
			designFactor : d / 500,
			researchFactor : r,
			speedFactor : s,
			salary : salary,
			isFamous : isFamous,
			sex : sex
		}
	GDT.fire GameManager, GDT.eventKeys.gameplay.staffApplicantsGenerated, {
		newApplicants : newApplicants
		settings : settings
		rng : random
	}
	applicants = []
	for i in [0...count]
		if random.random() >= 0.5
			a = newApplicants.pickRandom(random)
			applicants.push(a)
			newApplicants.remove(a)
		else
			a = oldApplicants.pickRandom(random)
			applicants.push(a)
			oldApplicants.remove(a)
	return applicants