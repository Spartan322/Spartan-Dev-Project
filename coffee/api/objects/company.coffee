class SDP.GDT.Company
	@companies: new SDP.Util.Map
	
	getName: -> ""
	
	loadConsoles = (company) ->
		if Platforms.allPlatforms.indexOf((val) -> val.company is company.getName()) isnt -1
			company.platforms.push Platforms.allPlatforms.filter (val) -> val.company is company.getName()
	
	@getCompany: (name) ->
		c = Company.companies.get(name)
		return c if c?
		c = new Company
		c.getName = -> name
		c.platforms = []
		loadConsoles(c)
		Company.companies.add(c)
		c
	
	@MIRCONOFT = @getCompany("Micronoft")
	#@GREENHEART = @getCompany("Greenheart Games") # Normally doesn't exist, does this meet mod compliance?
	@GRAPPLE = @getCompany("Grapple")
	@GOVADORE = @getCompany("Govodore")
	@NINVENTO = @getCompany("Ninvento")
	@VENA = @getCompany("Vena")
	@VONNY = @getCompany("Vonny")
	@KICKIT = @getCompany("KickIT")		
		
	addPlatform: (platform) =>
		if @platforms.findIndex((val) -> platform.getId() is val.getId()) is -1
			platform.company = this
			@platforms.push(platform.add())
			
	getPlatform: (name) =>
		return @platforms.find((val) -> platform.name is name)
		
	toString: => @getName()