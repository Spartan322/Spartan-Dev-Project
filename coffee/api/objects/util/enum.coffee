###
Usage:
new Enum('name of enum', 'first enum name', 'first enum value', ...)
or
Enum.Generate('name of enum', 'first enum value', 'second enum value', ...)
is equal to
new Enum('name of enum', 'FIRST_ENUM_VALUE', 'first enum value', 'SECOND_ENUM_VALUE', 'second enum value', ...)

You can also access an enum's value by getting its name for example:
enum = Enum.Generate('enum', 'vals', 'vals2')
enum.VALS is now 'vals'
enum. VALS2 is now 'vals2'
###
class SDP.Util.Enum
	consturctor: (name, values...) ->
		@values = []
		for v, i in values
			if v.name? and v.value? then @values.push(v)
			else if i%2 is 0 then @values.push({name: v.toString(), value: undefined}) else @values[@values.length-1].value = v
		@getName = -> name
		Object.defineProperty(this, 'values', { value: @values, enumerable: true })
		for v in @values
			@[v.name] = v.value
	
	get: (indexOrName) => 
		@values[indexOrName] if typeof indexOrName is 'number'
		@values.find((val) -> name is indexOrName) if typeof indexOrName is 'string' 
		
	toArray: =>
		a = []
		a.push e.value for e in @values
		a
		
	toString: =>
		@str if @str?
		str = "Enum #{@getName()}: "
		str += "#{v.name}:#{v.value}, " for v, i in @values when i < @values.length-1
		v = @values[@values.length-1]
		str += "#{v.name}:#{v.value}"
		@str = str
		str
		
	@Generate: (name, values...) ->
		resultVals = []
		for v in values
			resultVals.push(v.toUpperCase().replace("/","").replace(/\s/g,"_"), v)
		new Enum(name, resultVals)
		