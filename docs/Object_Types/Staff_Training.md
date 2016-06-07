## Staff Training
###### Fields
* id - the unique identifier
* name - the player friendly name
* category - the tab the training is displayed under
* categoryDisplayName - the player friendly name of category
* duration - the amount of ticks required for training to finish
* cost - monentary cost of training (optional)
* pointsCost - RP cost of training (optional)
* isTraining - whether this appears on the training list and is treated as a training object instead of research (optional, default: false)
* isSkillTraining  - whether this is treated as a skill training object with character points list, knowledge storage, and effect display (optional, default: false)
* progressColor - the CSS3 color string which to color the bar (optional, default: blue/green depending on isSkillTraining)
* style - the style of display text, "trainingItemSmall" is the only known type (optional)
* basePoints - base amount of points factors should be able to contribute (optional)
* tF - tech increase factor (optional)
* dF - design increase factor (optional)
* rF - research increase factor (optional)
* sF - speed increase factor (optional)
* qF - quality increase factor (optional)
* maxP - max points any factor can contribute, 10% chance it won't matter (optional)

###### Functions
* canUse(staff, company) - whether the training can be used (optional, default: `return true`)
* canSee(staff, company) - whether training can be seen (optional, default: `return true`)
* tick(character, delta) - triggers ever training tick (optional, requires isTraining = true)
* complete(staff) - triggers on completion of the training