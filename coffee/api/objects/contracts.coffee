class SDP.GDT.Contract

	constructor: (args...) ->
		if args.length is 1
			obj = args[0]
			@isAvailable = obj.isAvailable
			@isAvailable.bind(this) if @isAvailable?
			if obj instanceof Contract
				@setDescription(obj.description)
				@setDesign(obj.designFactor)
				@setTech(obj.techFactor)
				@setResearch(obj.researchFactor)
			else
				@setDescription(obj.description)
				@setDesign(obj.dF)
				@setTech(obj.tF)
				@setResearch(obj.rF)
		else
			@researchFactor = undefined
			@isAvailable = undefined
			@setDescription(args[3])
			name = args[0]
			@getName = -> name
			@setDesign(args[1])
			@setTech(args[2])

	setDescription: (description) =>
		if description.constructor is String then @description = description
		else if description.constructor is [].constructor and description[0].constructor is String then @description = description.join(" ")

	setDesign: (factor) ->
		if factor.constructor is Number then @designFactor = factor
		else if factor.constructor is [].constructor then @designFactor = factor.sum()

	setTech: (factor) ->
		if factor.constructor is Number then @techFactor = factor
		else if factor.constructor is [].constructor then @techFactor = factor.sum()

	setResearch: (factor) ->
		if factor.constructor is Number then @researchFactor = factor
		else if factor.constructor is [].constructor then @researchFactor = factor.sum()