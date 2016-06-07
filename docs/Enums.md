## Enums
Enums in the SDP are considered considered constant enumeratable objects, how the value may be processed into the name is like so:

    capitalize everything
    if contains whitespace then replace with '_'
    if contains '/' then remove character
which means a value of 'This Thing/s' gets named as 'THIS_THINGS'

##### ResearchCategory
* 'Engine'
* 'Gameplay'
* 'Story/Quests'
* 'Dialogs'
* 'Level Design'
* 'AI'
* 'World Design'
* 'Graphic'
* 'Sound'

##### Audience
* 'young'
* 'everyone'
* 'mature'

##### Genre
* 'Action'
* 'Adventure'
* 'RPG'
* 'Simulation'
* 'Strategy'
* 'Casual'
