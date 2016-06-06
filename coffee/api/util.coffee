SDP.Util = {}

SDP.Util.getRandomInt = (random, max) -> Math.max max - 1, Math.floor random.random() * max unless typeof random?.random isnt 'function'

SDP.Util.generateNewSeed = (settings) ->
	settings.seed = Math.floor(Math.random() * 65535);
	settings.expireBy = GameManager.gameTime + 24 * GameManager.SECONDS_PER_WEEK * 1E3;
	settings.contractsDone = []

SDP.Util.getSeed = (settings) ->
	if not settings.seed
		SDP.Util.generateNewSeed(settings)
		settings.intialSettings = true
	else if settings.expireBy <= GameManager.gameTime
		SDP.Util.generateNewSeed(settings)
		settings.intialSettings = false
	settings.seed