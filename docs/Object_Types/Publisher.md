## Publisher
###### Fields
* id - the unique identifier
* name - the player friendly name
* startWeek - the week which the publisher will be available (optional, default: 1/1/1)
* retireWeek - the week which the publisher will be unavailable (doesn't need startWeek, optional, default: 260/12/4)
* ignoreGameLengthModifier - whether the game length modifier shall be taken into account (optional, default: false)

###### Functions
* getGenre(random) - retrieves a specific genre (optional, default: `return General.getAvailableGenres(company).pickRandom(random)`)
* getTopic(random, selectableTopics) - retrieves a specific topic from selectableTopics (optional, default: `return selectableTopics.pickRandom(random)`)
* getPlatform(random, selectablePlatforms) - retrieves a specific platform from selectablePlatforms (optional, default: `return selectablePlatforms.pickRandom(random)`)
* getAudience(random) - retrieves a specific audience (optional, default: `SDP.Enum.Audience.toArray().pickRandom(random)`)