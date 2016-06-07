## Research
###### Fields
* id - the unique identifier
* name - the player friendly name
* Either:
  * v - the proportion value, must be 1, 2, 4, 6, 8, 10, 12, 14
  * More Control:
    * pointsCost - the cost in research points
    * duration - the amount of time the research will cost
    * engineCost - the cost to place it in an engine
    * enginePoints - the points required to use in an engine
    * devCost - the monetary cost to develop with
    * engineCost - the monetary cost to use in an engine

* category - the category of the research (use the [ResearchCategory](./Enums.md#researchcategory) Enum)
* categoryDisplayName - the category name that appears in engine selection (recommened using category.localize())
* group - the tab name that appears in the phase selection sidebar and console part selection, 'graphic-type' shall act for graphical advancments  (optional, default: category)
* consolePart - whether the research can go into a console (optional, default: false)
* techLevel - the contributing tech level for both engines and consoles (optional, default: undefined [does not get taken into account if undefined])
* showXPGain - whether xp gains will be shown when used (optional, default: false)
* needsEngine - whether the research requires the engine research be gain (optional, default: true)

###### Functions
* canResearch(company) - whether the research can be researched (optional, default: `function{return true;}`)
* canUse(game) - whether the research can be used on a specific game (optional, default: `function{return true;}`)