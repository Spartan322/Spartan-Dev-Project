SDP = {}
Companies = {}
JobApplicants = {}
SDP.Util = {}

###
UTIL OBJS
###
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

class SDP.Util.Map
	constructor: (@origArr...) ->
		@nameArray = []
		@map = {}
		for obj in @origArr
			@add(obj)

	add: (obj, getterName = "getName") =>
		if typeof obj[getterName] is 'function'
			@addByName(obj[getterName](), obj)
		else if typeof obj.toString is 'function'
			@addByName(obj.toString(), obj)

	addByName: (name, obj) =>
		name = String(name)
		@map[name] = obj
		@nameArray.push(name)

	get: (name) =>
		@map[String(name)]

	containsKey: (name) =>
		@map[String(name)]?

	containsVal: (val) =>
		for obj in @map
			return true if obj is val
		return false

	toArray: =>
		a = @cachedArray.slice(0)
		a.push(@get(n)) for n in @nameArray when a.indexOf(@get(n)) is -1
		@cachedArray = a.slice(0)
		a


###
jSTORAGE
###
`(function(){function C(){var a="{}";if("userDataBehavior"==f){g.load("jStorage");try{a=g.getAttribute("jStorage")}catch(b){}try{r=g.getAttribute("jStorage_update")}catch(c){}h.jStorage=a}D();x();E()}function u(){var a;clearTimeout(F);F=setTimeout(function(){if("localStorage"==f||"globalStorage"==f)a=h.jStorage_update;else if("userDataBehavior"==f){g.load("jStorage");try{a=g.getAttribute("jStorage_update")}catch(b){}}if(a&&a!=r){r=a;var l=p.parse(p.stringify(c.__jstorage_meta.CRC32)),k;C();k=p.parse(p.stringify(c.__jstorage_meta.CRC32));
var d,n=[],e=[];for(d in l)l.hasOwnProperty(d)&&(k[d]?l[d]!=k[d]&&"2."==String(l[d]).substr(0,2)&&n.push(d):e.push(d));for(d in k)k.hasOwnProperty(d)&&(l[d]||n.push(d));s(n,"updated");s(e,"deleted")}},25)}function s(a,b){a=[].concat(a||[]);var c,k,d,n;if("flushed"==b){a=[];for(c in m)m.hasOwnProperty(c)&&a.push(c);b="deleted"}c=0;for(d=a.length;c<d;c++){if(m[a[c]])for(k=0,n=m[a[c]].length;k<n;k++)m[a[c]][k](a[c],b);if(m["*"])for(k=0,n=m["*"].length;k<n;k++)m["*"][k](a[c],b)}}function v(){var a=(+new Date).toString();
if("localStorage"==f||"globalStorage"==f)try{h.jStorage_update=a}catch(b){f=!1}else"userDataBehavior"==f&&(g.setAttribute("jStorage_update",a),g.save("jStorage"));u()}function D(){if(h.jStorage)try{c=p.parse(String(h.jStorage))}catch(a){h.jStorage="{}"}else h.jStorage="{}";z=h.jStorage?String(h.jStorage).length:0;c.__jstorage_meta||(c.__jstorage_meta={});c.__jstorage_meta.CRC32||(c.__jstorage_meta.CRC32={})}function w(){if(c.__jstorage_meta.PubSub){for(var a=+new Date-2E3,b=0,l=c.__jstorage_meta.PubSub.length;b<
l;b++)if(c.__jstorage_meta.PubSub[b][0]<=a){c.__jstorage_meta.PubSub.splice(b,c.__jstorage_meta.PubSub.length-b);break}c.__jstorage_meta.PubSub.length||delete c.__jstorage_meta.PubSub}try{h.jStorage=p.stringify(c),g&&(g.setAttribute("jStorage",h.jStorage),g.save("jStorage")),z=h.jStorage?String(h.jStorage).length:0}catch(k){}}function q(a){if("string"!=typeof a&&"number"!=typeof a)throw new TypeError("Key name must be string or numeric");if("__jstorage_meta"==a)throw new TypeError("Reserved key name");
return!0}function x(){var a,b,l,k,d=Infinity,n=!1,e=[];clearTimeout(G);if(c.__jstorage_meta&&"object"==typeof c.__jstorage_meta.TTL){a=+new Date;l=c.__jstorage_meta.TTL;k=c.__jstorage_meta.CRC32;for(b in l)l.hasOwnProperty(b)&&(l[b]<=a?(delete l[b],delete k[b],delete c[b],n=!0,e.push(b)):l[b]<d&&(d=l[b]));Infinity!=d&&(G=setTimeout(x,Math.min(d-a,2147483647)));n&&(w(),v(),s(e,"deleted"))}}function E(){var a;if(c.__jstorage_meta.PubSub){var b,l=A,k=[];for(a=c.__jstorage_meta.PubSub.length-1;0<=a;a--)b=
c.__jstorage_meta.PubSub[a],b[0]>A&&(l=b[0],k.unshift(b));for(a=k.length-1;0<=a;a--){b=k[a][1];var d=k[a][2];if(t[b])for(var n=0,e=t[b].length;n<e;n++)try{t[b][n](b,p.parse(p.stringify(d)))}catch(g){}}A=l}}var y=window.jQuery||window.$||(window.$={}),p={parse:window.JSON&&(window.JSON.parse||window.JSON.decode)||String.prototype.evalJSON&&function(a){return String(a).evalJSON()}||y.parseJSON||y.evalJSON,stringify:Object.toJSON||window.JSON&&(window.JSON.stringify||window.JSON.encode)||y.toJSON};if("function"!==
typeof p.parse||"function"!==typeof p.stringify)throw Error("No JSON support found, include //cdnjs.cloudflare.com/ajax/libs/json2/20110223/json2.js to page");var c={__jstorage_meta:{CRC32:{}}},h={jStorage:"{}"},g=null,z=0,f=!1,m={},F=!1,r=0,t={},A=+new Date,G,B={isXML:function(a){return(a=(a?a.ownerDocument||a:0).documentElement)?"HTML"!==a.nodeName:!1},encode:function(a){if(!this.isXML(a))return!1;try{return(new XMLSerializer).serializeToString(a)}catch(b){try{return a.xml}catch(c){}}return!1},
decode:function(a){var b="DOMParser"in window&&(new DOMParser).parseFromString||window.ActiveXObject&&function(a){var b=new ActiveXObject("Microsoft.XMLDOM");b.async="false";b.loadXML(a);return b};if(!b)return!1;a=b.call("DOMParser"in window&&new DOMParser||window,a,"text/xml");return this.isXML(a)?a:!1}};y.jStorage={version:"0.4.12",set:function(a,b,l){q(a);l=l||{};if("undefined"==typeof b)return this.deleteKey(a),b;if(B.isXML(b))b={_is_xml:!0,xml:B.encode(b)};else{if("function"==typeof b)return;
b&&"object"==typeof b&&(b=p.parse(p.stringify(b)))}c[a]=b;for(var k=c.__jstorage_meta.CRC32,d=p.stringify(b),g=d.length,e=2538058380^g,h=0,f;4<=g;)f=d.charCodeAt(h)&255|(d.charCodeAt(++h)&255)<<8|(d.charCodeAt(++h)&255)<<16|(d.charCodeAt(++h)&255)<<24,f=1540483477*(f&65535)+((1540483477*(f>>>16)&65535)<<16),f^=f>>>24,f=1540483477*(f&65535)+((1540483477*(f>>>16)&65535)<<16),e=1540483477*(e&65535)+((1540483477*(e>>>16)&65535)<<16)^f,g-=4,++h;switch(g){case 3:e^=(d.charCodeAt(h+2)&255)<<16;case 2:e^=
(d.charCodeAt(h+1)&255)<<8;case 1:e^=d.charCodeAt(h)&255,e=1540483477*(e&65535)+((1540483477*(e>>>16)&65535)<<16)}e^=e>>>13;e=1540483477*(e&65535)+((1540483477*(e>>>16)&65535)<<16);k[a]="2."+((e^e>>>15)>>>0);this.setTTL(a,l.TTL||0);s(a,"updated");return b},get:function(a,b){q(a);return a in c?c[a]&&"object"==typeof c[a]&&c[a]._is_xml?B.decode(c[a].xml):c[a]:"undefined"==typeof b?null:b},deleteKey:function(a){q(a);return a in c?(delete c[a],"object"==typeof c.__jstorage_meta.TTL&&a in c.__jstorage_meta.TTL&&
delete c.__jstorage_meta.TTL[a],delete c.__jstorage_meta.CRC32[a],w(),v(),s(a,"deleted"),!0):!1},setTTL:function(a,b){var l=+new Date;q(a);b=Number(b)||0;return a in c?(c.__jstorage_meta.TTL||(c.__jstorage_meta.TTL={}),0<b?c.__jstorage_meta.TTL[a]=l+b:delete c.__jstorage_meta.TTL[a],w(),x(),v(),!0):!1},getTTL:function(a){var b=+new Date;q(a);return a in c&&c.__jstorage_meta.TTL&&c.__jstorage_meta.TTL[a]?(a=c.__jstorage_meta.TTL[a]-b)||0:0},flush:function(){c={__jstorage_meta:{CRC32:{}}};w();v();s(null,
"flushed");return!0},storageObj:function(){function a(){}a.prototype=c;return new a},index:function(){var a=[],b;for(b in c)c.hasOwnProperty(b)&&"__jstorage_meta"!=b&&a.push(b);return a},storageSize:function(){return z},currentBackend:function(){return f},storageAvailable:function(){return!!f},listenKeyChange:function(a,b){q(a);m[a]||(m[a]=[]);m[a].push(b)},stopListening:function(a,b){q(a);if(m[a])if(b)for(var c=m[a].length-1;0<=c;c--)m[a][c]==b&&m[a].splice(c,1);else delete m[a]},subscribe:function(a,
b){a=(a||"").toString();if(!a)throw new TypeError("Channel not defined");t[a]||(t[a]=[]);t[a].push(b)},publish:function(a,b){a=(a||"").toString();if(!a)throw new TypeError("Channel not defined");c.__jstorage_meta||(c.__jstorage_meta={});c.__jstorage_meta.PubSub||(c.__jstorage_meta.PubSub=[]);c.__jstorage_meta.PubSub.unshift([+new Date,a,b]);w();v()},reInit:function(){C()},noConflict:function(a){delete window.$.jStorage;a&&(window.jStorage=this);return this}};(function(){var a=!1;if("localStorage"in
window)try{window.localStorage.setItem("_tmptest","tmpval"),a=!0,window.localStorage.removeItem("_tmptest")}catch(b){}if(a)try{window.localStorage&&(h=window.localStorage,f="localStorage",r=h.jStorage_update)}catch(c){}else if("globalStorage"in window)try{window.globalStorage&&(h="localhost"==window.location.hostname?window.globalStorage["localhost.localdomain"]:window.globalStorage[window.location.hostname],f="globalStorage",r=h.jStorage_update)}catch(k){}else if(g=document.createElement("link"),
g.addBehavior){g.style.behavior="url(#default#userData)";document.getElementsByTagName("head")[0].appendChild(g);try{g.load("jStorage")}catch(d){g.setAttribute("jStorage","{}"),g.save("jStorage"),g.load("jStorage")}a="{}";try{a=g.getAttribute("jStorage")}catch(m){}try{r=g.getAttribute("jStorage_update")}catch(e){}h.jStorage=a;f="userDataBehavior"}else{g=null;return}D();x();"localStorage"==f||"globalStorage"==f?"addEventListener"in window?window.addEventListener("storage",u,!1):document.attachEvent("onstorage",
u):"userDataBehavior"==f&&setInterval(u,1E3);E();"addEventListener"in window&&window.addEventListener("pageshow",function(a){a.persisted&&u()},!1)})()})()`

###
CORE
###
"use strict"
###
Enums: enumerable objects
###
SDP.Enum = {}

SDP.Enum.ResearchCategory = SDP.Util.Enum.Generate('ResearchCategory',
'Engine',
'Gameplay',
'Story/Quests',
'Dialogs',
'Level Design',
'AI',
'World Design',
'Graphic',
'Sound')

SDP.Enum.Audience = SDP.Util.Enum.Generate('Audience',
'young',
'everyone',
'mature')

SDP.Enum.Genre = SDP.Util.Enum.Generate('Genre',
'Action',
'Adventure',
'RPG',
'Simulation',
'Strategy',
'Casual')

###
Addition Functions: adds basic game objects
###
SDP.GDT = {}

SDP.GDT.addResearchItem = (item) ->
	item = item.toInput() if SDP.GDT.Research? and item instanceof SDP.GDT.Research
	if item.v? then GDT.addResearchItem(item) else
		Research.engineItems.push(item) if Checks.checkPropertiesPresent(item, ['id', 'name', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Research.getAllItems())
	return

SDP.GDT.addPlatform = (item) ->
	item = item.toInput() if SDP.GDT.Platform? and item instanceof SDP.GDT.Platform
	if item.iconUri? then GDT.addPlatform(item) else
		if Checks.checkPropertiesPresent(item, ['id', 'name', 'company', 'startAmount', 'unitsSold', 'licencePrize', 'published', 'platformRetireDate', 'developmentCosts', 'genreWeightings', 'audienceWeightings', 'techLevel', 'baseIconUri', 'imageDates']) and Checks.checkUniqueness(item, 'id', Platforms.allPlatforms) and Checks.checkAudienceWeightings(item.audienceWeightings) and Checks.checkGenreWeightings(item.genreWeightings) and Checks.checkDate(item.published) and Checks.checkDate(item.platformRetireDate)
			if item.marketPoints then for point in item.marketPoints
				return unless Checks.checkDate(point.date)
			if Checks.checkUniqueness(item.name, 'name', Companies.getAllCompanies())
				SDP.GDT.addCompany(item.name).addPlatform(item)
			else Platforms.allPlatforms.push(item)
			if item.events then for event of item.events
				GDT.addEvent(event) unless event instanceof SDP.GDT.Event then event.add()
	return

SDP.GDT.addTopic = (item) ->
	item = item.toInput() if SDP.GDT.Topic? and item instanceof SDP.GDT.Topic
	item.genreWeightings = item.genreWeightings.toGenre().get() if SDP.GDT.Weight? and item.genreWeightings instanceof SDP.GDT.Weight
	item.audienceWeightings = item.audienceWeightings.toAudience().get() if SDP.GDT.Weight? and item.audienceWeightings instanceof SDP.GDT.Weight
	GDT.addTopic(item)

SDP.GDT.addResearchProject = (item) ->
	item = item.toInput() if SDP.GDT.ResearchProject? and item instanceof SDP.GDT.ResearchProject
	item.canResearch = ((company)->true) unless item.canResearch?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'iconUri', 'description', 'targetZone']) and Checks.checkUniqueness(item, 'id', Research.bigProjects)
		Research.bigProjects.push(item)
	return

SDP.GDT.triggerNotification = (item) ->
	item.header = '?' unless item.header?
	item.text = '?' unless item.text?
	if not item instanceof Notification
		item = new Notification {
			header: item.header ? '?'
			text: item.text ? '?'
			buttonText: item.buttonText
			weeksUntilFired: item.weeksUntilFired
			image: item.image
			options: item.options.slice(0, 3)
			sourceId: item.sourceId
		}
	if GameManager?.company?.notifications? then GameManager.company.notifications.push(item) else SDP.GDT.Internal.notificationsToTrigger.push(item)

SDP.GDT.addEvent = (item) ->
	item = item.getEvent() if item.getEvent?
	item = item.event if item.event?
	item = item.toInput() if SDP.GDT.Event? and item instanceof SDP.GDT.Event
	item.notification = item.notification.toInput() if SDP.GDT.Notification? and item.notification instanceof SDP.GDT.Notification
	GDT.addEvent(item)

SDP.GDT.addCompany = (item) ->
	if item.constructor is String then item = Companies.createCompany(item)
	item = item.toInput() if SDP.GDT.Company? and item instanceof SDP.GDT.Company
	item.sort = ->
		item.platforms.sort (a,b) ->
			General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
	item.addPlatform = (platform) ->
		platform.company = item.name
		SDP.GDT.addPlatform(platform)
		item.platforms.push(platform)
		item.sort()
		platform
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', Companies.getAllCompanies())
		Companies.moddedCompanies.push(item)
	return item

###
GDT Utility: Functions which are for utility of GDT
###
SDP.GDT.getOverridePositions = (genre, category) ->
	genre = genre.replace(/\s/g, "")
	category = category.replace(/\s/g, "")
	for g, i in SDP.Enum.Genre.toArray()
		if genre is g
			for c, ci in SDP.Enum.ResearchCategory.toArray()
				if c is category then return [i, ci]
			break
	return undefined

###
Adds company tracking system
###
Companies.createCompany = (item) ->
	if item.constructor is String then item = {name: item}
	if not item.id? and item.name? then item.id = name.replace(/\s/g,"")
	item.platforms = []
	item.platforms.push(p) for p of Platforms.allPlatforms when p.company is item.name
	item.sort = ->
		item.platforms.sort (a,b) ->
			General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
	item.addPlatform = (platform) ->
		return if item.platforms.find((val) -> platform.id is val.id)?
		platform.company = item.name
		SDP.GDT.addPlatform(platform)
		item.platforms.push(platform)
		item.sort()
		platform
	item.sort()
	item
Companies.createVanillaCompany = (item) ->
	Companies.createCompany(item)
	item.isVanilla = true
	item
Companies.vanillaCompanies = [
	Companies.createVanillaCompany("Micronoft")
	Companies.createVanillaCompany("Grapple")
	Companies.createVanillaCompany("Govodore")
	Companies.createVanillaCompany("Ninvento")
	Companies.createVanillaCompany("Vena")
	Companies.createVanillaCompany("Vonny")
	Companies.createVanillaCompany("KickIT")
]
Companies.moddedCompanies = []
Companies.getAllCompanies = ->
	c = Companies.vanillaCompanies.filter (val) -> val.id?
	c.addRange(Companies.moddedCompanies.filter (val) -> val.id?)
	for comp of c
		comp.sort = ->
			comp.platforms.sort (a,b) ->
				General.getWeekFromDateString(a.published) - General.getWeekFromDateString(b.published)
		comp.sort()
	c.sort (a,b) ->
		General.getWeekFromDateString(a.platforms[0].published) - General.getWeekFromDateString(b.platforms[0].published)
	c
Companies.getAvailableCompanies = (company) ->
	week = Math.floor(company.currentWeek)
	Companies.getAllCompanies().filter (val) ->
		General.getWeekFromDateString(val.platforms[0].published) <= week

###
UTIL
###
SDP.Util = {}

SDP.Util.getRandomInt = (random, max) -> Math.max max - 1, Math.floor random.random() * max unless typeof random?.random isnt 'function'

SDP.Util.generateNewSeed = (settings) ->
	settings.seed = Math.floor(Math.random() * 65535);
	settings.expireBy = GameManager.gameTime + 24 * GameManager.SECONDS_PER_WEEK * 1e3;
	settings.contractsDone = []

SDP.Util.getSeed = (settings) ->
	if not settings.seed
		SDP.Util.generateNewSeed(settings)
		settings.intialSettings = true
	else if settings.expireBy <= GameManager.gameTime
		SDP.Util.generateNewSeed(settings)
		settings.intialSettings = false
	settings.seed

###
LOG
###
###
Implements the log functionality of UltimateLib, allows easy conversion from UltimateLib
###
SDP.Logger = ((s) ->

	toTimeStr = (date) ->
		forceZero = (n) -> if n >= 0 and n < 10 then "0" + e else e + ""
		return [
			[
				forceZero date.getFullYear()
				forceZero date.getMonth()+1
				date.getDate()
			].join("-")
			[
				forceZero date.getHours()
				forceZero date.getMinutes()
				forceZero date.getSeconds()
			].join(":")
		].join(" ")

	s.enabled = false

	s.log = (e, c) ->
		return if not s.enabled
		timestamp = toTimeStr(new Date())
		str = ""
		str = if c? then "#{timestamp} : Error! #{e}\n #{c.message}" else "#{timestamp} : #{e}"
		console.log(str)

	s
)(SDP.Logger or {})
	
###
STORAGE
###
###
Implements the jStorage functionality of UltimateLib, allows easy conversion from UltimateLib
###
SDP.Storage = ((s)->

	log = SDP.Logger.log

	s.read = (storeName, defaultVal) ->
		try
			log "SDP.Storage.read Started from localStorage with ID SPD.Storage.#{f}"
			if s.getStorageFreeSize()
				if defaultVal? then $.jStorage.get("SDP.Storage."+storeName, defaultVal) else $.jStorage.get("SDP.Storage."+storeName)
		catch e
			log "SDP.Storage.read Local storage error occured. Error: #{e.message}"
			false

	s.write = (storeName, val, options) ->
		return if not s.getStorageFreeSize()
		try
			if options? then $.jStorage.set("SDP.Storage."+storeName, val, {TTL: options}) else $.jStorage.set("SDP.Storage."+storeName)
			log "SDP.Storage.write Local storage successful at ID SDP.Storage.#{f}"
		catch e
			log "SDP.Storage.write Local storage error occured! Error: #{e.message}"
			false

	s.clearCache = -> $.jStorage.flush()

	s.getAllKeys = -> $.jStorage.index()

	s.getStorageSize = -> $.jStorage.storageSize()

	s.getStorageFreeSize = -> $.jStorage.storageAvailable()

	s.reload = -> $.jStorage.reInit()

	s.onKeyChange = (front, back, func) -> $.jStorage.listenKeyChange("SDP.Storage." + front + "." + back, func)

	s.removeListeners = (front, back, func) -> if func? then $.jStorage.stopListening("SDP.Storage." + front + "." + back, func) else $.jStorage.stopListening("SDP.Storage." + front + "." + back)

	s
)(SDP.Storage or {})
####
GRAPHICAL
####
###
Implements many common graphical functionalities of UltimateLib, allows easy conversion from UltimateLib
###
SDP.Graphical = ((s) ->

	s.Elements = ((e) ->
		e.Head = $("head")
		e.Body = $("body")
		e.SettingsPanel = $("#settingsPanel")
		e.GameContainerWrapper = $("#gameContainerWrapper")
		e.SimpleModalContainer = $("#simplemodal-container")
		e
	)(s.Elements or {})

	s.Visuals = ((v) ->
		v.Custom = ((c) ->
			vis = "SDP-Visuals-Custom"
			c.setCss = (id, content) ->
				id = vis+id
				$("head").append('<style id="#{e}" type="text/css"></style>') if $("##{id}").length is 0
				$("head").find("##{id}").append(content)

			c.addCss = (id, content) ->
				id = vis+id;
				$("head").append('<style id="#{e}" type="text/css"></style>') if $("##{id}").length is 0
				$("head").find("##{id}").html(content);
			c
		)(v.Custom or {})

		v
	)(s.Visuals or {})

	panelChildren = s.Elements.SettingsPanel.children()
	div = $ document.createElement("div")
	div.attr("id", "SDPConfigurationTabs")
	div.css { width: "100%", height: "auto"}
	sdpElement = $ document.createElement("sdp")
	sdpElement.attr("id", "SDPConfigurationTabsList")
	sdpElement.append('<li><a href="#SDPConfigurationDefaultTabPanel">Game</a></li>')
	div2 = $(document.createElement("div"))
	div2.attr("id", "SDPConfigurationDefaultTabPanel")
	sdpElement.appendTo(div)
	div2.appendTo(div)
	panelChildren.appendTo(div.find("#SDPConfigurationDefaultTabPanel").first())
	div.appendTo(SDP.Graphical.Elements.SettingsPanel)
	div.tabs()
	div.find(".ui-tabs .ui-tabs-nav li a").css { fontSize: "7pt" }
	SDP.Graphical.Visuals.Custom.setCss("advanceOptionsCss", "#newGameView .featureSelectionPanel { overflow-x: none overflow-y: auto }</style>")
	SDP.Graphical.Visuals.Custom.setCss("settingPanelCss", ".ui-dialog .ui-dialog-content { padding: .5em 1em 1em .5em overflow-x: none overflow-y: visible }")

	a.setLayoutCss = (modName) ->
		b = $ 'link[href$="layout.css"]'
		b.attr("href", ".mods/#{modName}/css/layout.css")

	s.addTab = (tabId, category, content) ->
		div = $ document.createElement("div")
		div.attr { id: tabId }
		div.css {width: "100%", height: "auto", display: "block"}
		div2 = $ document.createElement("div")
		div2.attr "id", "#{tabId}Container"
		div.append(div2)
		div2.append(content)
		configTabs = $ "SDPConfigurationTabs"
		configTabs.tabs("add", "##{tabId}", category)
		configTabs.tabs("refresh")
		configTabs.tabs("select", 0)
		$("##{tabId}").append(b)
		div

	s.addAdvancedOption = (content) ->
		selection = $("#newGameView").find(".featureSelectionPanel.featureSelectionPanelHiddenState")
		selection.append(content)

	s
)(SDP.Graphical or {})

###
PATCHES
###
###
Functions which require patches
###
SDP.GDT.addTraining = (item) ->
	item = item.toInput() if SDP.GDT.Training? and item instanceof SDP.GDT.Training
	item.pointsCost = 0 unless item.pointsCost?
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'duration', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Training.getAllTraining())
		Training.moddedTraining(item)
	return

SDP.GDT.addPublisher = (item) ->
	item = item.toInput() if SDP.GDT.Publisher? and item instanceof SDP.GDT.Publisher
	return if not Checks.checkUniqueness(item, 'id', Companies.getAllCompanies())
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', ProjectContracts.getAllPublishers())
		ProjectContracts.moddedPublishers.push(item)
	return

SDP.GDT.addContract = (item) ->
	item = item.toInput() if SDP.GDT.Contract? and item instanceof SDP.GDT.Contract
	if Checks.checkPropertiesPresent(item, ['name', 'description', 'dF', 'tF'])
		ProjectContracts.moddedContracts.push(item)
	return

SDP.GDT.addReviewer = (item) ->
	if item.constructor is String then item = {id: item.replace(/\s/g,""), name: item}
	item = item.toInput() if SDP.GDT.Reviewer? and item instanceof SDP.GDT.Reviewer
	if Checks.checkPropertiesPresent(item, ['id', 'name']) and Checks.checkUniqueness(item, 'id', Reviews.getAllReviewers())
		Reviews.moddedReviewers.push(item)
	return

SDP.GDT.addReviewMessage = (item) ->
	if item.constructor is String then item = {message: item, isRandom: true}
	if item.message or item.getMessage
		Reviews.moddedMessages.push(item)
	return

SDP.GDT.addApplicantFunctor = (item) ->
	if Checks.checkPropertiesPresent(item, ['apply', 'forMale']) and typeof apply is "function"
		JobApplicants.moddedAlgorithims.push(item)
	return

SDP.GDT.addFamousFunctor = (item) ->
	if Checks.checkPropertiesPresent(item, ['apply', 'forMale']) and typeof apply is "function"
		JobApplicants.moddedFamous.push(item)
	return

###
#
# Patches: improves game modularbility and performance and kills bugs
# Should force patches on mod load
#
###
SDP.GDT.Internal = {}
SDP.GDT.Internal.notificationsToTrigger = []

###
Triggers all notifications in the case they couldn't be triggered before (ie: before the GameManager.company.notification existed
###
GDT.on(GDT.eventKeys.saves.loaded, ->
	GameManager.company.notifications.push(i) for i in SDP.GDT.Internal.notificationsToTrigger
	SDP.GDT.Internal.notificationsToTrigger = [])
GDT.on(GDT.eventKeys.saves.newGame, ->
	GameManager.company.notifications.push(i) for i in SDP.GDT.Internal.notificationsToTrigger
	SDP.GDT.Internal.notificationsToTrigger = [])

###
Allows new platforms to incorporate different images based on the date
###
Platforms._oldGetPlatformImage = Platforms.getPlatformImage
Platforms.getPlatformImage = (platform, week) ->
	if platform.id is 'PC' then return Platforms._oldGetPlatformImage(platform, week)
	if not platform.imageDates? or not platform.baseIconUri? then return platform.iconUri
	baseUri = platform.baseIconUri
	image = null
	if week and platform.imageDates.constructor is Array
		image = "{0}/{1}-{2}.png".format(baseUri, platform.id, String(i+1)) for date, i in platform.imageDates when General.getWeekFromDateString(date) <= week and i isnt 0
	image = "{0}/{1}.png".format(baseUri, platform.id) unless image?
	return image
###
Forces getAllTraining to include modded training
###
Training._oldGetAllTraining = Training.getAllTraining
Training.moddedTraining = []
Training.getAllTraining = ->
	trainings = Training._oldGetAllTraining()
	for modT in Training.moddedTraining when modT.id? and modT.isTraining # provide more expected behavior
		trainings.push(modT)
	return

###
Adds features to the publisher contracts which determine how they act
Also allows low chance for platform company to randomly give a publisher contract
###
ProjectContracts.createPublisher = (item, id) ->
	if item.constructor is String then item = {name: item}
	if id? then item.id = id
	if not item.id? and item.name? then item.id = name.replace(/\s/g,"")
	item
ProjectContracts.vanillaPublishers = [
	ProjectContracts.createPublisher("Active Visionaries")
	ProjectContracts.createPublisher("Electronic Mass Productions", "ea")
	ProjectContracts.createPublisher("Rockville Softworks")
	ProjectContracts.createPublisher("Blue Bit Games")
	ProjectContracts.createPublisher("CapeCom")
	ProjectContracts.createPublisher("Codemeisters")
	ProjectContracts.createPublisher("Deep Platinum")
	ProjectContracts.createPublisher("Infro Games")
	ProjectContracts.createPublisher("LoWood Productions")
	ProjectContracts.createPublisher("TGQ")
	ProjectContracts.createPublisher("\u00dcberSoft")
]
ProjectContracts.moddedPublishers = []
ProjectContracts.publisherContracts.__oldGetContract = ProjectContracts.publisherContracts.getContract
ProjectContracts.getAllPublishers = ->
	results = ProjectContracts.vanillaPublishers.filter (val) -> val.id?
	results.push(ProjectContracts.moddedPublishers.filter (val) -> val.id?)
	results
ProjectContracts.getAvailablePublishers = (company) ->
	week = Math.floor(company.currentWeek)
	ProjectContracts.getAllPublishers().filter((val) ->
		return (not val.startWeek? or week > General.getWeekFromDateString(val.startWeek, val.ignoreGameLengthModifier)) and (not val.retireWeek? or val.retireWeek is '260/12/4' or week < General.getWeekFromDateString(val.retireWeek, val.ignoreGameLengthModifier))
	)
ProjectContracts.getPublishingCompanies = (company) ->
	c = Companies.getAllCompanies(company).filter (val) -> val.notPublisher? and not val.notPublisher
	c.forEach (val) -> val.isCompany = true
	c

SDP.GDT.Internal.getGenericContractsSettings = (company, type) ->
	key = "contracts#{type}"
	settings = company.flags[key]
	if not settings
		settings = {id: key}
		company.flags[key] = settings
	settings

SDP.GDT.Internal.generatePublisherContracts = (company, settings, maxNumber) ->
	contracts = []
	seed = settings.seed
	random = new MersenneTwister(SDP.Util.getSeed(settings))
	if settings.seed isnt seed
		settings.topic = undefined
		settings.researchedTopics = undefined
		settings.excludes = undefined
		settings.platforms = undefined
	if not settings.topics or not settings.researchedTopics or not settings.platforms
		topics = company.topics.slice()
		topics.addRange(General.getTopicsAvailableForResearch(company))
		settings.topics = topics.map (t) -> t.id
		researchedTopics = company.topics.map (t) -> t.id
		settings.researchedTopics = researchedTopics
		platforms = Platforms.getPlatformsOnMarket(company).filter (p) -> not p.isCustom and Platforms.doesPlatformSupportGameSize(p, "medium")
		settings.platforms = platforms.map (p) -> p.id
		settings.excludes = []
		lastGame = company.gameLog.last()
		settings.excludes.push {genre: lastGame.genre.id, topic: lastGame.topic.id} if lastGame
	else
		topics = settings.topics.map (id) -> Topics.topics.first (t) -> t.id is id
		researchedTopics = settings.researchedTopics.map (id) -> Topics.topics.first (t) -> t.id is id
		allPlatforms = Platforms.getPlatforms(company, true)
		platforms = settings.platforms.map (id) -> allPlatforms.first (p) -> p.id is id
	excludes = settings.excludes.slice()
	count = SDP.Util.getRandomInt(random, maxNumber)
	count = Math.max(1, count) if settings.intialSettings
	sizes = ["medium"]
	sizes.push("large","large","large") if company.canDevelopLargeGames()
	audiences = SDP.Enum.Audience.toArray()
	publishers = ProjectContracts.getAvailablePublishers(company)
	publishers.push(ProjectContracts.getPublishingCompanies(company))
	sizeBasePay = { medium:15e4, large:15e5/2 }
	for i in [0...count]
		if platform and (platform.company and random.random() <= 0.2)
			publisher = publishers.find((val) -> val.toString() is platform.company)
		else if random.random() <= 0.1
			publisher = publishers.pickRandom(random) # Adds a low chance for random platform company contracts
		else publisher = publishers.filter((val) -> not val.isCompany?()).pickRandom(random)
		diffculty = 0
		genre = undefined
		topic = undefined
		if random.random() <= 0.7
			genre = if publisher.getGenre? then publisher.getGenre(random) else General.getAvailableGenres(company).pickRandom(random)
			diffculty += 0.1
		if random.random() <= 0.7
			loop
				if random.random() <= 0.7
					topic = if publisher.getTopic? then publisher.getTopic(random, topics.except(researchedTopics)) else topics.except(researchedTopics).pickRandom(random)
				else
					topic = if publisher.getTopic? then publisher.getTopic(random, topics) else topics.pickRandom(random)
				break if topic?
				break unless excludes.some (e) -> (not genre? or e.genre is genre.id) and e.topic is topic.id
			difficulty += 0.1 if topic?
		excludes.push({genre: genre?.id, topic: topic?.id}) if genre or topic
		platform = undefined
		if random.random() <= 0.7
			platform = if publisher.getPlatform? then publisher.getPlatform(random, platforms) else platform = platforms.pickRandom(random)
		audience = undefined
		if company.canSetTargetAudience() and random.random() <= 0.2
			audience = if publisher.getAudience? then publisher.getAudience(random) else audience = audiences.pickRandom(random)
		diffculty += 0.8 * random.random()
		minScore = 4 + Math.floor(5 * diffculty)
		loop
			size = sizes.pickRandom(random)
			break unless platform? and not Platforms.doesPlatformSupportGameSize(platform, size)
		basePay = sizeBasePay[size]
		pay = basePay * (minScore/10)
		pay /= 5e3
		pay = Math.max(1, Math.floor(pay)) * 5e3
		penalty = pay * 1.2 + pay * 1.8 * random.random()
		penalty /= 5e3
		penalty = Math.floor(penalty) * 5e3
		royaltyRate = Math.floor(7 + 8 * difficulty) / 100
		name = "#{if topic then topic.name else 'Any Topic'.localize()} / #{if genre then genre.name else 'Any Genre'.localize()}"
		if not platform or Platforms.getPlatformsOnMarket(company).first((p) -> p.id is platform.id)
			pubName = if publisher.getName? then publisher.getName() else publisher.toString()
			contracts.push {
				id: "publisherContracts"
				refNumber: Math.floor(Math.random() * 65535)
				type: "gameContract"
				name: name
				description: "Publisher: {0}".localize().format(pubName)
				publisher: pubName
				topic: if topic then topic.id else topic
				genre: if genre then genre.id else genre
				platform: if platform then platform.id else undefined
				gameSize: size
				gameAudience: audience
				minScore: minScore
				payment: pay
				penalty: penalty
				royaltyRate: royaltyRate
			}
		else count++
	contracts

ProjectContracts.publisherContracts.getContract = (company) ->
	SDP.GDT.Internal.generatePublisherContracts(company, SDP.GDT.Internal.getGenericContractsSettings(company, "publisher"), 5).filter (c) -> not c.skip

###
Allows adding of standard contract work
###
ProjectContracts.moddedContracts = []
ProjectContracts.getAvailableModContractsOf = (company, size) ->
	contracts = []
	for c in ProjectContracts.moddedContracts when not c.isAvailable? or (c.isAvailable? and c.isAvailable(company))
		contracts.push(c) if c.size is size
	contracts

ProjectContracts.genericContracts.__oldGetContract = ProjectContracts.genericContracts.getContract
ProjectContracts.genericContracts.getContract = (company) ->
	settings = SDP.GDT.Internal.getGenericContractsSettings(company, "small")
	seed = SDP.Util.getSeed(settings)
	random = new MersenneTwister(seed)
	genCon = SDP.GDT.Internal.generateContracts
	resultContracts = []
	contracts = ProjectContracts.genericContracts.__oldGetContract(company)
	contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "small"), 4)
	if company.flags.mediumContractsEnabled
		settings = SDP.GDT.Internal.getGenericContractsSettings(company, "medium")
		contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "medium"), 3)
	if company.flags.largeContractsEnabled
		settings = SDP.GDT.Internal.getGenericContractsSettings(company, "large")
		contracts.addRange genCon(company, settings, ProjectContracts.getAvailableModContractsOf(company, "large"), 2)
	return contracts.shuffle(random).filter (c) -> not c.skip

SDP.GDT.Internal.generateContracts = (company, settings, sourceSet, size, maxNumber) ->
	seed = SDP.Util.getSeed(settings)
	random = new MersenneTwister(seed)
	contracts = []
	set = sourceSet.slice()
	count = SDP.Util.getRandomInt(random, maxNumber)
	count = Math.max(1, count) if settings.intialSettings
	for i in [0...count] when set.length > 0
		item = set.pickRandom(random)
		set.remove(item)
		contract = SDP.GDT.Internal.generateSpecificContract(company, item, size, random)
		contract.id = "genericContracts"
		contract.index = i
		contract.skip = true if settings.contractsDone and settings.contractsDone.indexOf(i) isnt -1
		contracts.push(contract)
	contracts

SDP.GDT.Internal.generateSpecificContract = (company, template, size, random) ->
	r = random.random()
	r += random.random() if random.random() > 0.8
	minPoints = 11
	minPoints = 30 if size is "medium"
	minPoints = 100 if size is "large"
	minPoints += 6 if minPoints is 12 and company.staff.length > 2
	factor = company.getCurrentDate().year / 25
	minPoints += minPoints * factor
	points = minPoints + minPoints * r
	pointPart = points / (template.dF + template.tF)
	d = pointPart * template.dF
	t = pointPart * template.tF
	d += d * 0.2 * random.random() * random.randomSign()
	t += t * 0.2 * random.random() * random.randomSign()
	d = Math.floor(d)
	t = Math.floor(t)
	pay = points * 1e3
	pay /= 1e3
	pay = Math.floor(pay) * 1e3
	weeks = Math.floor(3 + 7 * random.random())
	weeks = Math.floor(3 + 3 * random.random()) if size is "small"
	penalty = pay * 0.2 + pay * 0.3 * random.random()
	penalty /= 1e3
	penalty = Math.floor(penalty) * 1e3
	return {
		name : template.name,
		description : template.description
		requiredD : d
		requiredT : t
		spawnedD : 0
		spawnedT : 0
		payment : pay
		penalty : -penalty
		weeksToFinish : weeks
		rF : template.rF
		isGeneric : true
		size : size
	}

###
Allows adding reviewer names to the reviewer list along with existing and retire dates
Allows adding review messages
###
Reviews.moddedReviewers = []
Reviews.moddedMessages = []
Reviews.vanillaReviewers = [
	{id: 'StarGames', name: 'Star Games'}
	{id: 'InformedGamer', name: 'Informed Game'}
	{id: 'GameHero', name: 'Game Hero'}
	{id: 'AllGames', name: 'All Games'}
]
Reviews.getAllReviewers = ->
	result = Reviews.vanillaReviewers.slice()
	result.addRange(Reviews.moddedReviewers.slice())
	result

Reviews.getAvailableReviewers = (company) ->
	week = Math.floor(company.currentWeek)
	Reviews.getAllReviewers().filter((val) ->
		return (not val.startWeek? or week > General.getWeekFromDateString(val.startWeek, val.ignoreGameLengthModifier)) and (not val.retireWeek? or week < General.getWeekFromDateString(val.retireWeek, val.ignoreGameLengthModifier))
	)

Reviews.getFourRandomReviewers = (company) ->
	reviews = Reviews.getAvailableReviewers(company)
	if reviews.length < 4 then throw "Reviewers are missing"
	if reviews.length is 4 then return [reviews[0],reviews[1],reviews[2], reviews[3]]
	random = company._mersenneTwister
	first = reviews.pickRandom(random)
	reviews = reviews.except(first)
	second = reviews.pickRandom(random)
	reviews = reviews.except(second)
	third = reviews.pickRandom(random)
	reviews = reviews.except(third)
	forth = reviews.pickRandom(random)
	company.randomCalled += 4
	[first, second, third, forth]

Reviews.getModdedPositiveMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when m.isPositive and not m.isNegative
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else if m.message? then result.push(m.message)
	result

Reviews.getModdedNegativeMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else if m.message? then result.push(m.message)
	result

Reviews.getModdedGenericMessages = (game, score) ->
	result = []
	for m in Reviews.moddedMessages when not m.isNegative and not m.isPositive
		if m.getMessage?
			result.push(m.getMessage(game, score))
		else if m.message? then result.push(m.message)
	result

Reviews.__oldGetGenericReviewMessage = Reviews.getGenericReviewMessage
Reviews.getGenericReviewMessage = (game, score) ->
	if game.company.getRandom() <= 0.5 then Reviews.getModdedGenericMessages(game, score) else Reviews.__oldGetGenericReviewMessage(game, score)

Reviews.getReviews = (game, finalScore, positiveMessages, negativeMessages) ->
	intScore = Math.floor(finalScore).clamp(1, 10)
	if finalScore >= 9.5
		intScore = 10
	reviewers = Reviews.getFourRandomReviewers(game.company)
	reviews = []
	usedMessages = []
	scores = []
	variation = 1
	positiveMessages.addRange(Reviews.getModdedPositiveMessages(game))
	negativeMessages.addRange(Reviews.getModdedNegativeMessages (game))
	for i in [0...4]
		if intScore is 5 or intScore is 6
			variation = if game.company.getRandom() < 0.05 then 2 else 1
		scoreVariation = if Math.randomSign() is 1 then 0 else variation * Math.randomSign()
		score = (intScore + scoreVariation).clamp(1, 10)
		if score is 10 and (scores.length is 3 and scores.average() is 10)
			if not game.flags.psEnabled
				if Math.floor(finalScore) < 10 or game.company.getRandom() < 0.8
					score--
			else if Math.floor(finalScore) is 10 and game.company.getRandom() < 0.4
				score++
		message = undefined
		loop
			if game.company.getRandom() <= 0.2
				if scoreVariation >= 0 and (score > 2 and positiveMessages.length isnt 0)
					message = positiveMessages.pickRandom()
				else
					if (scoreVariation < 0 and (score < 6 and negativeMessages.length isnt 0))
						message = negativeMessages.pickRandom()
			else
				message = undefined
			if not message
				message = Reviews.getGenericReviewMessage(game, score)
		break unless usedMessages.weakIndexOf(message) isnt -1
		usedMessages.push(message)
		scores.push(score)
		reviews.push {
			score : score
			message : message
			reviewerName : reviewers[i].name
		}
	return reviews

###
Forces all games to contain the company
###
`Game = (function(superClass) {
	var __extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; }
	__extend(Game, superClass);

	function Game(company) {
		this.id = GameManager.getGUID();
		this.title = void 0;
		this.genre = void 0;
		this.topic = void 0;
		this.platforms = [];
		this.engine = void 0;
		this.state = GameState.notStarted;
		this.gameSize = "small";
		this.targetAudience = "everyone";
		this.missionLog = [];
		this.salesCashLog = [];
		this.featureLog = null;
		this.score = 0;
		this.reviews = [];
		this.costs = 0;
		this.hypePoints = 0;
		this.technologyPoints = 0;
		this.bugs = 0;
		this.freeBugCount = 0;
		this.designPoints = 0;
		this.currentSalesCash = 0;
		this.totalSalesCash = 0;
		this.amountSold = 0;
		this.releaseWeek = 0;
		this.fansChangeTarget = 0;
		this.fansChanged = 0;
		this.initialSalesRank = 0;
		this.currentSalesRank = 0;
		this.topSalesRank = 0;
		this.researchFactor = 1;
		this.revenue = 0;
		this.flags = {};
		this.soldOut = false;
		this.company = company;
		if (company.conferenceHype) {
		  this.hypePoints = company.conferenceHype;
		  company.conferenceHype = Math.floor(company.conferenceHype / 3);
		}
	}

	return Game;

})(Game)`

###
Allow adding famous people and adding custom applicant algorithims
###
JobApplicants.moddedFamous = []
JobApplicants.moddedAlgorithims = []
JobApplicants.getRandomMale = (random) ->
	results = []
	JobApplicants.moddedAlgorithims.forEach (val) ->
		results.push(val.apply(random)) if val.forMale
	results.pickRandom(random)

JobApplicants.getRandomFemale = (random) ->
	results = []
	JobApplicants.moddedAlgorithims.forEach (val) ->
		results.push(val.apply(random)) if not val.forMale
	results.pickRandom(random)

JobApplicants.getFamousMale = (tech, design, random) ->
	results = []
	JobApplicants.moddedFamous.forEach (val) ->
		results.push(val.apply(random, tech, design)) if val.forMale
	results.pickRandom(random)

JobApplicants.getFamousFemale = (tech, design, random) ->
	results = []
	JobApplicants.moddedFamous.forEach (val) ->
		results.push(val.apply(random, tech, design)) if not val.forMale
	results.pickRandom(random)

JobApplicants.searchTests =
	[
		{
			id : "ComplexAlgorithms"
			name : "Complex Algorithms".localize()
			minT : 0.6
		}
		{
			id : "GameDemo"
			name : "Game Demo".localize()
			minD : 0.3,
			minT : 0.3
		}
		{
			id : "Showreel"
			name : "Showreel".localize()
			minD : 0.6
		}
	]
UI.__olgGenerateJobApplicants = UI._generateJobApplicants
UI._generateJobApplicants = ->
	oldApplicants = UI.__olgGenerateJobApplicants()
	settings = GameManager.uiSettings["findStaffData"]
	settings = {ratio : 0.1, tests : []} if not settings
	settings.seed = Math.floor(GameManager.company.getRandom() * 65535) if not settings.seed
	ratio = settings.ratio
	test = JobApplicants.searchTests.first (t) -> t.id is settings.tests.first()
	company = GameManager.company
	random = new MersenneTwister(settings.seed)
	newApplicants = []
	count = Math.floor(2 + 3 * (ratio + 0.2).clamp(0, 1))
	rerolls = 0
	maxRerolls = 2
	maxBonus = if company.currentLevel is 4 then 4 / 5 else 2 / 5
	takenNames = GameManager.company.staff.map (s) -> s.name
	for i in [0...count]
		qBonusFactor = ratio / 3 + (1 - ratio / 3) * random.random()
		maxBonus += 1 / 5 if random.random() >= 0.95
		q = 1 / 5 + maxBonus * qBonusFactor
		level = Math.floor(q * 5).clamp(1,5)
		maxD = 1
		minD = 0
		if test
			maxD -= test.minT if test.minT
			if test.minD
				minD = test.minD
				maxD -= minD
		baseValue = 200 * level
		d = baseValue * minD + baseValue * maxD * random.random()
		t = baseValue - d
		rBonusFactor = random.random()
		r = 1 / 5 + maxBonus * rBonusFactor
		sBonusFactor = random.random()
		s = 1 / 5 + maxBonus * sBonusFactor
		goodRoll = sBonusFactor > 0.5 && (qBonusFactor > 0.5 && rBonusFactor > 0.5)
		if not goodRoll and (rerolls < maxRerolls and random.random() <= (ratio + 0.1).clamp(0, 0.7))
			i--
			rerolls++
			continue
		rerolls = 0
		isFamous = false
		sex = "male"
		loop
			sex = "male"
			if goodRoll
				name = JobApplicants.getFamousMale(t, d, random) if (random.random() > 0.15)
				else
					name = JobApplicants.getFamousFemale(t, d, random)
					sex = "female"
				isFamous = true
			else
				name = JobApplicants.getRandomMale(random) if random.random() > 0.25
				else
					name = JobApplicants.getRandomFemale(random)
					sex = "female"
				isFamous = false
		break unless takenNames.indexOf(name) != -1
		takenNames.push(name)
		salary = Character.BASE_SALARY_PER_LEVEL * level
		salary += salary * 0.2 * random.random() * random.randomSign()
		salary = Math.floor(salary/1e3) * 1e3
		newApplicants.push {
			name : name,
			qualityFactor : q,
			technologyFactor : t / 500,
			designFactor : d / 500,
			researchFactor : r,
			speedFactor : s,
			salary : salary,
			isFamous : isFamous,
			sex : sex
		}
	GDT.fire GameManager, GDT.eventKeys.gameplay.staffApplicantsGenerated, {
		newApplicants : newApplicants
		settings : settings
		rng : random
	}
	applicants = []
	for i in [0...count]
		if random.random() >= 0.5
			a = newApplicants.pickRandom(random)
			applicants.push(a)
			newApplicants.remove(a)
		else
			a = oldApplicants.pickRandom(random)
			applicants.push(a)
			oldApplicants.remove(a)
	return applicants

###
WEIGHT
###
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

###
CONTRACTS
###
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

###
EVENT
###
SDP.GDT.__notUniqueEvent = (id) ->
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', DecisionNotifications.modNotifications)

class SDP.GDT.Event

	constructor: (id, @date, @isRandomEvent,  @ignoreLenMod) ->
		unless id? then throw new TypeError("id can't be undefined")
		if id instanceof Event
			e = id
			id = e.getId()
			@getId = -> id
			@date = new SDP.GDT.Date(e.date) if e.date?
			@isRandomEvent = e.isRandomEvent
			@ignoreLenMod = e.ignoreLenMod
			@maxTriggers = e.maxTriggers
			@trigger = e.trigger?.bind(this)
			@complete = e.complete?.bind(this)
			@getNotification = e.getNotification
		else if id.id?
			e = id
			id = e.id
			@getId = -> id
			@date = e.date
			@isRandomEvent = e.isRandomEvent
			@ignoreLenMod = e.ignoreGameLengthModifier
			@maxTriggers = e.maxTriggers
			@trigger = e.trigger
			@complete = e.complete
			@getNotification = unless e.notification? then e.getNotification else ((company) -> e.notification)
		else
			@maxTriggers = 1
			@trigger = (company) -> false
			@complete = (decision) -> return
			@getNotification = (company) -> new SDP.GDT.Notification(this)
			@getId = -> id
		@getNotification.bind(this)
		id += '_' while SDP.GDT.__notUniqueEvent(id)
		@getId = -> id

	toInput: =>
		return {
			id: @getId()
			date: @date unless @date instanceof SDP.GDT.Date then @date.toString()
			isRandomEvent: @isRandomEvent
			ignoreGameLengthModifier: @ignoreLenMod
			maxTriggers: @maxTriggers
			trigger: @trigger
			getNotification: @getNotification
			complete: @complete
		}

	add: =>
		GDT.addEvent(@)

###
NOTIFICATION
###
__notificationRep = Notification

class SDP.GDT.Notification

	constructor: (args...) ->
		if args.length is 1
			obj = args[0]
			if obj instanceof __notificationRep
				@header = obj.header
				@text = obj.text
				@buttonTxt = obj.buttonText
				@weeksUntilFire = obj.weeksUntilFire
				@image = obj.image
				@options = obj.options.slice()
				id = obj.sourceId
			else if obj instanceof Notification
				@header = obj.header
				@text = obj.text
				@buttonTxt = obj.buttonText
				@weeksUntilFire = obj.weeksUntilFire
				@image = obj.image
				@options = obj.options.slice()
				id = obj.getSourceId()
				event = obj.getEvent()
		else
			if args[0].constructor is String
				@header = args[0]
				@text = args[1]
				@buttonText = args[2]
				@weeksUntilFire = args[3]
				@image = args[4]
				event = args[5]
			else
				event = args[0]
				@header = args[1]
				@text = args[2]
				@buttonText = args[3]
				@weeksUntilFire = args[4]
				@image = args[5]
			id = if SDP.GDT.Event? and event instanceof SDP.GDT.Event then event.getId() else if event.id? then event.id else 0
			@options = []
		@sourceId = -> id
		@getEvent = (-> event) if event?

	addOption: (text) =>
		@options.push(text.localize("decision action button")) if @options.length < 3
		this

	addOptions: (txts...) =>
		if txts.length + @options.length < 3 then @options.push(txts) else
			index = 0
			@options.push(txts[index++].localize("decision action button")) while @options.length < 3
		this

	removeOption: (index) =>
		@options.splice(index, 1)
		this

	toInput: =>
		return new __notificationRep {
			header: @header
			text: @text
			buttonText: @buttonText
			weeksUntilFire: @weeksUntilFire
			image: @image
			options: @options
			sourceId: @sourceId
			event: @getEvent()
		}

	addAsEvent: =>
		SDP.GDT.addEvent(@) if @getEvent()?

	trigger: =>
		SDP.GDT.triggerNotification(@)

###
PLATFORM
###
SDP.GDT.__notUniquePlatform = (id) ->
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', Platforms.allPlatforms)

class SDP.GDT.Platform

	events: []
	marketPoints: []
	genreWeight: Weight.Default()
	audienceWeight: Weight.Default(false)

	constructor: (name, id = name) ->
		name = name.localize("game platform")
		@getName = -> name
		@company = null
		@startAmount = 0
		@unitsSold = 0
		@licensePrice = 0
		@publishDate = SDP.GDT.Date(1,1,1)
		@retireDate = SDP.GDT.Date.Max()
		@devCost = 0
		@techLevel = 1
		@iconUri = undefined
		@baseIconUri = undefined
		@imageDates = undefined
		@getId = -> id

	addEvent: (e) =>
		@events.push(e) if e instanceof SDP.GDT.Event
		this

	removeEvent: (id) =>
		index = @events.findIndex((val) -> val.id is id)
		@events.splice(index, 1) if index isnt -1

	addMarketPoint: (date, amount) =>
		return unless date?
		if date instanceof SDP.GDT.Date then date = date.toString()
		else if date.week? and date.month? and date.year? then date = "{0}/{1}/{2}".format(date.year, date.month, date.week)
		if typeof date isnt 'string' then return
		@marketPoints.push {
			'date': date
			'amount': amount
		} if date? and amount?
		this

	removeMarketDate: (date) =>
		index = @marketPoints.findIndex((val) -> val.date is date)
		@marketPoints.splice(index, 1) if index isnt -1

	setWeight: (weight) =>
		return if not SDP.GDT.Weight?
		unless weight instanceof SDP.GDT.Weight then return
		if weight.isGenre() then @genreWeight = weight else @audienceWeight = weight
		this

	getPrimEvents: ->
		arr = []
		arr.push(evt.toInput()) for evt in @events
		arr

	toInput: ->
		id = @getId()
		id += '_' while SDP.GDT.__notUniquePlatform(id)
		@getId = -> id
		return {
			id: @getId()
			name: @getName()
			iconUri: @iconUri
			imageDates: @imageDates
			baseIconUri: @baseIconUri
			company: if typeof @company.getName is "function" then @company.getName() else @company.toString()
			startAmount: @startAmount
			unitsSold: @unitsSold
			marketKeyPoints: @marketPoints
			licensePrice: @licensePrice
			published: @publishDate
			platformRetireDate: @retireDate
			developmentCost: @devCost
			genreWeightings: @genreWeight.toGenre().get()
			audienceWeightings: @audienceWeight.toAudience().get()
			techLevel: @techLevel
			events: @getPrimEvents()
		}

###
PUBLISHER
###
SDP.GDT.__notUniquePublisher = (id) ->
	item = {id: id}
	not Checks.checkUniqueness(item, 'id', ProjectContracts.getAllPublishers())

class SDP.GDT.Publisher
	topicOverride: []
	platformOverride: []
	genreWeightings: SDP.GDT.Weight.Default()
	audWeightings: SDP.GDT.Weight.Default(false)

	constructor: (name, id = name) ->
		if SDP.GDT.Company? and name instanceof SDP.GDT.Company
			@getCompany = -> name
			id = name.getId()
			name = name.getName()
		else if name? and typeof name is 'object'
			name.isPrimitive = true
			@getCompany = -> name
			id = name.id
			name = name.name
		name = name.localize("publisher")
		@getId = -> id
		@getName = -> name
		@startWeek = undefined
		@retireWeek = undefined

	addTopicOverride: (id, weight) =>
		@topicOverride.push {id: id, weight: weight.clamp(0,1)} if Topics.topics.findIndex((val) -> val.id is id) isnt -1

	addPlatformOverride: (id, weight) =>
		@platformOverride.push {id: id, weight: weight.clamp(0,1)} if Platforms.allPlatforms.findIndex((val) -> val.id is id) isnt -1

	setWeight: (weight) =>
		@genreWeightings = weight if weight.isGenre()
		@audWeightings = weight if weight.isAudience()

	toString: => @getName()

	getAudience: (random) =>
		auds = SDP.Enum.Audience.toArray()
		auds.forEach (val, i, arr) -> arr.push(val, val)
		for a in SDP.Enum.Audience.toArray()
			v = Math.floor(General.getAudienceWeighting(@audWeightings.get(), a)*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				auds.push(a)
				v--
			while v < 0
				auds.splice(auds.findIndex((val) -> val is a), 1)
				v++
		auds.pickRandom(random)

	getGenre: (random) =>
		defGenres = SDP.Enum.Genre.toArray()
		genres = SDP.Enum.Genre.toArray()
		genres.forEach (val, i, arr) -> arr.push(val, val)
		for g in defGenres
			v = Math.floor(General.getGenreWeighting(@genreWeightings.get(), g)*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				genres.push(g)
				v--
			while v < 0
				genres.splice(genres.findIndex((val) -> val is g), 1)
				v++
		genres.pickRandom(random)

	getPlatform: (random, defPlats) =>
		defPlats = defPlats.filter (p) -> @platformOverride.findIndex((v) -> v.id is p.id) isnt -1
		return unless defPlats
		platforms = defPlats.splice()
		platforms.forEach (val, i, arr) -> arr.push(val, val)
		for p in defPlats
			v = Math.floor(@platformOverride.find((val) -> val.id is p.id).weight*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				platforms.push(p)
				v--
			while v < 0
				platforms.splice(platforms.findIndex((val) -> val is g), 1)
				v++
		platforms.pickRandom(random)

	getTopic: (random, defTopics) =>
		defTopics = defTopics.filter (t) -> @topicOverride.findIndex((v) -> v.id is t.id) isnt -1
		return unless defPlats
		topics = defTopics.map (val) -> val
		topics.forEach (val, i, arr) -> arr.push(val, val)
		for p in defTopics
			v = Math.floor(@topicOverride.find((val) -> val.id is p.id).weight*10)-8
			continue if Math.abs(v) > 2
			while v > 0
				topics.push(p)
				v--
			while v < 0
				topics.splice(topics.findIndex((val) -> val is g), 1)
				v++
		topics.pickRandom(random)

	toInput: =>
		id = @getId()
		id += '_' while SDP.GDT.__notUniquePlatform(id)
		@getId = -> id
		return {
			id: @getId()
			name: @getName()
			isCompany: @getCompany()?
			company: @getCompany()
			getGenre: @getGenre
			getAudience: @getAudience
			getTopic: @getTopic
			getPlatform: @getPlatform
		}

###
RESEARCH
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
		return {
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

###
TOPIC
###
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
		@getId = -> id

	setOverride: (genreName, categoryName, value) =>
		pos = if genreName.constructor is String and categoryName.constructor is String then SDP.GDT.getOverridePositions(genreName, categoryName) else [genreName, categoryName]
		if 0 <= pos[0] <= @missionOverride.length and 0 <= pos[1] <= @missionOverride[pos[0]].length
			@missionOverride[pos[0]][pos[1]] = value

	toInput: =>
		id = @getId()
		id += '_' while SDP.GDT.__notUniqueTopic(id)
		@getId = -> id
		return {
			id: @getId()
			name: @getName()
			genreWeightings: if @genreWeight instanceof SDP.GDT.Weight then @genreWeight.toGenre().get() else @genreWeight
			audienceWeightings: if @audienceWeight instanceof SDP.GDT.Weight then @audienceWeight.toAudience().get() else @audienceWeight
			missionOverrides: @missionOverride
		}

	add: =>
		SDP.GDT.addTopic(@)

###
COMPANY
###
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