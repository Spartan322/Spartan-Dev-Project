## Topic
###### Fields
* id - the unique identifier
* name - the player friendly name
* genreWeighting - a six length array of values between 0.6-1 on how effective the topic is for each genre, going Action, Adventure, RPG, Simulation, Strategy, Casual
* audienceWeighting - a three length array of values between 0.6-1 on how effective the topic is for each audience category, going Young, Everyone, Mature
* missionOverrides - overrides for each research category depending on genre, following the default of: 

Genre / Mission | Engine | Gameplay | Story / Quests | Dialogues | Level Design | AI | World Design | Graphics | Sound
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
Action|1|0.9|0.7|0.6|0.9|1|0.8|1|0.9
Adventure|0.7|0.8|1|1|0.8|0.7|1|0.9|0.8
RPG|0.7|0.8|1|1|0.8|0.7|1|0.9|0.8
Simulation|0.9|1|0.8|0.7|0.9|1|0.8|1|0.9
Strategy|0.9|1|0.8|0.7|1|0.9|1|0.8|0.9
Casual|0.6|1|0.7|0.7|1|0.6|0.7|1|0.9