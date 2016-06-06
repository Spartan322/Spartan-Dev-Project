-###
Normal Research in a company

###################
# GDT Members 
###################

getName() getter that retrieves the name of the research

canResearch(company) determines whether the research can be researched

v is the multiplier for all the costs and values (takes precedence, replaces pointsCost, duration, cost, enginePoints, engineCost)

category is the name of the represented category

categoryDisplayName is the display name from the list for it to be selected

pointsCost is the amount of points it would cost to do the research (replaces v)

duration is the length the research will take to finish (replaces v)

cost is the finacial cost of the research (replaces v)

enginePoints is the points required for the research (replaces v)

engineCost is the cost to allow the research in the engine (replaces v)

canUse(game) whether the research can currently be usedIds

complete() is returned once the research is complete

consolePart determines whether the research can apply to consoles, by default it returns false

showXPGain determines whether using the research allows visible xp gain

###################
# Non-GDT Members
###################

toInput() retrieves an ambigious object representing the input

add() adds the object to the usable research list through a reimplemented SDP.GDT.addResearchItem

###
	
SDP.GDT.__notUniqueResearch = (id) -> 
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', Research.getAllItems())

class SDP.GDT.Research

	constructor: (name, id = name) ->
		name = name.localize("research")
		@getName = -> name
		@canResearch = (company) -> true
		@v = undefined
		@category = SDP.Enum.ResearchCategory.ENGINE
		@categoryDisplayName = @category.localize()
		@pointsCost = 0
		@duration = 0
		@cost = 0
		@enginePoints = 0
		@engineCost = 0
		@group = undefined
		@canUse = (game) -> true
		@complete = ->
		@consolePart = false
		@showXPGain = true
		id += '_' while SDP.GDT.__notUniqueResearch(id)
		@getId = -> id
		
	toInput: =>
		{
			id: @getId()
			name: @getName()
			canResearch: @canResearch
			canUse: @canUse
			v: if v? then @v else false
			pointsCost: @pointsCost
			duration: @duration
			cost: @cost
			enginePoints: @enginePoints
			engineCost: @engineCost
			category: @category
			categoryDisplayName: @categoryDisplayName
			group: @group if @group?
			complete: @complete
			consolePart: @consolePart if @consolePart? else false
			showXPGain: @showXPGain if @showXPGain? else true
		}
		
	add: =>
		SDP.GDT.addResearchItem(@toInput())