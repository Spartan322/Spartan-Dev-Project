SDP.GDT.__notUniqueResearch = (id) -> 
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', Research.getAllItems())

class SDP.GDT.Research

	constructor: (name, id = name) ->
		name = name.localize("research")
		@getName = -> name
		@canResearch = (company) -> true
		@v = undefined
		@category = SDP.Enum.ResearchCategory.ENGINE.value
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
			v: @v
			pointsCost: @pointsCost
			duration: @duration
			cost: @cost
			enginePoints: @enginePoints
			engineCost: @engineCost
			category: @category
			categoryDisplayName: @categoryDisplayName
			group: @group
			complete: @complete
			consolePart: @consolePart
			showXPGain: @showXPGain
		}