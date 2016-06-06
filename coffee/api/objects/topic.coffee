
SDP.GDT.__notUniqueTopic = (id) -> 
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', Topics.topics)

class SDP.GDT.Topic

	constructor: (name, id = name, @genreWeight = SDP.GDT.Weight.Default(), @audienceWeight = SDP.GDT.Weight.Default(false)) ->
		name = name.localize("topic")
		@getName = -> name
		@missionOverride = []
		for g in SDP.Enum.Genre.toArray()
			cats = []
			for c in SDP.Enum.ResearchCategory
				cats.push(0)
			@missionOverride.push(cats)
		id += '_' while SDP.GDT.__notUniqueTopic(id)
		@getId = -> id
		
	setOverride: (genreName, categoryName, value) =>
		pos = if genreName.constructor is String and categoryName.constructor is String then SDP.GDT.getOverridePositions(genreName, categoryName) else [genreName, categoryName]
		if 0 <= pos[0] <= @missionOverride.length and 0 <= pos[1] <= @missionOverride[pos[0]].length
			@missionOverride[pos[0]][pos[1]] = value
			
	toInput: =>
		{
			id: @getId()
			name: @getName()
			genreWeightings: @genreWeight unless @genreWeight instanceof SDP.GDT.Weight then @genreWeight.toGenre().get()
			audienceWeightings: @audienceWeight unless @audienceWeight instanceof SDP.GDT.Weight then @audienceWeight.toAudience().get()
			missionOverrides: @missionOverride
		}
		
	add: =>
		SDP.GDT.addTopic(@toInput)