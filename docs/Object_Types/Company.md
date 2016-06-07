## Company
###### Fields
* id - the unique identifier
* name - the player friendly name
* platforms - the array of platforms this company has made
* notPublisher - this company will never be allowed to give publishing contracts

###### Functions
* addPlatform(platform) - adds a platform to the company list and sorts it through, then adds it to the game
* sort() - sorts the platforms based on the publish date