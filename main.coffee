### Definitions for the devised SpartaDoc
All types can either contain the name of the types as found here or the vanilla API as analogs, this is corrected by the SDP
---
@customType ResearchItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] type The SDP.GDT.Research.types string this represents
@instruction('optional' if 'v')
	@attribute [Integer] pointsCost The cost of the research in research points
	@attribute [Integer] duration The time it takes to complete the research in milliseconds
	@attribute [Integer] researchCost The cost this research will take to research, without devCost, small scale devCost = researchCost * 4
	@instruction('optional' if 'researchCost') @attribute [Integer] devCost The cost to develop with this research on in small scale
	@attribute [Integer] engineCost The cost to put this into an engine
	@defaults(pointsCost) @attribute [Integer] enginePoints The amount of points this will cost to put in an engine
@attribute [String] category May be SDP.Constants.ResearchCategory of the object, or maybe something else
@attribute [String] categoryDisplayName Similar to category, human readable version
@optional
	@attribute [Integer] v A basic value to scale the research by
	@attribute [String] group The group to assign this research to, prevents more then one group being selected on games
	@attribute [Boolean] consolePart Whether this research applies to console creation as well
	@attribute [Boolean] engineStart Whether the research is available to all engines without research, overrides canResearch to always return false
	@attribute [Function(Game)] canUse Determines whether this research can be used
		@fparam [Game] game The game to test use against
		@freturn [Boolean] Whether the research can be used
	@attribute [Function(CompanyItem)] canResearch Determines whether this research is allowed to be researched
		@fparam [CompanyItem] company The company to check whether its researchable for
		@freturn [Boolean] Whether the research can be researched
---
@customType PlatformItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] company The company name this platform belongs to
@attribute [Float] startAmount The starting amount of units sold on release (multiplied by 5000000)
@attribute [Float] unitsSold The resulting units sold by the end (multiplied by 5000000)
@attribute [Integer] licensePrice The one time license price to develop on the platform
@attribute [String] publishDate The release date of the platform
@attribute [String] retireDate The retire date of the platform
@attribute [Integer] devCost The dev cost for developing on the platform
@attribute [Integer] techLevel The tech level of the platform (1-9, determines how ingenious the platform and the games for it will be)
@attribute [String] iconUri The icon refered to for the icon of the platform (or base uri if contains imageDates)
@attribute [Array {String date, Float amount}] marketPoints The key date points of the market in which the units sold change to the amount
@attribute [Array [6 Float]] genreWeight The weightings per genre based on SDP.Constants.Genre
@attribute [Array [3 Float]] audienceWeight The weightings per audience based on SDP.Constants.Audience
@optional @attribute [Array [String]] imageDates The dates for the platform image to change
---
@customType TopicItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [Array [6 Float]] genreWeight The weightings per genre based on SDP.Constants.Genre
@attribute [Array [3 Float]] audienceWeight The weightings per audience based on SDP.Constants.Audience
@attribute [Array [6 Array [9 Float]]] overrides The mission overrides as described on the [wiki](https://github.com/greenheartgames/gdt-modAPI/wiki/missionOverrides)
---
@customType ResearchProjectItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] description The description of the project
@attribute [Integer] pointsCost The cost to make in research points
@attribute [String] iconUri The uri of the icon to display for the project
@attribute [Integer] targetZone The zone for the project to take place in (0 for Hardware Lab, 2 for Research Lab, Effects of 1 unknown)
@optional @attribute [Boolean] repeatable Determiners whether the project can be repeated
@optional @attribute [Function(CompanyItem)] canResearch Determines whether research can be done
	@fparam [CompanyItem] company The company being tested
	@freturn [Boolean] Whether research can be done on the project
@optional @attribute [Function(CompanyItem)] complete A function to perform on completion
	@fparam [CompanyItem] company The company responsible for completing the project
@optional @attribute [Function(CompanyItem)] cancel Activates on cancelation of the project
	@fparam [CompanyItem] company The company canceling the project
---
@customType TrainingItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [Integer] pointsCost The cost in research points
@attribute [Integer] duration How long it will take to complete the training
@attribute [String] category The category of the object
@attribute [String] categoryDisplayName Similar to category, human readable version
@optional
	@attribute [Integer] cost The cost in money
	@attribute [Function(CharacterObject, CompanyItem)] canSee Determines whether the staff can see this training
		@fparam [CharacterObject] staff The staff that should be able to see the training
		@fparam [CompanyItem] company The company the training is taken place in
		@freturn [Boolean] Whether the training can be seen
	@attribute [Function(CharacterObject, CompanyItem)] canUse Determines whether the staff can use this training
		@fparam [CharacterObject] staff The staff that should be able to use the training
		@fparam [CompanyItem] company The company the training is taken place in
		@freturn [Boolean] Whether the training can be used
	@attribute [Function(CharacterObject, Integer)] tick Triggers every game tick this training is active
		@fparam [CharacterObject] staff The staff that is performing the training
		@fparam [Integer] delta The amount of milliseconds passed from the last tick
	@attribute [Function(CharacterObject)] complete Triggers on training completion
		@fparam [CharacterObject] staff The staff to complete the training
---
@customType ContractItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] description The description of the contract
@attribute [String] size The size of the contract, either small, medium, or large
@attribute [Float] tF The tech factor of the contract
@attribute [Float] dF The design factor of the contract
@optional
	@attribute [Function(CompanyItem, MersenneTwister)] generateCard Generates a contract card depending on the company and random
		@fparam [CompanyItem] company The company to generate the card for
		@fparam [MersenneTwister] random The random object used for generating the contract
		@freturn [ContractCardItem] The card item representing the contract generated
	@attribute [ContractCardItem] card The card item to repsent the contract definitely (generateCard takes priority)
@note generateCard and card can be ignored if tF and dF are supplied and vice versa
@optional
	@attribute [Float] rF The research factor generated
---
@customType PublisherItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
---
@customType ReviewerItem
---
@customType NotificationItem
@attribute [String] header The header of the notification
@attribute [String] text The text to display upon notifcation being tiggered
@instruction('optional' if 'options')
	@attribute [String] buttonTxt The text for the button to display
@instruction('optional' if 'buttonTxt')
	@attribute [Array [1-3 String]] options A collection of possible button options to choose from
@optional
	@attribute [String] image The image uri for the notification
	@attribute [String] sourceId The id of the corresponding event object
	@attribute [Integer] weeksUntilFire The amount of weeks that must pass before this notification is fired
---
@customType EventItem
@attribute [String] id The id of the event
@attribute [Function(CompanyItem)] trigger Determines whether the event can trigger
	@fparam [CompanyItem] company The company to test this trigger by
@instruction('optional' if 'getNotification') @attribute [NotificationItem] notification The notification for this event (overrides getNotification)
@instruction('optional' if 'notification') @attribute [Function(CompanyItem)] Retrieves a notification for this event
	@fparam [CompanyItem] company The company to retrieve the notification for
	@freturn [NotificationItem] The notification that was produced
@optional
	@attribute [Boolean] isRandomEvent Determines whether this event is random
	@attribute [Function(Integer)] complete Determines what happens upon completion (this.runningCompany refers to the active company for this event)
		@fparam [Integer] decision The decision chosen in the notification from 0 to 2
---
@customType ContractCardItem
@optional
	@attribute [Integer] techPoints The tech points to generate for the contract (overrides tF)
	@attribute [Integer] designPoints The design points to generate for the contract (overrides dF)
	@attribute [Float] tF The tech factor generated for the card
	@attribute [Float] dF The design factor generated for the card
	@attribute [Integer] minPoints The minimum points to generate based on factors (ignored if techPoints and designPoints supplied)
	@attribute [Integer] pay The pay available upon the contract's completion
	@attribute [Integer] penalty The penalty for job failure
	@attribute [Integer] weeks The amount of weeks determined to finish the contracts
###
style = require('./lib-js/style')

# @namespace Spartan Dev Project
#
# The primary namespace holding all of the SDP
SDP = {}
Companies = {}
JobApplicants = {}

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
jSTORAGE End
###
"use strict"

SDP.Util = ( ->
	util = {}
	fs = require('fs')
	path = require('path')

	normalizeStringPosix = (path, allowAboveRoot) ->
		res = ''
		lastSlash = -1
		dots = 0
		code = undefined
		for i in [0..path.length]
			if i < path.length then code = path.charCodeAt(i)
			else if code is 47 then break
			else code = 47

			if code is 47
				if lastSlash is i - 1 or dots is 1
					#NOOP
				else if lastSlash isnt i - 1 and dots is 2
					if res.length < 2 or res.charCodeAt(res.length - 1) isnt 46 or res.charCodeAt(res.length - 2) isnt 46
						if res.length > 2
							start = res.length - 1
							j = start
							for j in [start..0]
								if res.charCodeAt(j) is 47 then break
							if j isnt start
								if j is -1 then res = ''
								else res = res.slice(0, j)
							lastSlash = i
							dots = 0
							continue
					else if res.length is 2 or res.length is 1
						res = ''
						lastSlash = i
						dots = 0
						continue
				if allowAboveRoot
					if res.length > 0 then res += '/..'
					else res = '..'
				else
					if res.length > 0 then res += '/' + path.slice(lastSlash + 1, i)
					else res = path.slice(lastSlash + 1, i)
				lastSlash = i
				dots = 0
			else if code is 46 and dots isnt -1 then ++dots else dots = -1
		return res

	util.isString = (obj) -> obj.constructor is String
	util.isArray = (obj) -> obj.constructor is Array
	util.isNumber = (obj) -> not isNaN(obj)
	util.isInteger = (obj) -> util.isNumber(obj) and Number.isInteger(obj)
	util.isFloat = (obj) -> util.isNumber(obj) and not Number.isInteger(obj)
	util.isObject = (obj) -> obj.constructor is Object
	util.isBoolean = (obj) -> obj is true or obj is false
	util.isFunction = (obj) -> obj.constructor is Function

	String::capitalize = (index = 0) ->
		halfResult = @charAt(index).toUpperCase() + @slice(index+1)
		if halfResult.length is @length then return halfResult
		@slice(0, index) + halfResult

	util.Filesystem = ( ->
		fsys = {}
		inspect = require('util').inspect

		assertPath = (path) -> if typeof path isnt 'string' then throw new TypeError('Path must be a string. Received ' + inspect(path))

		_format = (sep, pathObject) ->
			dir = pathObject.dir or pathObject.root
			base = pathObject.base or ((pathObject.name or '') + (pathObject.ext or ''))
			if not dir then return base
			if dir is pathObject.root then return dir + base
			return dir + sep + base

		# Provides for path.posix not found in nodejs version 0.10
		# Allows posix standard path management, which is prefered in this project
		fsys.path = {
			resolve: (args...) ->
				resolvedPath = ''
				resolvedAbsolute = false
				cwd = undefined
				`for (var i = args.length - 1 i >= -1 && !resolvedAbsolute i--) {
					var path;
					if(i>=0) path = args[i];
					else {
						if (cwd === undefined) cwd = process.cwd();
						path = cwd;
					}
					assertPath(path);
					if(path.length === 0) continue;
					resolvedPath = path + '/' + resolvedPath;
					resolvedAbsolute = path.charCodeAt(0) is 47/*/*/);
				}`
				resolvedPath = normalizeStringPosix(resolvedPath, not resolvedAbsolute)
				if resolvedAbsolute
					if resolvedPath.length > 0 then return "/#{resolvedPath}" else return '/'
				else if resolvedPath.length > 0 then return resolvedPath else return '.'

			normalize: (path) ->
				assertPath(path)
				if path.length is 0 then return '.'
				`const isAbsolute = path.charCodeAt(0) is 47/*/*/;
				const trailingSeparator = path.charCodeAt(path.length - 1) is 47/*/*/`
				path = normalizeStringPosix(path, !isAbsolute)
				if path.length is 0 and not isAbsolute then path = '.'
				if path.length is 0 and trailingSeparator then path += '/'
				if isAbsolute then return "/#{path}"
				return path

			isAbsolute: (path) ->
				assertPath(path)
				return path.length > 0 and path.charCodeAt(0) is 47

			join: (args...) ->
				if args.length is 0 then return '.'
				joined = undefined
				for i, arg in args
					assertPath(arg)
					if joined is undefined then joined = arg else joined += "#{joined}/#{arg}"
				if joined is undefined then return '.'
				return fsys.path.normalize(joined)

			relative: (from, to) ->
				assertPath(from)
				assertPath(to)
				if from is to then return ''
				from = fsys.path.resolve(from)
				to = fsys.path.resolve(to)
				if from is to then return ''
				fromStart = 1
				break for fromStart in [fromStart..from.length] when from.charCodeAt(fromStart) isnt 47
				fromEnd = from.length
				fromLen = (fromEnd-fromStart)
				toStart = 1
				break for toStart in [toStart..to.length] when to.charCodeAt(toStart) isnt 47
				toEnd = to.length
				toLen = (toEnd-toStart)
				length = if fromLen < toLen then fromLen else toLen
				lastCommonSep = -1
				i = 0
				for i in [i..length]
					if i is length
						if toLen > length
							if to.charCodeAt(toStart + i) is 47 then return to.slice(toStart+i+1)
							else if i is 0 then to.slice(toStart+i)
						else if fromLen > length
							if from.charCodeAt(fromStart + i) is 47 then lastCommonSep = i
							else if i is 0 then lastCommonSep = 0
						break
					fromCode = from.charCodeAt(fromStart + i)
					toCode = to.charCodeAt(toStart + i)
					if fromCode isnt toCode then break
					else if fromCode is 47 then lastCommonSep = i
				out = ''
				for i in [fromStart+lastCommonSep+1..fromEnd]
					if i is fromEnd or from.charCodeAt(i) is 47
						if out.length is 0 then out += '..' else out += '/..'
				if out.length > 0 then return out+to.slice(toStart+lastCommonSep)
				else
					toStart += lastCommonSep
					if to.charCodeAt(toStart) is 47 then ++toStart
					return to.slice(toStart)

			dirname: (path) ->
				assertPath(path)
				if path.length is 0 then return '.'
				code = path.charCodeAt(0)
				hasRoot = code is 47
				end = -1
				matchedSlash = true
				for i in [path.length-1..1]
					code = path.charCodeAt(i)
					if code is 47
						if not matchedSlash
							end = i
							break
						else matchedSlash = false
				if end is -1 then return if hasRoot then '/' else '.'
				if hasRoot and end is 1 then return '//'
				return path.slice(0, end)

			basename: (path, ext) ->
				if ext isnt undefined and typeof ext isnt 'string' then throw new TypeError('"ext" argument must be a string')
				assertPath(path)
				start = 0
				end = -1
				matchedSlash = true
				i = undefined

				if ext isnt undefined and ext.length > 0 and ext.length <= path.length
					if ext.length is path.length and ext is path then return ''
					extIdx = ext.length - 1
					firstNonSlashEnd = -1
					for i in [path.length-1..0]
						code = path.charCodeAt(i)
						if code is 47
							if not matchedSlash
								start = i + 1
								break
						else
							if firstNonSlashEnd is -1
								matchedSlash = false
								firstNonSlashEnd = i + 1

							if extIdx >= 0
								if code is ext.charCodeAt(extIdx)
									if --extIdx is -1 then end = i
							else
							  extIdx = -1
							  end = firstNonSlashEnd

					if start is end then end = firstNonSlashEnd
					else if end is -1 then end = path.length
					return path.slice(start, end)
				else
					for i in [path.length-1..0]
						if path.charCodeAt(i) is 47
							if not matchedSlash
								start = i + 1
								break
						else if end is -1
							matchedSlash = false
							end = i + 1

					if end is -1 then return ''
					return path.slice(start, end)

			extname: (path) ->
				assertPath(path)
				startDot = -1
				startPart = 0
				end = -1
				matchedSlash = true
				preDotState = 0
				for i in [path.length-1..0]
					code = path.charCodeAt(i)
					if code is 47
						if not matchedSlash
							startPart = i + 1
							break
						continue
					if end is -1
						matchedSlash = false
						end = i + 1
					if code is 46#.
						if startDot is -1 then startDot = i
						else if preDotState isnt 1 then preDotState = 1
					else if startDot isnt -1 then preDotState = -1

				if startDot is -1 or	end is -1 or preDotState is 0 or (preDotState is 1 and startDot is end - 1 and startDot is startPart + 1) then return ''
				return path.slice(startDot, end)

			format: (pathObject) ->
				if pathObject is null or typeof pathObject isnt 'object' then throw new TypeError("Parameter 'pathObject' must be an object, not #{typeof pathObject}")
				return _format('/', pathObject)

			parse: (path) ->
				assertPath(path)
				ret = { root: '', dir: '', base: '', ext: '', name: '' }
				if path.length is 0 then return ret
				code = path.charCodeAt(0)
				isAbsolute = code is 47
				start = undefined
				if isAbsolute
					ret.root = '/'
					start = 1
				else start = 0
				startDot = -1
				startPart = 0
				end = -1
				matchedSlash = true
				i = path.length - 1
				preDotState = 0
				for i in [path.length-1..start]
					code = path.charCodeAt(i)
					if code is 47
						if not matchedSlash
							startPart = i + 1
							break
						continue
					if end is -1
						matchedSlash = false
						end = i + 1
					if code is 46#.
						if startDot is -1 then startDot = i
						else if preDotState isnt 1 then preDotState = 1
					else if startDot isnt -1 then preDotState = -1
				if startDot is -1 or end is -1 or (preDotState is 1 and startDot is end - 1 and startDot is startPart + 1)
					if end isnt -1
						if startPart is 0 and isAbsolute then ret.base = ret.name = path.slice(1, end)
						else ret.base = ret.name = path.slice(startPart, end)
				else
					if startPart is 0 and isAbsolute
						ret.name = path.slice(1, startDot)
						ret.base = path.slice(1, end)
					else
						ret.name = path.slice(startPart, startDot)
						ret.base = path.slice(startPart, end)
					ret.ext = path.slice(startDot, end)

				if startPart > 0 then ret.dir = path.slice(0, startPart - 1)
				else if isAbsolute then ret.dir = '/'
				return ret

			sep: '/'
			delimiter: ':'
			win32: null
			posix: null
		}

		fsys.cwd = -> PlatformShim.getScriptPath(true)

		fsys.walk = (dir, finish) ->
				results = []
				fs.readdir(p.get(), (err, files) ->
					if err then return finsh(err)
					pending = files.length
					if not pending then return finish(null, results)
					files.forEach((file) ->
						file = fsys.path.resolve(dir, file)
						fs.stat(file, (err, stat) ->
							if stat and stat.isDirectory() then walk(file, (err, res) ->
								results = results.concat(res)
								if not --pending then finish(null, results)
							)
							else
								results.push(file)
								if not --pending then return finish(null, results)
						)
					)
				)

		fsys.readJSONFile = (p) ->
			if p.constructor isnt util.Path then p = new fsys.Path(path)
			if p.isDirectory() then throw new TypeError("SDP.Util.Filesystem.readJSONFile can not operate on directories")
			if p.extname() isnt '.json' then throw new TypeError("SDP.Util.Filesystem.readJSONFile only operates on JSON files")
			result = null
			fs.readFile(p.get(), (err, data) ->
				if err then util.Logger.alert(err)
				result = JSON.parse(data)
			)
			result

		fsys.readJSONDirectory = (p, callback) ->
			if p.constructor isnt util.Path then p = new fsys.Path(path)
			if not p.isDirectory() then throw new TypeError("SDP.Util.Filesystem.readJSONDirectory can not operate on just files")
			return fsys.walk(p.get(), (err, files) ->
				if err then util.Logger.alert(err)
				results = []
				files.forEach((file) ->
					pa = new fsys.Path(file)
					json = fsys.readJSONFile(pa)
					if pa.extname() is '.json' then results.push(json)
					if util.isFunction(callback) then callback(json)
				)
				results
			)

		fsys.registerJSONFile = (p) ->
			if p.constructor isnt util.Path then p = new fsys.Path(path)
			if p.isDirectory() then throw new TypeError("SDP.Util.Filesystem.registerJSONFile can not operate on directories")
			if p.extname() isnt '.json' then throw new TypeError("SDP.Util.Filesystem.registerJSONFile only operates on JSON files")
			return util.registerJSONObject(fsys.readJSONFile(p))

		fsys.registerJSONDirectory = (p) ->
			if p.constructor isnt util.Path then p = new fsys.Path(path)
			if not p.isDirectory() then throw new TypeError("SDP.Util.Filesystem.registerJSONDirectory can only operate on directories")
			fsys.readJSONDirectory(p, (json) -> util.registerJSONObject(json))

		class fsys.Path
			constructor: (uri) ->
				if util.isObject(uri) then uri = fsys.path.format(uri)
				if uri is undefined then uri = fsys.cwd()
				fsys.Path.check(uri)
				@get = ->
					fsys.Path.check(uri)
					uri

			@check: (uri) ->
				if fsys.path.isAbsolute(uri) then throw new TypeError("SDP's Path may not store absolute paths")
				if not fsys.path.resolve(uri).startsWith(fsys.cwd()) then throw new TypeError("SDP's Path may not leave the current working directory")

			cd: (to) ->
				uri = fsys.path.resolve(@get(), to)
				fsys.Path.check(uri)
				@get = ->
					fsys.Path.check(uri)
					uri

			basename: (ext) ->
				fsys.path.basename(@get(), ext)

			dirname: ->
				fsys.path.dirname(@get())

			extname: ->
				fsys.path.extname(@get())

			parse: ->
				fsys.path.parse(@get())

			isFile: ->
				fs.lstatSync(@get()).isFile()

			isDirectory: ->
				fs.lstatSync(@get()).isDirectory()

			convert: ->
				@get()

		fsys
	)()

	util.registerJSONObject = (item) ->
		if not util.isString(item.objectType) then throw new TypeError("SDP.Util.registerJSONObject can not work on items that don't contain an objectType field")
		func = SDP.Functional["add#{item.objectType.capitalize()}Item"]
		if not func
			util.Logger.alert("SDP.Util.registerJSONObject could not find the function for objectType #{item.objectType}")
			return
		func(item)


	util.getOverridePositions = (genre, category) ->
		genre = genre.replace(/\s/g, "")
		category = category.replace(/\s/g, "")
		for g, i in SDP.Constants.Genre
			if genre is g
				if category is null then return [i]
				for c, ci in SDP.Constants.ResearchCategory
					if c is category then return [i, ci]
				break
		return undefined

	util.fixItemNaming = (item, originalName, fixName) ->
		if item[originalName]?
			item[fixName] = item[originalName]
			item[originalName] = undefined
		item

	class util.Image
		constructor: (@uri) ->
			@uri = null if not util.isString(@uri)

		exists: ->
			if @uri is null then return false
			doesExist = true
			fs.access(@uri, fs.constants.F_OK, (err) ->
				if err then doesExist = false
			)
			doesExist

	class util.Weight
		constructor: (w1 = 0.8, w2 = w1, w3 = w2, w4, w5 = w4, w6 = w5) ->
			if w1 is true or (not util.isNumber(w1) and not util.isArray(w1)) then @arr = [0.8,0.8,0.8]
			else if w1 is false then @arr = [0.8,0.8,0.8,0.8,0.8,0.8]
			else
				if util.isArray(w1)
					if w1.length > 3
						w1.push(w1.last()) while w1.length < 6
					else
						w1.push(w1.last()) while w1.length < 3
					@arr = w1
				else
					@arr = [w1,w2,w3]
					if w4 then @arr.push(w4,w5,w6)
				@arr[i] = num/100 for num, i in @arr when num > 1
			@isGenre = -> @arr.length is 6
			@isAudience = -> @arr.length is 3

		get: (index) ->
			if index is null then return @arr
			@arr[index]

		convert: ->
			new Array(@arr)

	class util.Date
		START = '1/1/1'
		END = '260/12/4'

		constructor: (y = 1, m, w) ->
			if util.isString(y)
				[y,m,w] = m.split('/')
				if util.isString(y) then [y,m,w] = m.split(' ')
			if y is true then [y,m,w] = END.split('/')
			if y is false then [y,m,w] = START.split('/')
			if m is undefined then m = y
			if w is undefined then w = m
			@string = "#{y}/#{m}/#{w}"

		convert: ->
			new String(@string)

	util.Error = ( ->
		Error = {
			logs: []
		}
		( ->
			update = false
			saving = false
			Error.save = ->
				if not saving
					json = JSON.stringify(Error.logs)
					saving = true
					DataStore.saveToSlotAsync("SDP.Util.Error.logs", json, ->
						saving = false
						if update
							update = false
							Error.save()
					, (m) -> saving = false )
				else update = true
		)()

		Error.addErrorLog = (level, message, error) ->
			if not error then error = {}
			Error.logs.push {
				date: (new Date()).toISOString()
				level: level
				msg: message
				errorMsg: error.message
				stacktrace: e.stack
				number: e.number
			}
			if Error.logs.length > 100 then Error.logs.splice(0, errorLogs.length - 100)
			Error.save()

		Error
	)()

	util.Logger = ( ->
		utilRequire = require('util')
		logger = {
			enabled: true
			enableAlerts: true
			formatter: logger.printf
			show: 200
			levels: {}
			addLevel: (level, weight, sty, prefix = level) ->
				if sty.constructor is style.FormattedStyle then sty = sty.getStyle()
				logger.levels[level] = {
					level: level
					prefix: prefix
					style: sty
					weight: weight
					format: (msg...) -> logger.format(level, msg...)
					formatWithTime: (msg...) -> logger.formatWithTime(level, msg...)
					log: (msg...) -> logger.log(level, msg...)
					alert: (msg...) -> logger.alert(level, msg...)
				}
				if logger[level] is undefined then logger[level] = logger.levels[level].log
				if logger["#{level}Alert"] is undefined then logger["#{level}Alert"] = logger.levels[level].alert

			setShow: (level) ->
				if level.constructor is Object then logger.show = level.weight
				else if level.constructor is String then logger.show = logger.levels[level].weight
				else logger.show = level
		}

		logger.addLevel('verbose', 0, { fg: 'blue', bg: 'black' }, 'VERBOSE')
		logger.addLevel('debug', 100, { fg: 'blue'}, 'DEBUG')
		logger.addLevel('info', 200, { fg: 'green'}, 'INFO')
		logger.addLevel('warn', 300, { fg: 'black', bg: 'yellow' }, 'WARN')
		logger.addLevel('error', 400, { fg: 'red', bg: 'black' }, 'ERROR')
		logger.addLevel('fatal', 500, { fg: 'red', bg: 'black' }, 'FATAL')

		stream = process.stderr
		Object.defineProperty(logger, 'stream',
			set: (newStream) ->
				stream = newStream
				style.stream = stream

			get: -> stream
		)

		createTimestamp = (d) ->
			formatNumbers = (n) -> if (n >= 0 and n < 10) then "0" + n else n + ""
			[
				[
					formatNumbers(d.getFullYear())
					formatNumbers(d.getMonth() + 1)
					d.getDate()
				].join("-")
				[
					formatNumbers(d.getHours())
					formatNumbers(d.getMinutes())
					formatNumbers(d.getHours())
				].join(":")
			].join("|")

		logger.printf = {
			formatWithTime: (level, msg...) ->
				if logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return "Level #{level} does not exist"
				style.format(level.style, "[#{createTimestamp(new Date())}]#{level.prefix}: #{str.shift().format(msg...)}")

			format: (level, msg...) ->
				if logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return "Level #{level} does not exist"
				style.format(level.style, "#{level.prefix}: #{str.shift().format(msg...)}")

			log: (level, msg...) ->
				if not logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return  "Level #{level} does not exist"
				if logger.enabled and logger.stream and logger.levels[level]?.weight >= logger.show
					logger.stream.write(logger.printf.formatWithTime(level, msg))

			alert: (level, msg...) ->
				if not logger.levels[level]? then return "Level #{level} does not exist"
				if logger.enabled and logger.enableAlerts and logger.levels[level]?.weight >= logger.show
					string = if msg.length is 1 then msg[0] else str.shift().format(msg...)
					PlatformShim.alert(string, logger.levels[level].prefix)
		}

		logger.format = {
			formatWithTime: (level, msg...) ->
				if logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return "Level #{level} does not exist"
				style.format(level.style, "[#{createTimestamp(new Date())}]#{level.prefix}: #{utilRequire.format(msg...)}")

			format: (level, msg...) ->
				if logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return "Level #{level} does not exist"
				style.format(level.style, "#{level.prefix}: #{utilRequire.format(msg...)}")

			log: (level, msg...) ->
				if not logger.levels[level]? then level = logger.levels[level]
				if logger.levels.indexOf(level) is -1 then return  "Level #{level} does not exist"
				if logger.enabled and logger.stream and logger.levels[level]?.weight >= logger.show
					logger.stream.write(logger.format.formatWithTime(level, msg))

			alert: (level, msg...) ->
				if not logger.levels[level]? then return "Level #{level} does not exist"
				if logger.enabled and logger.enableAlerts and logger.levels[level]?.weight >= logger.show
					string = if msg.length is 1 then msg[0] else utilRequire.format(msg...)
					PlatformShim.alert(string, logger.levels[level].prefix)
		}

		logger.formatWithTime = (level, msg...) ->
			logger.formatter.formatWithTime(level, msg...)

		logger.format = (level, msg...) ->
			logger.formatter.format(level, msg...)

		logger.log = (level, msg...) ->
			logger.formatter.log(level, msg...)

		logger.alert = (level, msg...) ->
			logger.formatter.alert(level, msg...)

		logger
	)()

	util.Check = ( ->
		Check = {
			usePopups: true
		}

		Check.error = (msg) ->
			try throw new Error(msg)
			catch e
				if Checks.usePopups then util.Logger.errorAlert(msg, e) else util.Logger.error(msg, e)
				Error.addErrorLog("MODERROR", msg, e)

		Check.audienceWeightings = (w) ->
			if not w or w.length < 3 or w.some((v) -> return v < 0 or v > 1)
				Check.error('audience weigthing is invalid: %s', w)
				return false
			return true

		Check.genreWeightings = (w) ->
			if not w or w.length < 6 or w.some((v) -> return v < 0 or v > 1)
				Check.error('genre weigthing is invalid: %s', w)
				return false
			return true

		Check.missionOverrides = (overrides) ->
			if overrides.length < 6 or overrides.some((o) -> o.length < 6 or o.some((w) -> w > 1 or w < 0))
				Check.error('invalid missionOverrides: %s', w)
				return false
			return true

		Check.date = (date) ->
			if date and date.split
				v = date.split('/')
				if v and v.length is 3 and not v.some((t) -> t < 1) and v[1] <= 12 and v[2] <= 4 then return true
				Check.error('date invalid: %s', date)
				return false

		Check.propertiesPresent = (obj, props) ->
			if not obj then return false
			if not props then return true
			for p in props
				if not p or p.length < 1 then continue
				if not obj.hasOwnProperty(p)
					Check.error('property not set on object: %s', p)
					return false
			return true

		Check.uniqueness = (obj, prop, values, ignoreErr) ->
			if values.some((v) -> v[prop] is obj[prop])
				if not ignoreErr then Check.error('duplicate value for %s found: %s', prop, obj[prop])
				return false
			return true

		Check
	)()

	util
)()

# @namespace Constants
#
# The constants of the SPD
SDP.Constants = {

	# Categories of development
	ResearchCategory: [
		'Engine'
		'Gameplay'
		'Story/Quests'
		'Dialogs'
		'Level Design'
		'AI'
		'World Design'
		'Graphic'
		'Sound'
	]

	# Audiences to target
	Audience: [
		'young'
		'everyone'
		'mature'
	]

	# Genres to choose for games
	Genre: [
		'Action'
		'Adventure'
		'RPG'
		'Simulation'
		'Strategy'
		'Casual'
	]
}

# @namespace Functional
#
# Contains the function interface for the SDP
SDP.Functional = {}

# Registers a Research item
#
# @param [ResearchItem] item The item to register
SDP.Functional.addResearchItem = (item) ->
	Checks = SDP.Util.Check
	unless item.type? then item.type = 'engine'
	if item.type is 'engine' and item.engineStart then item.canResearch = -> false
	requirments = ['id', 'name', 'category', 'categoryDisplayName']
	if item.v? then requirements.push('pointsCost','duration','researchCost','engineCost') else requirements.push('v')
	if Checks.propertiesPresent(item, requirements) and Checks.uniqueness(item, 'id', SDP.GDT.Research.getAll())
		SDP.GDT.Research.researches.push(item)
		Research.engineItems.push(item)
	return

SDP.Functional.addStartResearch = (item) ->
	item.type = 'start'
	SDP.Functional.addResearchItem(item)
SDP.Functional.addBasicResearch = (item) ->
	item.type = 'basic'
	SDP.Functional.addResearchItem(item)
SDP.Functional.addEngineResearch = (item) ->
	item.type = 'engine'
	SDP.Functional.addResearchItem(item)
SDP.Functional.addSpecialResearch = (item) ->
	item.type = 'special'
	SDP.Functional.addResearchItem(item)

# Registers a Platform item
#
# @param [PlatformItem] item The item to register
SDP.Functional.addPlatformItem = (item) ->
	Checks = SDP.Util.Check
	fix = SDP.Util.fixItemNaming
	fix(item, 'licensePrice','licencePrize')
	fix(item, 'publishDate', 'published')
	fix(item, 'retireDate', 'platformRetireDate')
	fix(item, 'devCosts', 'developmentCosts')
	fix(item, 'genreWeight', 'genreWeightings')
	fix(item, 'audienceWeight', 'audienceWeightings')
	fix(item, 'marketPoints', 'marketKeyPoints')

	if Checks.propertiesPresent(item, ['id', 'name', 'company', 'startAmount', 'unitsSold', 'licencePrize', 'published', 'platformRetireDate', 'developmentCosts', 'genreWeightings', 'audienceWeightings', 'techLevel', 'baseIconUri', 'imageDates']) and Checks.uniqueness(item, 'id', SDP.GDT.Platform.getAll()) and Checks.audienceWeightings(item.audienceWeightings) and Checks.genreWeightings(item.genreWeightings) and Checks.date(item.published) and Checks.date(item.platformRetireDate)
		if item.marketKeyPoints then for point in item.marketKeyPoints
			return unless Checks.date(point.date)
		###
		if Checks.checkUniqueness(item.name, 'name', Companies.getAllCompanies())
			SDP.GDT.addCompany(item.name).addPlatform(item)
		else
		###
		SDP.GDT.Platform.platforms.push(item)
		if item.events then for event of item.events
			GDT.addEvent(event)
	return

# Registers a Topic item
#
# @param [TopicItem] item The item to register
SDP.Functional.addTopicItem = (item) ->
	Checks = SDP.Util.Check
	fix = SDP.Util.fixItemNaming
	fix(item, 'genreWeight', 'genreWeightings')
	fix(item, 'audienceWeight', 'audienceWeightings')
	fix(item, 'overrides', 'missionOverrides')
	if Checks.propertiesPresent(t, ['name', 'id', 'genreWeightings', 'audienceWeightings']) and Checks.audienceWeightings(t.audienceWeightings) and Checks.genreWeightings(t.genreWeightings) and Checks.uniqueness(t, 'id', SDP.GDT.Topic.getAll(), true)
		SDP.GDT.Topic.topics.push(item)
	return

SDP.Functional.addTopicItems = (list...) ->
	if list.length is 1
		list = list[0]
		if not SDP.Util.isArray(list) then return SDP.Functional.addTopicItem(list)
	SDP.Functional.addTopicItem(item) for item in list


# Registers a Research Project item
#
# @param [ResearchProjectItem] item The item to register
SDP.Functional.addResearchProjectItem = (item) ->
	Checks = SDP.Util.Check
	unless item.canResearch? then item.canResearch = ((company)->true)
	if Checks.propertiesPresent(item, ['id', 'name', 'pointsCost', 'iconUri', 'description', 'targetZone']) and Checks.uniqueness(item, 'id', SDP.GDT.ResearchProject.getAll())
		SDP.GDT.ResearchProject.projects.push(item)
	return

SDP.Functional.addResearchProject = (item) -> SDP.Functional.addResearchProjectItem(item)

# Registers a Training item
#
# @param [TrainingItem] item The item to register
SDP.Functional.addTrainingItem = (item) ->
	Checks = SDP.Util.Check
	unless item.canSee? and item.canUse? then item.canSee = (staff, company) -> true
	if Checks.propertiesPresent(item, ['id', 'name', 'pointsCost', 'duration', 'category', 'categoryDisplayName']) and Checks.uniqueness(item, 'id', SDP.GDT.Training.getAll())
		SDP.GDT.Training.trainings.push(item)
	return

# Registers a Contract item
#
# @param [ContractItem] item The item to register
SDP.Functional.addContractItem = (item) ->
	Checks = SDP.Util.Check
	if Checks.propertiesPresent(item, ['id', 'name', 'description', 'tF', 'dF']) and Checks.uniqueness(item, 'id', SDP.GDT.Contract.getAll())
		SDP.GDT.Contract.contracts.push(item)
	return

# Registers a Publisher item
#
# @param [PublisherItem] item The item to register
SDP.Functional.addPublisherItem = (item) ->
	Checks = SDP.Util.Check
	if Checks.propertiesPresent(item, ['id', 'name']) and Checks.uniqueness(item, 'id', SDP.GDT.Publisher.getAll())
		SDP.GDT.Publisher.publishers.push(item)
	return

# Registers a Reviewer item
#
# @param [ReviewerItem] item The item to register
###
SDP.Functional.addReviewerItem = (item) ->
	Checks = SDP.Util.Check
	if Checks.propertiesPresent(item, ['id', 'name']) and Checks.uniqueness(item, 'id', SDP.GDT.Review.getAll())
		SDP.GDT.Review.reviewer.push(item)
	return
###

SDP.Functional.addEvent = (event) ->
	Checks = SDP.Util.Check
	unless Checks.propertiesPresent(event, ['id']) and (event.notification or event.getNotification) then return
	unless Checks.checkUniqueness(event, 'id', GDT.Event.getAll()) then return

	# hacks in runningCompany to events because event.complete does not supply one, and overriding the UI system is a bit much for now
	oldTrigger = event.trigger
	event.trigger = (company) ->
		result = oldTrigger(company)
		@runningCompany = company if result and event.complete?
		result
	GDT.Event.events.push(event)

# Adds a notification to the triggering queue
#
# @param [NotificationItem] item The item to queue
SDP.Functional.addNotificationToQueue = (item) ->
	if SDP.Util.isString(item)
		item = item.split('\n')
		if item.length is 1 then item = item[0].split(':')
		if item.length is 1 then item = item[0].split(';')
		item.forEach((e, i) -> item[i] = e.trim())
		item = {
			header: item[0]
			text: item[1]
			buttonText: item[2]
		}
	item.header = '?' unless item.header?
	item.text = '?' unless item.text?
	if not item instanceof Notification
		item = new Notification {
			header: item.header
			text: item.text
			buttonText: item.buttonText
			weeksUntilFired: item.weeksUntilFired
			image: item.image
			options: item.options.slice(0, 3)
			sourceId: item.sourceId
		}
	if GameManager?.company?.notifications? then GameManager.company.notifications.push(item) else SDP.GDT.Notification.queue.push(item)

SDP.Class = (
	classes = {}

	convertClasses = (classObj) ->
		switch classObj.constructor
			when SDP.Util.Date, SDP.Util.Weight, SDP.Util.Filesystem.Path then return classObj.convert()
			when Array
				classObj[i] = convertClasses(classObj[i]) for i of classObj
				return classObj
			else return classObj

	class Base
		constructor: (args...) ->
			if SDP.Util.isObject(args[0])
				@[arg] = args[0][arg] for arg in args[0] when args[0].hasOwnProperty(arg)
				@wasNativeObject = true
			else @wasNativeObject = false
			@id ?= @name

	class classes.Research extends Base
		constructor: (@name, @type, @category, @categoryDisplayName = @category, @id) ->
			super

		convert: ->
			item = {
				name: @name
				id: @id
				type: @type
				v: @v
				pointsCost: @pointsCost
				duration: @duration
				researchCost: @researchCost
				devCost: @devCost
				engineCost: @engineCost
				enginePoints: @enginePoints
				category: @category
				categoryDisplayName: @categoryDisplayName
				group: @group
				consolePart: @consolePart
				engineStart: @engineStart
				canUse: if @canUse? then @canUse.bind(item) else undefined
				canResearch: if @canResearch? then @canResearch.bind(item) else undefined
			}

	class classes.Platform extends Base
		constructor: (@name, @company, @id = @name) ->
			super
			@startAmount ?= 0
			@unitsSold ?= 0
			@audienceWeight ?= new SDP.Util.Weight(true)
			@genreWeight ?= new SDP.Util.Weight(false)
			@licensePrice ?= 0
			@publishDate ?= new SDP.Util.Date(false)
			@retireDate ?= new SDP.Util.Date(true)
			@devCost ?= 0
			@techLevel ?= 0
			@iconUri ?= new SDP.Util.Filesystem.Path()

		convert: ->
			{
				name: @name
				id: @id
				company: @company
				startAmount: @startAmount
				unitsSold: @unitsSold
				licensePrice: @licensePrice
				publishDate: convertClasses(@publishDate)
				retireDate: convertClasses(@retireDate)
				genreWeight: convertClasses(@genreWeight)
				audienceWeight: convertClasses(@audienceWeight)
				techLevel: @techLevel
				iconUri: convertClasses(@iconUri)
				imageDates: convertClasses(@imageDates)
				marketPoints: convertClasses(@marketPoints)
			}

	class classes.Topic extends Base
		BASE_OVERRIDE = [0,0,0,0,0,0,0,0,0]

		constructor: (@name, @id) ->
			super
			@audienceWeight ?= new SDP.Util.Weight(true)
			@genreWeight ?= new SDP.Util.Weight(false)
			if not @overrides? or not SDP.Util.isArray(@overrides)
				@overrides = [BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE]
			@overrides.push(BASE_OVERRIDE) while @overrides.length < 6
			o.push(0) for o in @overrides when o.length < 9

		setOverride: (genreName, catName, value) ->
			if SDP.Util.isArray(genreName)
				@overrides = genreName
				return @
			if SDP.Util.isArray(catName) then value = catName
			catOrNull = if value isnt catName and (SDP.Util.isString(catName) or SDP.Util.isInteger(catName)) then catName else null
			positions = SDP.Util.getOverridePositions(genreName, catOrNull)
			if value is catName
				@overrides[positions[0]] = value
			else
				@overrides[positions[0]][positions[1]] = value
			@

		convert: ->
			{
				name: @name
				id: @id
				genreWeight: convertClasses(@genreWeight)
				audienceWeight: convertClasses(@audienceWeight)
				overrides: @overrides
			}

	class classes.ResearchProject extends Base
		constructor: (@name, @description, @id) ->
			super
			@pointsCost ?= 0
			@iconUri ?= new SDP.Util.Filesystem.Path()
			@targetZone ?= 2

		convert: ->
			item = {
				name: @name
				id: @id
				description: @description
				pointsCost: @pointsCost
				iconUri: convertClasses(@iconUri)
				targetZone: @targetZone
				repeatable: @repeatable
				canResearch: if @canResearch? then @canResearch.bind(item) else undefined
				complete: if @complete? then @complete.bind(item) else undefined
				cancel: if @cancel? then @cancel.bind(item) else undefined
			}

	class classes.Training extends Base
		constructor: (@name, @category, @categoryDisplayName = @category, @id) ->
			super
			@pointsCost ?= 0
			@duration ?= 0

		convert: ->
			item = {
				name: @name
				id: @id
				cost: @cost
				pointsCost: @pointsCost
				category: @category
				categoryDisplayName: @categoryDisplayName
				canSee: if @canSee? then @canSee.bind(item) else undefined
				canUse: if @canUse? then @canUse.bind(item) else undefined
				tick: if @tick? then @tick.bind(item) else undefined
				complete: if @complete? then @complete.bind(item) else undefined
			}

	class classes.Contract extends Base
		constructor: (@name, @size, @description, @id) ->
			super
			@tF ?= 0
			@dF ?= 0

		convert:
			item = {
				name: @name
				id: @id
				size: @size
				description: @description
				tF: @tF
				dF: @dF
				card: @card
				generateCard: if @generateCard? then @generateCard.bind(item) else undefined
				rF: @rF
			}

	class classes.Publisher extends Base
		constructor: (@name, @id) ->
			super

		convert: ->
			item = {
				name: @name
				id: @id
				card: @card
				generateCard: if @generateCard? then @generateCard.bind(item) else undefined
			}

	class classes.Event extends Base
		constructor: (@id, @isRandomEvent) ->
			super
			@trigger ?= (company) -> false

		convert: ->
			item = {
				id: @id
				isRandomEvent: @isRandomEvent
				notification: @notification
				trigger: @tigger.bind(item)
				getNotification: if @getNotification? then @getNotification.bind(item) else undefined
				complete: if @complete? then @complete.bind(item) else undefined
			}
)()

SDP.GDT = ( ->
	GDT = {}
	GDT.Company = {
		companies: {}
		clientUid: undefined
		addCompany: (company) ->
			if not company.uid then company.uid = GameManager.getGUID()
			GDT.Company.companies[company.uid] = company
			if company is GameManager.company then clientUid = company.uid
		containsCompany: (company) -> companies[company.uid or company]?
		getCompanies: -> GDT.Company.companies.slice()
		getClientCompany: -> GDT.Company.companies[GDT.Company.clientUid]
		getPlatformsFor: (company, includeInactive) ->
			if includeInactive then return GDT.Platform.getAll().concat(company.licencedPlatforms)
			company.availablePlatforms.concat(company.licencedPlatforms)
		getByUid: (uid) -> GDT.Company.companes[uid]
	}
	Platforms.getPlatforms = GDT.Company.getPlatformsFor

	oldResearchGetAll = Research.getAllItems
	GDT.Research = {
		researches: oldResearchGetAll().forEach((r) ->
			switch r.category
				when 'General' then r.type = 'basic'
				when 'Game Design', 'Project Management', 'Technology', 'Publishing' then r.type = 'special'
				else r.type = 'engine'
			if r.id is 'Text Based' or r.id is '2D Graphics V1' or r.id is 'Basic Sound' then r.type = 'start'
			if r.id is '2D Graphics V2' or r.id is 'Linear story' or r.id is 'Savegame' then r.engineStart = true
		)
		# start research is accessible without an engine
		# basic research are researches that do not pertain specifically to engines
		# engine research are researches that do pertain to engines
		# special research is basically the misc, where it would fit nowhere else, for example Marketing
		types: ['start', 'basic', 'engine', 'special']

		getAll: -> GDT.Research.researches.concat(oldResearchGetAll().except(GDT.Research.researches))
		getAvailable: (company, engine) -> GDT.Research.getAll().filter((r) ->
				if r.type is 'start' then return true
				if engine and engine.parts.first((e) -> e.id is r.id)? then return true
				if r.enginePoints is 0 and company.researchCompleted.indexOf(r) isnt -1 then return true
				if company.specialItems.indexOf(r) isnt -1 then return true
				false
			)
		getAvailableEngineParts: (company) ->
			if company.canDevelopEngine() then return GDT.Research.getAll().filter((r) ->
				if r.engineStart then return true
				if r.type is 'start' or r.type is 'basic' then return false
				Research.getEnginePoints(r) isnt 0 and (Research.getEngineCost(r) isnt 0 and company.researchCompleted.indexOf(r) isnt -1)
			)
			[]
		addSpecialItem: (company, idOrObj) -> company.specialItems.push(if SDP.Util.isString(idOrObj) then GDT.Researches.getAll().first((r) -> r.id is idOrObj) else idOrObj)
		removeSpecialItem: (company, idOrObj) -> company.specialItems.remove(if SDP.Util.isString(idOrObj) then GDT.Researches.getAll().first((r) -> r.id is idOrObj) else idOrObj)
		getById: (id) -> GDT.Research.getAll().first((r) -> r.id is id)
	}
	Research.getAllItems = GDT.Research.getAll
	( ->
		oldResearchPointsCost = Research.getPointsCost
		Research.getPointsCost = (r) ->
			if r.pointsCost then return r.pointsCost
			return oldResearchPointsCost(r)
		oldResearchDuration = Research.getDuration
		Research.getDuration = (r) ->
			if r.duration then return r.duration
			return oldResearchDuration(r)
		oldResearchDevCost = Research.getDevCost
		Research.getDevCost = (r, game) ->
			if r.devCost
				value = r.devCost
				if game
					value *= General.getGameSizeDurationFactor(game.gameSize) * General.getMultiPlatformCostFactor(game)
					value = Math.floor(value / 1e3) * 1e3
				return value
			return oldResearchDevCost(r, game)
		oldResearchResearchCost = Research.getResearchCost
		Research.getResearchCost = (r) ->
			if r.researchCost then r.researchCost
			return oldResearchResearchCost(r)
		oldResearchEngineCost = Research.getEngineCost
		Research.getEngineCost = (r) ->
			if r.engineCost then return r.engineCost
			return oldResearchEngineCost(r)
	)()
	GameManager.getAvailableGameFeatures = GDT.Research.getAvailable
	General.getAvailableEngineParts = GDT.Research.getAvailableEngineParts

	( ->
		oldPlatformImage = Platforms.getPlatformImage
		GDT.Platform = {
			platforms: Platforms.allPlatforms
			getAll: -> GDT.Platform.platforms.slice()
			getAvailable: (company) ->
				GDT.Company.getPlatformsFor(company).filter((p) ->
					Platforms.getRetireDate(p) > Math.floor(company.currentWeek) and not p.isCustom or p.isCustom is true and (company.currentWeek > General.getWeekFromDateString(p.published) and not p.soldOut)
				)
			getImage: (platform, week) ->
				if platform.id is 'PC' then return oldPlatformImage(platform, week)
				if not platform.imageDates then return platform.iconUri
				else if week
					image = "{0}/{1}-{2}.png".format(baseUri, platform.id, String(i+1)) for date, i in platform.imageDates when General.getWeekFromDateString(date) <= week and i isnt 0
					if not image then return "{0}/{1}.png".format(baseUri, platform.id) else return image
			getById: (id) -> GDT.Platform.getAll().first((p) -> p.id is id)
		}
		Platforms.getPlatformsOnMarket = GDT.Platform.getAvailable
		Platforms.getPlatformImage = GDT.Platform.getImage
	)()

	GDT.Topic = {
		topics: Topics.topics
		_topicBackup: JSON.parse(JSON.stringify(GDT.Topic.topics))
		getAll: -> GDT.Topic.topics.slice()
		getById: (id) -> GDT.Topic.getAll().first((t) -> t.id is id )
		reset: (id) ->
			index = GDT.Topic.topics.indexOf(GDT.Topic.getById(id))
			if index isnt -1 then GDT.Topic.topics[index] = JSON.parse(JSON.stringify(GDT.Topic._topicBackup[index]))
	}

	GDT.ResearchProject = {
		projects: Research.bigProjects
		getAll: -> GDT.ResearchProject.projects.slice()
		getAvailable: (company, zone) ->
			GDT.ResearchProject.getAll().filter((p) ->
				p.targetZone is zone and p.canResearch(company)
			)
		getById: (id) -> GDT.ResearchProject.getAll().first((r) -> r.id is id)
	}
	General.getAvailableProjects = GDT.ResearchProject.getAvailable

	GDT.Training = {
		trainings: Training.getAllTrainings()
		getAll: ->
			results = []
			for item in GDT.Training.trainings.slice()
				if item.id? and (item.pointsCost? and item.duration?)
					item.isTraining = true
					results.push(item)
			results
		getAvailable: (staff) ->
			results = []
			for t in GDT.Training.getAll()
				results.push(t) if (t.canSee and t.canSee(staff, staff.company) or not t.canUse?) or (not t.canSee and t.canUse(staff, staff.company))
			results
		getById: (id) -> GDT.Training.getAll().first((t) -> t.id is id)
	}
	Training.getAllTrainings = GDT.Training.getAll
	Training.getAvailableTraining = GDT.Training.getAvailable

	# To prevent namespace clutter, stuck the contract stuff in a seperate function block
	( ->
		`var smallContracts = [{
			name: "Logo Animation".localize("heading"),
			description: "Create an animation for an existing logo.".localize(),
			tF: 1,
			dF: 2.5,
			rF: 1.5
		}, {
			name: "Character Design".localize("heading"),
			description: "Design some game characters.".localize(),
			tF: 1,
			dF: 4.5,
			rF: 1.5
		}, {
			name: "Playtest".localize("heading"),
			description: "Help to playtest a game.".localize(),
			tF: 1,
			dF: 1,
			rF: 1.5
		}, {
			name: "Game Backdrops".localize("heading"),
			description: "Design some simple background graphics for a game.".localize(),
			tF: 1,
			dF: 2,
			rF: 1.5
		}, {
			name: "Setup Computers".localize("heading"),
			description: "Install Mirconoft BOSS on computers".localize(),
			tF: 2,
			dF: 0.4
		}, {
			name: "Debug program".localize("heading"),
			description: "Help debugging a convoluted BASE program.".localize(),
			tF: 2,
			dF: 0.2
		}, {
			name: "Spritesheet Software".localize("heading"),
			description: "Our staff needs to be taught how to use these modern technologies.".localize(),
			tF: 3,
			dF: 2
		}, {
			name: "Library Software".localize("heading"),
			description: "Develop a simple library management system".localize(),
			tF: 5,
			dF: 1
		}];
		var mediumContracts = [{
			name: "Usability Study".localize("heading"),
			description: "Perform a detailed usability study.".localize(),
			tF: 5,
			dF: 6.5
		}, {
			name: "Review Game Concept".localize("heading"),
			description: "Review a game concept using your expertise.".localize(),
			tF: 3,
			dF: 8,
			rF: 1.5
		}, {
			name: "Game Art".localize("heading"),
			description: "Help out on a project with some game art".localize(),
			tF: 5,
			dF: 6,
			rF: 1.5
		}, {
			name: "Clean up database".localize("heading"),
			description: "Should one table really have 200 columns? Probably not.".localize(),
			tF: 5,
			dF: 1
		}, {
			name: "Accounting Software".localize("heading"),
			description: "Develop a simple accounting software. Are those ever simple?".localize(),
			tF: 5,
			dF: 1
		}, {
			name: "Time Tracking".localize("heading"),
			description: "Design and develop a time tracking system.".localize(),
			tF: 3,
			dF: 1
		}, {
			name: "Design a board game".localize("heading"),
			description: "Let's see how your skills translate to traditional games.".localize(),
			dF: 5,
			tF: 0.2,
			rF: 2
		}, {
			name: "Horoscope Generator".localize("heading"),
			description: "Making up horoscopes is hard work. We want it automated.".localize(),
			dF: 5,
			tF: 1
		}, {
			name: "Character Dialogues".localize("heading"),
			description: "Improve our character dialogues.".localize(),
			dF: 5,
			tF: 1,
			rF: 1.4
		}, {
			name: "Futuristic Application".localize("heading"),
			description: "We need an application that looks futuristic for a movie.".localize(),
			dF: 3,
			tF: 2,
			rF: 1.5
		}, {
			name: "Vacuum Robot".localize("heading"),
			description: "Create a revolutionary AI for a vacuum robot".localize(),
			tF: 2,
			dF: 1.4
		}, {
			name: "Website".localize("heading"),
			description: "We just heard of this thing called internet. We want to have one.".localize(),
			tF: 2,
			dF: 1.3
		}];
		var largeContracts = [{
			name: "Game Port".localize("heading"),
			description: "Port a game to a different platform.".localize(),
			tF: 3.2,
			dF: 1.7,
			rF: 1.2
		}, {
			name: "Cut Scenes".localize("heading"),
			description: "Deliver professional cut scenes for a game.".localize(),
			tF: 1,
			dF: 1,
			rF: 1.5
		}, {
			name: "Space Shuttle".localize("heading"),
			description: "Deliver part of the space shuttle control software.".localize(),
			tF: 3,
			dF: 2
		}, {
			name: "Alien Search".localize("heading"),
			description: "Optimize our search for alien life forms using advanced AI techniques.".localize(),
			tF: 3,
			dF: 1.8,
			rF: 1.3
		}, {
			name: "Movies".localize("heading"),
			description: "We need your skills in our latest blockbuster production.".localize(),
			tF: 1,
			dF: 1,
			rF: 1.5
		}]`
		GDT.Contract = {
			contracts: []
			getAll: -> GDT.Contract.contracts.slice()
			getAvailable: (company) ->
				results = []
				for c in GDT.Contract.getAll().filter((contract) -> not contract.isAvailable? or contract.isAvailable(company))
					results.push(c)
				results
			getSettings: (company, size) ->
				key = "contracts#{size}"
				settings = company.flags[key]
				if not settings
					settings = {id:key}
					company.flags[key] = settings
				settings
			getSeed: (settings) ->
				newSeed = ->
					settings.seed = Math.floor(Math.random() * 65535);
					settings.expireBy = GameManager.gameTime + 24 * GameManager.SECONDS_PER_WEEK * 1e3;
					settings.contractsDone = []
				if not settings.seed
					newSeed()
					settings.intialSettings = true
				else if settings.expireBy <= GameManager.gameTime
					newSeed()
					settings.intialSettings = false
				settings.seed
			createFromTemplate: (company, template, random) ->
				item = if template.generateCard? then template.generateCard(company, random) else template.card
				r = random.random()
				if random.random > 0.8 then r+= random.random()
				t = undefined
				d = undefined
				pay = undefined
				weeks = undefined
				penalty = undefined
				if item.techPoints then t = item.techPoints
				if item.designPoints then d = item.designPoints
				if item.payment then pay = item.payment
				if item.weeks then weeks = item.weeks
				if item.penalty then penalty = item.penalty
				unless t and d and pay and weeks and penalty
					minPoints = undefined
					tF = template.tF or item.tF
					dF = template.dF or item.dF
					unless t and d and not item.minPoints then minPoints = item.minPoints else
						minPoints = switch template.size
							when 'small' then 11
							when 'medium' then 30
							when 'large' then 100
						minPoints += 6 if minPoints is 12 and company.staff.length > 2
						minPoints += minPoints * (company.getCurrentDate().year / 25)
					points = minPoints + minPoints * r
					pointPart = points / (dF + tF)
					unless d
						d = pointPart * dF
						d += d * 0.2 * random.random() * random.randomSign()
						d = Math.floor(d)
					unless t
						t = pointPart * tF
						t += t * 0.2 * random.random() * random.randomSign()
						t = Math.floor(t)
					unless pay then pay = Math.floor(points*1e3/1e3) * 1e3
					unless weeks then (weeks = if template.size is small then Math.floor(3 + 3 * random.random()) else Math.floor(3 + 7 * random.random()))
					unless penalty then penalty = Math.floor((pay * 0.2 + pay * 0.3 * random.random())/1e3) * 1e3
				{
					name: template.name
					description: template.description
					id: 'genericContracts'
					requiredD: d
					requiredT: t
					spawnedD: 0
					spawnedT: 0
					payment: pay
					penalty: -penalty
					weeksToFinish: weeks
					rF: template.rF
					isGeneric: true
					size: template.size
				}
			generate: (company, size, max) ->
				settings = GDT.Contract.getSettings(company, size)
				random = new MersenneTwister(GDT.Contract.getSeed(settings))
				count = Math.max(max - 1, Math.floor(random.random() * max))
				results = []
				set = GDT.Contract.getAvailable(company).filter((e) -> e.size is size)
				if settings.initialSettings then count = Math.max(1, count)
				i = 0
				while i < count and set.length > 0
					item = set.pickRandom(random)
					set.remove(item)
					contractInstance = GDT.Contract.createFromTemplate(company, item, random)
					contractInstance.index = i
					if settings.contractsDone and settings.contractsDone.indexOf(i) isnt -1
						contract.skip = true
					contracts.push(contract)
					i++
				contracts
			getList: (company) ->
				settings = GDT.Contract.getSettings(company, 'small')
				results = GDT.Contract.generate(company, 'small', 4)
				if company.flags.mediumContractsEnabled then results.addRange(GDT.Contract.generate(company, 'medium', 3))
				if company.flags.largeContractsEnabled then results.addRange(GDT.Contract.generate(company, 'large', 2))
				results.shuffle(new MersenneTwister(GDT.Contract.getSeed(settings))).filter((c) -> not c.skip)
			getById: (id) -> GDT.Contract.getAll().first((c) -> c.id is id)
		}
		generateConvertContracts = (type) ->
			(e) ->
				e.size = type
				e.id = e.name.replace(' ', '')
		smallContracts.forEach(generateConvertContracts('small'))
		mediumContracts.forEach(generateConvertContracts('medium'))
		largeContracts.forEach(generateConvertContracts('large'))
		GDT.Contract.contracts.addRange(smallContracts)
		GDT.Contract.contracts.addRange(mediumContracts)
		GDT.Contract.contracts.addRange(largeContracts)
		ProjectContracts.generateContracts.getContract = GDT.Contract.getList
	)()


	( ->
		`var publishers = [{
			id: "ActiveVisionaries",
			name: "Active Visionaries"
		}, {
			id: "ea",
			name: "Electronic Mass Productions"
		}, {
			id: "RockvilleSoftworks",
			name: "Rockville Softworks"
		}, {
			id: "BlueBitGames",
			name: "Blue Bit Games"
		}, {
			id: "CapeCom",
			name: "CapeCom"
		}, {
			id: "Codemeisters",
			name: "Codemeisters"
		}, {
			id: "DeepPlatinum",
			name: "Deep Platinum"
		}, {
			id: "InfroGames",
			name: "InfroGames"
		}, {
			id: "LoWoodProductions",
			name: "LoWood Productions"
		}, {
			id: "TGQ",
			name: "TGQ"
		}, {
			id: "\u00dcberSoft",
			name: "\u00dcberSoft"
		}]`
		GDT.Publisher = {
			publishers: publishers.slice()
			getAll: -> GDT.Publisher.publishers.slice()
			getAvailable: (company) ->
				results = []
				for p in GDT.Publisher.getAll().filter((publisher) -> not publisher.isAvailable? or publisher.isAvailable(company))
					results.push(p)
				results
			generate: (company, max) ->
				settings = GDT.Contract.getSettings(company, size)
				seed = GDT.Contract.getSeed(settings)
				random = new MersenneTwister(seed)
				count = Math.max(max - 1, Math.floor(random.random() * max))
				results = []
				if settings.seed isnt seed
					settings.topics = undefined
					settings.researchedTopics = undefined
					settings.excludes = undefined
					settings.platforms = undefined
				if not settings.topics or (not settings.researchedTopics or not settings.platforms)
					topics = company.topics.slice()
					topics.addRange(General.getTopicsAvailableForResearch(company))
					settings.topics = topics.map((t) ->
						t.id
					)
					researchedTopics = company.topics.map((t) ->
						t.id
					)
					settings.researchedTopics = researchedTopics
					platforms =
						Platforms.getPlatformsOnMarket(company).filter((p) ->
							not p.isCustom and Platforms.doesPlatformSupportGameSize(p, "medium")
						)
					settings.platforms = platforms.map((p) ->
						p.id
					)
					settings.excludes = []
					lastGame = company.gameLog.last()
					if lastGame
						settings.excludes.push {
							genre: lastGame.genre.id
							topic: lastGame.topic.id
						}
				else
					topics = settings.topics.map((id) ->
						Topics.topics.first((t) ->
							t.id is id
						)
					)
					researchedTopics = settings.researchedTopics.map((id) ->
						Topics.topics.first((t) ->
							t.id is id
						)
					)
					allPlatforms = Platforms.getPlatforms(company, true);
					platforms = settings.platforms.map((id) ->
						allPlatforms.first((p) ->
							p.id is id
						)
					)
				excludes = settings.excludes.slice()
				count = Math.max(max - 1, Math.floor(random.random() * max))
				if settings.initialSetting then count = Math.max(1, count)
				sizes = ['medium']
				if company.canDevelopLargeGames() then sizes.addRange(["large", "large", "large"])
				audiences = ["young", "everyone", "mature"]
				sizeBasePay = { medium: 15e4, large: 15e5 / 2 }
				for i in [0..count]
					publisher = GDT.Publisher.getAvailable(company).pickRandom(random)
					if publisher.generateCard or publisher.card
						item = if publisher.generateCard? then publisher.generateCard(company) else publisher.card
						if item and (item.size is 'small' or company["canDevelop#{item.size.capitalize()}Games"]?())
							topic = item.topic
							genre = item.genre
							platform = item.platform
							name = "#{if topic then topic.name else 'Any Topic'.localize()} / #{if genre then genre.name else 'Any Genre'.localize()}"
							results.push {
								id: 'publisherContracts'
								refNumber: Math.floor(Math.random() * 65535)
								type: 'gameContract'
								name: name
								description: "Publisher: #{publisher.name}"
								publisher: publisher.name
								publisherObject: publisher
								topic: if topic then topic.id else topic
								genre: if genre then genre.id else genre
								platform: if platform.id then platform.id else platform
								gameSize: item.size,
								gameAudience: item.audience,
								minScore: item.minScore,
								payment: item.pay,
								penalty: item.penalty,
								royaltyRate: item.royaltyRate
							}
							continue
					diffculty = 0
					topic = undefined
					genre = undefined
					if random.random() <= 0.7
						genre = General.getAvailableGenres(company).pickRandom(random)
						diffculty += 0.1
					if random.random() <= 0.7
						`do {
							if (random.random() <= 0.7)
								topic = topics.except(researchedTopics).pickRandom(random);
							else
								topic = topics.pickRandom(random);
							if (topic === undefined)
								break
						} while (excludes.some(function (e) {
							return (genre === undefined || e.genre === genre.id) && e.topic === topic.id
						}))`
						if topic? then diffculty += 0.1
					if genre or topic then excludes.push {
							genre: if genre then genre.id else undefined
							topic: if topic then topic.id else undefined
						}
					platform = undefined
					if random.random() <= 0.7 then platform = platforms.pickRandom(random)
					audience = undefined
					if company.canSetTargetAudience() and  random.random() <= 0.2 then audience = audiences.pickRandom(random)
					difficulty += 0.8 * random.random()
					minScore = 4 + Math.floor(5 * difficulty)
					size = undefined
					`do
						size = sizes.pickRandom(random);
					while (platform != undefined && !Platforms.doesPlatformSupportGameSize(platform, size))`
					basePay = sizeBasePay[size]
					pay = Math.max(1, Math.floor((basePay * (minScore / 10))/5e3)) * 5e3
					penalty = Math.floor((pay * 1.2 + pay * 1.8 * random.random())/5e3) * 5e3
					pubObject = undefined
					puName = undefined
					if platform and (platform.company and random.random() <= 0.2) then pubName = platform.company
					else
						pubObject = publishers.pickRandom(random)
						pubName = pubObject.name
					royaltyRate = Math.floor(7 + 8 * difficulty) / 100
					name = "#{if topic then topic.name else 'Any Topic'.localize()} / #{if genre then genre.name else 'Any Genre'.localize()}"
					if not platform or Platforms.getPlatformsOnMarket(company).first((p) -> p.id is platform.id)
						results.push {
							id: "publisherContracts"
							refNumber: Math.floor(Math.random() * 65535)
							type: "gameContract"
							name: name
							description: "Publisher: {0}".localize().format(pubName)
							publisher: pubName
							publisherObject: pubObject
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
					else
						count++
				results
			getById: (id) -> GDT.Publisher.getAll().first((p) -> p.id is id)
		}
	)()

	( ->
		reviewers = ["Star Games", "Informed Gamer", "Game Hero", "All Games"]
		GDT.Review = {
			reviewers: reviewers.slice()
			messages: []
			getAll: -> GDT.Review.reviewers.slice()
			getAvailable: (company) ->
				results = []
				for r in GDT.Review.getAll().filter((reviewer) -> not reviewer.isAvailable? or reviewer.isAvailable(company))
					results.push(r)
				results
			getAllMessages: -> GDT.Review.messages.slice()
			pickReviewers: (count) ->
				results = []
				reviewers = GDT.Review.getAvailable()
				r = undefined
				for i in [0..count]
					r = reviewers.pickRandom()
					results.push(r)
					reviewers.remove()
				results
			reviewLatestFor: (company) ->
				negativeMessages = []
				positiveMessages = []
				mmoFactor = 1
				game = company.currentGame
				GDT.fire(GameManager, GDT.eventKeys.gameplay.beforeGameReview, {
					company : company,
					game : game
				})
				if game.flags.mmo then mmoFactor = 2
				sequelTo = undefined
				if game.sequelTo
					sequelTo = company.getGameById(game.sequelTo)
					if sequelTo.releaseWeek > company.currentWeek - 40 then game.flags.sequelsTooClose = true
				tp = game.technologyPoints
				dp = game.designPoints
				generalModifier = 0
				goodDecisions = 0
				badDecisions = 0
				if dp + tp >= 30
					goldenRatio = GameGenre.getGoldenRatio(game.genre, game.secondGenre)
					difference = dp * goldenRatio - tp
					percentDifference = 0
					percentDifference = if (tp > dp) then Math.abs(difference / tp * 100) else percentDifference = Math.abs(difference / dp * 100)
					"goldenRatio percentDifference: {0}".format(percentDifference).log()
					if Math.abs(percentDifference) <= 25
						generalModifier += 0.1
						goodDecisions += 1
						positiveMessages.push("They achieved a great balance between technology and design.".localize())
					else if Math.abs(percentDifference) > 50
						generalModifier -= 0.1
						if difference < 0 then negativeMessages.push("They should focus more on design.".localize())
						else negativeMessages.push("They should focus more on technology.".localize())
				executedDevMissions = game.featureLog.filter((m) -> m.missionType is "mission" )
				optimalMissionFocus = executedDevMissions.filter((m) ->
						percentage = m.duration / General.getGameSizeDurationFactor(game.gameSize) / General.getMultiPlatformDurationFactor(game) / (Missions.BASE_DURATION * 3)
						Missions.getGenreWeighting(m, game) >= 0.9 and percentage >= 0.4
				)
				if optimalMissionFocus.length >= 2
					generalModifier += 0.2
					goodDecisions += optimalMissionFocus.length
					positiveMessages.push("Their focus on {0} served this game very well.".localize().format(optimalMissionFocus.map((m) -> Missions.getMissionWithId(m.id)).pickRandom().name))
				else if optimalMissionFocus.length is 1
					generalModifier += 0.1
					goodDecisions += 1
				else
					generalModifier -= 0.15 * mmoFactor
				nonOptimalMissions = executedDevMissions.filter (m) ->
						percentage = m.duration / General.getGameSizeDurationFactor(game.gameSize) / General.getMultiPlatformDurationFactor(game) / (Missions.BASE_DURATION * 3)
						Missions.getGenreWeighting(m, game) < 0.8 and percentage >= 0.4
				if nonOptimalMissions.length is 2
					mission = Missions.getMissionWithId(nonOptimalMissions.pickRandom().id)
					generalModifier -= 0.2 * mmoFactor
					badDecisions += nonOptimalMissions.length
					negativeMessages.push("Their focus on {0} is a bit odd.".localize().format(mission.name))
				else if nonOptimalMissions.length is 1
					generalModifier -= 0.1 * mmoFactor
					badDecisions += 1
				underdevelopedMissions = executedDevMissions.filter (m) ->
						percentage = m.duration / General.getGameSizeDurationFactor(game.gameSize) / General.getMultiPlatformDurationFactor(game) / (Missions.BASE_DURATION * 3)
						Missions.getGenreWeighting(m, game) >= 0.9 and percentage <= 0.2
				for m in underdevelopedMissions
					mission = Missions.getMissionWithId(m.id)
					generalModifier -= 0.15 * mmoFactor
					badDecisions += 1
					negativeMessages.push("They shouldn't forget about {0}.".localize().format(mission.name))
				value = (dp + tp) / 2 / General.getGameSizePointsFactor(game)
				topicGenreMatch = GameGenre.getGenreWeighting(game.topic.genreWeightings, game.genre, game.secondGenre)
				if topicGenreMatch <= 0.6
					negativeMessages.push("{0} and {1} is a terrible combination.".localize().format(game.topic.name, game.getGenreDisplayName()))
				else if topicGenreMatch is 1
					positiveMessages.push("{0} and {1} is a great combination.".localize().format(game.topic.name, game.getGenreDisplayName()))
				genreText = game.genre.name
				if game.secondGenre then genreText += "-" + game.secondGenre.name
				previousGame = company.gameLog.last()
				if previousGame and (not game.flags.isExtensionPack and (previousGame.genre is game.genre and (previousGame.secondGenre is game.secondGenre and previousGame.topic is game.topic)))
					penalty = -0.4
					badDecisions += 1
					sameGenreTopic = "Another {0}/{1} game?".localize().format(genreText, game.topic.name)
					negativeMessages.push(sameGenreTopic)
					game.flags.sameGenreTopic = true
					"repeat genre/topic penalty: {0}:".format(penalty).log()
					generalModifier += penalty
				platformGenreMatch = Platforms.getGenreWeighting(game.platforms, game.genre, game.secondGenre)
				if platformGenreMatch <= 0.6
					smallestWeighting = Platforms.getNormGenreWeighting(game.platforms[0].genreWeightings, game.genre, game.secondGenre)
					smallestWeightingIndex = 0
					for p,i in game.platforms
						tempWeighting = Platforms.getNormGenreWeighting(p.genreWeightings, game.genre, game.secondGenre)
						if tempWeighting < smallestWeighting then smallestWeightingIndex = i
					negativeMessages.push("{0} games don't work well on {1}.".localize().format(genreText, game.platforms[smallestWeightingIndex].name))
				else if platformGenreMatch > 1
					highestWeighting = Platforms.getNormGenreWeighting(game.platforms[0].genreWeightings, game.genre, game.secondGenre)
					highestWeightingIndex = 0
					for p,i in game.platforms
						tempWeighting = Platforms.getNormGenreWeighting(p.genreWeightings, game.genre, game.secondGenre)
						if tempWeighting > highestWeighting then highestWeightingIndex = i
					positiveMessages.push("{0} games work well on {1}.".localize().format(genreText, game.platforms[highestWeightingIndex].name))
				gameAudienceWeighting = General.getAudienceWeighting(game.topic.audienceWeightings, game.targetAudience)
				if gameAudienceWeighting <= 0.6
					negativeMessages.push("{0} is a horrible topic for {1} audiences.".localize().format(game.topic.name, General.getAudienceLabel(game.targetAudience)))
				if game.flags.sequelsTooClose
					generalModifier -= 0.4
					badDecisions += 1
					if game.flags.isExtensionPack then negativeMessages.push("Already a expansion pack?".localize()) else negativeMessages.push("Didn't we just play {0} recently?".localize().format(sequelTo.title))
				if game.flags.usesSameEngineAsSequel and not game.flags.isExtensionPack
					generalModifier -= 0.1
					badDecisions += 1
				else if game.flags.hasBetterEngineThanSequel
					generalModifier += 0.2
					goodDecisions += 1
				if game.flags.mmo
					weighting = GameGenre.getGenreWeighting(game.topic.genreWeightings, game.genre, game.secondGenre)
					if weighting < 1 then generalModifier -= 0.15
				bugModifier = 1
				if game.bugs > 0
					perc = 100 / (game.technologyPoints + game.designPoints)
					bugsPercentage = (game.bugs * perc).clamp(0, 100)
					bugModifier = 1 - 0.8 * (bugsPercentage / 100)
					if bugModifier <= 0.6 then negativeMessages.push("Riddled with bugs.".localize())
					else if bugModifier < 0.9 then negativeMessages.push("Too many bugs.".localize())
				techLevelModifier = 1
				if game.platforms.length > 1
					maxTech = game.platforms[0].techLevel
					if game.platforms[0].id is "PC" then maxTech = game.platforms[1].techLevel
					minTech = maxTech
					for p in game.platforms when p.id isnt "PC"
							maxTech = Math.max(maxTech, p.techLevel)
							minTech = Math.min(minTech, p.techLevel)
					techLevelModifier -= (maxTech - minTech) / 20
				value += value * generalModifier
				value *= platformGenreMatch
				value *= gameAudienceWeighting
				value *= bugModifier
				value *= techLevelModifier
				trendModifier = GameTrends.getCurrentTrendFactor(game)
				game.flags.trendModifier = trendModifier
				value *= trendModifier
				topScore = getCurrentTopScoreBarrier(company)
				achievedRatio = value / topScore
				if achievedRatio >= 0.6 and (gameAudienceWeighting <= 0.7 or topicGenreMatch <= 0.7)
					achievedRatio = 0.6 + (achievedRatio - 0.6) / 2
				if achievedRatio > 0.7
					for p in game.platforms
						if Platforms.getPlatformsAudienceWeighting(p.audienceWeightings, game.targetAudience) <= 0.8
							value *= Platforms.getPlatformsAudienceWeighting(p.audienceWeightings, game.targetAudience, true)
							achievedRatio = value / topScore
							break
				"achieved {0} / top game {1} = {2}".format(value, Reviews.topScore, achievedRatio).log()
				demote = false
				finalScore = (achievedRatio * 10).clamp(1, 10)
				game.flags.teamContribution = 0
				company.staff.forEach((s) -> if s.flags.gamesContributed < 1 then game.flags.teamContribution elsegame.flags.teamContribution += game.getRatioWorked(s) )
				game.flags.teamContribution /= company.staff.length
				if company.lastTopScore > 0 and finalScore <= 5.2 - 0.2 * game.platforms.length
					if goodDecisions > 0 and (goodDecisions > badDecisions and game.flags.teamContribution >= 0.8)
						baseScore = 6
						numberWorkedOnGame = 0
						for key of game.flags.staffContribution
							if not game.flags.staffContribution.hasOwnProperty(key) then continue
							numberWorkedOnGame++
						optimalSize = General.getOptimalTeamSize(game)
						diff = Math.abs(optimalSize - numberWorkedOnGame)
						if diff > 1 then baseScore -= diff - 1
						newStaff = Reviews.getNewStaff(game)
						if newStaff
							if newStaff.length > 0 then baseScore -= newStaff.length / 2
						baseScore += goodDecisions / 2 - badDecisions / 2
						if bugModifier < 0.9 then baseScore -= 0.5
						else if bugModifier <= 0.6 then baseScore -= 1
						if platformGenreMatch <= 0.8 then baseScore -= 1 - platformGenreMatch
						if gameAudienceWeighting <= 0.8 then baseScore -= 1 - gameAudienceWeighting
						if game.platforms.length > 1
							maxTech = game.platforms[0].techLevel
							if game.platforms[0].id is "PC"
								maxTech = game.platforms[1].techLevel
							minTech = maxTech
							for p in game.platforms when p.id isnt "PC"
									maxTech = Math.max(maxTech, p.techLevel)
									minTech = Math.min(minTech, p.techLevel)
							baseScore -= (maxTech - minTech) / 0.5
						baseScore -= company.getRandom()
						baseScore = Math.min(baseScore, 7.7)
						if finalScore < baseScore
							game.flags.scoreWithoutBrackets = finalScore
							finalScore = baseScore
						if company.gameLog.length > 3
							topScoreDecrease = true
							for i in [1..3]
								tempGame = company.gameLog[company.gameLog.length - i]
								if tempGame.score > 5.2 - 0.2 * tempGame.platforms.length and not tempGame.flags.scoreWithoutBrackets
									topScoreDecrease = false
									break
							if topScoreDecrease
								company.lastTopScore = value
								game.flags.topScoreDecreased = true
				maxScoreFactor = getMaxScorePossible(company, game) / 10
				if game.gameSize isnt "medium" and (game.gameSize isnt "small" and maxScoreFactor < 1)
					negativeMessages.push("Technology is not state of the art.".localize())
				finalScore *= maxScoreFactor
				if finalScore >= 9
					if generalModifier < 0.1 and company.getRandom() < 0.8 then demote = true
					else
						newStaff = Reviews.getNewStaff(game)
						if newStaff.length > 0
							demote = true
							game.flags.newStaffIds = newStaff.map((staff) -> staff.id )
					if demote
						if game.flags.newStaffIds and game.flags.newStaffIds.length > 0
							finalScore = 8.15 + 0.95 / game.flags.newStaffIds.length * company.getRandom()
						else
							finalScore = 8.45 + 0.65 * company.getRandom()
						if company.getRandom() < 0.1
							finalScore = 9 + 0.25 * company.getRandom()
						updateTopScore(company, value)
				if sequelTo
					if finalScore <= 4
						if game.flags.isExtensionPack then negativeMessages.push("What a horrible expansion pack!".localize()) else negativeMessages.push("What a horrible sequel!".localize())
					else if finalScore <= 7
						if game.flags.isExtensionPack then negativeMessages.push("Average expansion pack.".localize()) else negativeMessages.push("Average sequel.".localize())
					else
						if game.flags.isExtensionPack then positiveMessages.push("Great expansion pack.".localize()) else positiveMessages.push("Great sequel!".localize())
				if company.topScoreAchievements < 2 and company.getCurrentDate().year < 4
					if finalScore == 10
						finalScore -= 1.05 + 0.45 * company.getRandom()
						setTopScoreAchievement(company, value)
					else if finalScore >= 9
						finalScore -= 1.05 + 0.2 * company.getRandom()
						setTopScoreAchievement(company, value)
					else if finalScore > 8.5 then finalScore -= 0.4 + 0.2 * company.getRandom()
				if finalScore >= 9 then setTopScoreAchievement(company, value)
				if finalScore isnt 10 and (game.flags.topScore and company.topScoreAchievements is 3) then finalScore = 10
				game.score = finalScore
				"final score: {0}".format(finalScore).log()
				if sequelTo
					if company.getRandom() <= 0.5 or not company.gameLog.some((g) -> g.sequelTo? )
						if game.flags.isExtensionPack then 	Media.createExtensionPackStory(company, game)
						else Media.createSequelStory(company, game)
				retVal = Reviews.getReviews(game, finalScore, positiveMessages, negativeMessages)
				GDT.fire(GameManager, GDT.eventKeys.gameplay.afterGameReview, {
					company : company,
					game : game,
					reviews : retVal
				})
				retVal
			generate: (game, finalScore, positiveMessages, negativeMessages) ->
				intScore = Math.floor(finalScore).clamp(1, 10)
				if finalScore >= 9.5 then intScore = 10
				reviewers = GDT.Reviewer.pickReviewers(4)
				reviews = []
				usedMessages = []
				scores = []
				variation = 1
				for reviewer in reviewers
					if intScore is 5 or intScore is 6 then (variation = if GameManager.company.getRandom() < 0.05 then 2 else 1)
					scoreVariation = if Math.randomSign() is 1 then 0 else variation * Math.randomSign()
					score = (intScore + scoreVariation).clamp(1, 10)
					if score is 10 and (scores.length is 3 and scores.average() is 10)
						if not game.flags.psEnabled
							if Math.floor(finalScore) < 10 or GameManager.company.getRandom() < 0.8 then score--
						else if Math.floor(finalScore) is 10 and GameManager.company.getRandom() < 0.4 then score++
					message = if reviewer.getMessage? then reviewer.getMessage(game, finalScore) else undefined
					if message is undefined
						`do {
							if (GameManager.company.getRandom() <= 0.2)
								if (scoreVariation >= 0 && (score > 2 && positiveMessages.length != 0))
									message = positiveMessages.pickRandom();
								else {
									if (scoreVariation < 0 && (score < 6 && negativeMessages != 0))
										message = negativeMessages.pickRandom()
								}
							else
								message = undefined;
							if (!message)
								message = Reviews.getGenericReviewMessage(game, score)
						} while (usedMessages.weakIndexOf(message) != -1)`
					usedMessages.push(message)
					scores.push(score)
					reviews.push {
						score : score,
						message : message,
						reviewerName : reviewer.name
					}
				reviews
			getById: (id) -> GDT.Reviewer.getAll().first((r) -> r.id is id)
			getMessageById: (id) -> GDT.Reviewer.getAllMessages.first((m) -> m.id is id)
		}
		GDT.Reviewer.reviewers.forEach((e, i) -> GDT.Reviewer.reviewers[i] = {name: e, id: e.replace(' ', '')})
	)()

	GDT.Event = {
		events: DecisionNotifications.getAllNotificationsObjects()
		getAll: -> GDT.Event.slice()
		getAvailable: (company) ->
			events = GDT.Event.getAll().filter((e) -> not e.isRandom and GDT.Event.isAvailable(e))
		getRandom: (company) ->
			spawnEvent = company.flags.nextRandomEvent and company.flags.nextRandomEvent <= GameManager.gameTime
			unless company.flags.nextRandomEvent
				company.flags.nextRandomEvent = (48 + 24 * company.getRandom()) * GameManager.SECONDS_PER_WEEK * 1e3
			if spawnEvent
				company.flags.nextRandomEvent = GameManager.gameTime + (36 + 48 * company.getRandom()) * GameManager.SECONDS_PER_WEEK * 1e3
				candidates = GDT.Event.getAll().filter((e) ->
					e.isRandomEvent and (company.flags.lastRandomEventId isnt e.id and GDT.Event.isAvailable(company, e))
				)
				event = candidates.pickRandom()
				unless event then return []
				company.flags.lastRandomEventId = event.id
				return event
			return []
		trigger: (company, event) ->
			unless company.eventTriggerCounts[event.id] then company.eventTriggerCounts[event.id] = 1
			else company.eventTriggerCounts[event.id]++
			return if event.notification then event.notification else event.getNotification(company)
		isAvailable: (company, event) ->
			if event.date
				return false if Math.floor(company.currentWeek) < General.getWeekFromDateString(event.date, event.ignoreGameLengthModifier)
			if event.maxTriggers or event.date
				count = GameManager.company.eventTriggerCounts[event.id]
				return false if count and count >= (if event.date then 1 else event.maxTriggers)
			event.date or event.trigger and event.trigger(company)
		getById: (id) -> GDT.Event.getAll().first((e) -> e.id is id )
	}

	GDT.Notification = {
		queue: []
		getNotification: (company, event) -> if event.notification then event.notification else event.getNotification(company)
		getNewNotifications: (company) ->
			results = GDT.Event.getAvailable(company).map((e) -> GDT.Event.trigger(company, e))
			if results.length is 0 then results = [GDT.Event.trigger(company, GDT.Event.getRandom(company))]
			results
	}
	DecisionNotifications.getNewNotifications = GDT.Notification.getNewNotifications

	GDT.ModSupport = ( ->
		ModSupport = {}

		oldLoad = ModSupport.loadMod
		ModSupport.loadMod = (enableMods, i) ->
			SDP.Util.Logger.formatter = SDP.Util.Logger.printf
			oldLoad(enableMods, i)

		ModSupport
	)()
	ModSupport.loadMod = GDT.ModSupport.loadMod

	GDT
)()

# Adds a basic wrapper of UltimateLib functionality for easy conversion to the SDP
( ->
	SDP.ULWrapper = {}
	unless String::endsWith?
		String::endsWith = (a) ->
			@substr(@length - a.length) is a
	unless String::startsWith?
		String::startsWith = (a) ->
			@substr(0, a.length) is a
	unless Number::truncateDecimals?
		Number::truncateDecimals = (a) ->
			b = @ - Math.pow(10, -a) / 2
			b += b / Math.pow(2, 53)
			b.toFixed(a)

	SDP.ULWrapper.Logger = ( ->
		Loggger = { enabled: true }
		Logger.log = (e, c) ->
			if not Logger.enabled then return
			unless c? then SDP.Util.Logger.debug(e) else SDP.Util.Logger.error("#{e}\n#{c.message}")
		Logger
	)()

	SDP.ULWrapper.Contracts = ( ->
		Contracts = {}
		# add Contract modifications here
		Contracts
	)()

	SDP.ULWrapper.Publishers = ( ->
		Publishers = {}
		# add Publisher modifications here
		Publishers
	)()

	SDP.ULWrapper.Research = ( ->
		Research = {}
		# add Research modifications here
		Research
	)()
)()

###
Adds company tracking system

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

GDT.on(GDT.eventKeys.saves.loaded, ->
	GameManager.company.notifications.push(i) for i in SDP.GDT.Notification.queue
	SDP.GDT.Notification.queue = [])
GDT.on(GDT.eventKeys.saves.newGame, ->
	GameManager.company.notifications.push(i) for i in SDP.GDT.Notification.queue
	SDP.GDT.Notification.queue = [])

###
Modifies GDT classes to make all objects indepedent of GameManager.company
###
( ->

	oldGameConst = Game
	oldGame = oldGameConst::
	Game = (company) ->
		oldGameConst.call(@, company)
		@company = company
		return

	Game:: = oldGame
)()

( ->

	oldCharConst = Character
	oldChar = oldCharConst::
	Character = (args...) ->
		oldCharConst.call(@, args)
		@company = args[0].company or SDP.GDT.Company.getAllCompanies()[args[0].uid] or SDP.GDT.Company.getClientCompany()
		return

	Character:: = oldChar

	oldSave = Character::save
	Character::save = ->
		oldSave.call(@).companyId = @company.uid
)()

( ->
	oldCompanyConst = Company
	oldCompany = oldCompanyConst::
	Company = (args...) ->
		oldCompanyConst.call(@, args)
		SDP.GDT.Company.addCompany(@)
		return

	Company:: = oldCompany
)()

###
Allow adding famous people and adding custom applicant algorithims

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
		goodRoll = sBonusFactor > 0.5 and (qBonusFactor > 0.5 and rBonusFactor > 0.5)
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