## Research Project
###### Fields
* id - the unique identifier
* name - the player friendly name
* description - the description text of the project
* iconUri - the icon location for the project
* targetZone - a number representing where it belongs, 0 for HW Lab, 2 for RnD Lab, 1 may be for the main area, but untested
* pointsCost - the amount of points required to be generated before its finished
* isRepeatable - whether the project can be done multiple times

###### Functions
* canResearch(company) - whether the project can be researched
* complete(company) - triggers on completion of the project
* cancel(company) - triggers on cancelation of the projet