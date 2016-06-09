class SDP.GDT.Company

	constructor: (name, id = name.replace(/\s/g,"")) ->
		c = Companies.getAllCompanies().find (val) -> val.id is id
		c = Companies.createCompany({name: name, id: id}) unless c?
		@platforms = c.platforms
		@addPlatform = c.addPlatform
		@addPlatform.bind(@)
		@sort = c.sort
		@sort.bind(@)
		name = c.name
		@getName = -> name
		id = c.id
		@getId = -> id

	getPlatform: (name) =>
		p = @platforms.find((val) -> platform.name is name)
		p = @platforms.find((val) -> platform.id is name) unless p?
		p

	toString: => @getName()