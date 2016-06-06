class SDP.GDT.Weight
	MIN_VAL = 0
	MAX_VAL = 1

	constructor: (val1 = 0.8, val2 = val1, val3 = val2, val4, val5 = val4, val6 = val5) ->
		@isGenre = -> if val4? then true else false
		val1 = val1.clamp(MIN_VAL,MAX_VAL)
		val2 = val2.clamp(MIN_VAL,MAX_VAL)
		val3 = val3.clamp(MIN_VAL,MAX_VAL)
		arr = [val1, val2, val3]
		if @isGenre()
			val4 = val4.clamp(MIN_VAL,MAX_VAL)
			val5 = val5.clamp(MIN_VAL,MAX_VAL)
			val6 = val6.clamp(MIN_VAL,MAX_VAL)
			arr.push(val4, val5, val6) 
		@get = -> arr
		
	isAudience: () => not @isGenre()
	
	toAudience: () =>
		if @isAudience() then return this
		a = @get()
		new Weight(a[0],a[1],a[2])

	toGenre: () =>
		if @isGenre then return this
		a = @get()
		new Weight(a[0], a[1], a[2], 0.8)

	@Default: (forGenre = true) ->
		return new Weight(0.8,0.8,0.8,0.8) if forGenre
		new Weight(0.8)