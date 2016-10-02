### Definitions for the devised SpartaDoc
All types can either contain the name of the types as found here or the vanilla API as analogs, this is corrected by the SDP
---
@customType ResearchItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] category The SDP.Constants.ResearchCategory of the object
@attribute [String] categoryDisplayName Similar to category except may also be
---
@customType PlatformItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [CompanyItem] company The company this platform belongs to
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
---
@customType ContractItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
@attribute [String] description The description of the contract
---
@customType PublisherItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
---
@customType ReviewerItem
@attribute [String] id The unique id of the item
@attribute [String] name The name of the item
---
@customType ReviewMessageItem
@attribute [String] id The unique id of the item
---
@customType NotificationItem
@attribute [String] header The header of the notification
@attribute [String] text The text to display upon notifcation being tiggered
@instruction('optional' if 'options')
	@attribute [String] buttonTxt The text for the button to display
@instruction('optional' if 'buttonTxt')
	@attribute [Array [1-3 String]] options A collection of possible button options to choose from
@attribute [String] image The image uri for the notification
@attribute [String] sourceId The id of the corresponding event object
@attribute [Integer] weeksUntilFire The amount of weeks that must pass before this notification is fired
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

		fsys.cwd = -> fsys.path.resolve(process.cwd())

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
				if err then alert(err)
				result = JSON.parse(data)
			)
			result

		fsys.readJSONDirectory = (p, callback) ->
			if p.constructor isnt util.Path then p = new fsys.Path(path)
			if not p.isDirectory() then throw new TypeError("SDP.Util.Filesystem.readJSONDirectory can not operate on just files")
			return fsys.walk(p.get(), (err, files) ->
				if err then alert(err)
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
				uri = fsys.path.resolve(@get, to)
				fsys.Path.check(uri)
				@get = ->
					fsys.Path.check(uri)
					uri

			basename: (ext) ->
				fsys.path.basename(@get, ext)

			dirname: ->
				fsys.path.dirname(@get)

			extname: ->
				fsys.path.extname(@get)

			parse: ->
				fsys.path.parse(@get)

			isFile: ->
				fs.lstatSync(@get).isFile()

			isDirectory: ->
				fs.lstatSync(@get).isDirectory()

		fsys
	)()

	util.registerJSONObject = (item) ->
		if not util.isString(item.objectType) then throw new TypeError("SDP.Util.registerJSONObject can not work on items that don't contain an objectType field")
		func = SDP.Functional["add#{item.objectType.capitalize()}Item"]
		if not func
			alert("SDP.Util.registerJSONObject could not find the function for objectType #{item.objectType}")
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

	util.Logger = ( ->
		logger = {
			enabled: true
			show: 200
			levels: {}
			addLevel: (level, weight, sty, prefix = level) ->
				if sty.constructor is style.FormattedStyle then sty = sty.getStyle()
				logger.levels[level] = {
					level: level
					prefix: prefix
					style: sty
					weight: weight
					format: (msg) -> logger.format(level, msg)
					log: (msg) -> logger.log(level, msg)
				}
				if logger[level] is undefined then logger[level] = logger.levels[level].log

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

		logger.format = (level, msg, prefix = '') ->
			if logger.levels[level]? then level = logger.levels[level]
			else return "Level #{level} does not exist"
			style.format(level.style, "#{prefix}#{level.prefix}: #{msg}")

		logger.log = (level, msg) ->
			if not logger.levels[level]? then return "Level #{level} does not exist"
			if logger.enabled and logger.stream and logger.levels[level]?.weight >= logger.show
				logger.stream.write(logger.format(level, msg, "[#{createTimestamp(new Date())}]"))

		logger
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
	if item.v? then GDT.addResearchItem(item) else
		Research.engineItems.push(item) if Checks.checkPropertiesPresent(item, ['id', 'name', 'category', 'categoryDisplayName']) and Checks.checkUniqueness(item, 'id', Research.getAllItems())
	return

# Registers a Platform item
#
# @param [PlatformItem] item The item to register
SDP.Functional.addPlatformItem = (item) ->
	fix = SDP.Util.fixItemNaming
	fix(item, 'licensePrice','licencePrize')
	fix(item, 'publishDate', 'published')
	fix(item, 'retireDate', 'platformRetireDate')
	fix(item, 'devCosts', 'developmentCosts')
	fix(item, 'genreWeight', 'genreWeightings')
	fix(item, 'audienceWeight', 'audienceWeightings')
	fix(item, 'marketPoints', 'marketKeyPoints')

	if Checks.checkPropertiesPresent(item, ['id', 'name', 'company', 'startAmount', 'unitsSold', 'licencePrize', 'published', 'platformRetireDate', 'developmentCosts', 'genreWeightings', 'audienceWeightings', 'techLevel', 'baseIconUri', 'imageDates']) and Checks.checkUniqueness(item, 'id', Platforms.allPlatforms) and Checks.checkAudienceWeightings(item.audienceWeightings) and Checks.checkGenreWeightings(item.genreWeightings) and Checks.checkDate(item.published) and Checks.checkDate(item.platformRetireDate)
		if item.marketKeyPoints then for point in item.marketKeyPoints
			return unless Checks.checkDate(point.date)
		###
		if Checks.checkUniqueness(item.name, 'name', Companies.getAllCompanies())
			SDP.GDT.addCompany(item.name).addPlatform(item)
		else
		###
		Platforms.allPlatforms.push(item)
		if item.events then for event of item.events
			GDT.addEvent(event)
	return

# Registers a Topic item
#
# @param [TopicItem] item The item to register
SDP.Functional.addTopicItem = (item) ->
	fix = SDP.Util.fixItemNaming
	fix(item, 'genreWeight', 'genreWeightings')
	fix(item, 'audienceWeight', 'audienceWeightings')
	fix(item, 'overrides', 'missionOverrides')
	GDT.addTopic(item)

# Registers a Research Project item
#
# @param [ResearchProjectItem] item The item to register
SDP.Functional.addResearchProjectItem = (item) ->
	unless item.canResearch? then item.canResearch = ((company)->true)
	if Checks.checkPropertiesPresent(item, ['id', 'name', 'pointsCost', 'iconUri', 'description', 'targetZone']) and Checks.checkUniqueness(item, 'id', Research.bigProjects)
		Research.bigProjects.push(item)
	return

SDP.Functional.addResearchProject = (item) -> SDP.Functional.addResearchProjectItem(item)

# Registers a Training item
#
# @param [TrainingItem] item The item to register
SDP.Functional.addTrainingItem = (item) ->

	return

# Registers a Contract item
#
# @param [ContractItem] item The item to register
SDP.Functional.addContractItem = (item) ->

	return

# Registers a Publisher item
#
# @param [PublisherItem] item The item to register
SDP.Functional.addPublisherItem = (item) ->

	return

# Registers a Reviewer item
#
# @param [ReviewerItem] item The item to register
SDP.Functional.addReviewerItem = (item) ->

	return

# Registers a Review Message item
#
# @param [ReviewMessageItem] item The item to register
SDP.Functional.addReviewMessageItem = (item) ->

	return

# Adds a notification to the triggering queue
#
# @param [NotificationItem] item The item to queue
SDP.Functional.addNotificationToQueue = (item) ->
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

SDP.Class = (
	classes = {}

	class classes.Research

	class classes.Platform

		constructor: (@name, @companyId, @id = @name) ->
			@startAmount = 0
			@unitsSold = 0
			@licensePrice = 0
			@publishDate = new SDP.Util.Date(false)
			@retireDate = new SDP.Util.Date(true)
			@devCost = 0
			@techLevel = 0
			@iconUri = new SDP.Util.Filesystem.Path()
			@imageDates = []


	class classes.Topic
		BASE_OVERRIDE = [0,0,0,0,0,0,0,0,0]

		constructor: (@name, @id = @name) ->
			if @name.constructor is Object
				@id = @name.id
				@audienceWeight = new SDP.Util.Weight(@name.audienceWeight)
				@genreWeight = new SDP.Util.Weight(@name.genreWeight)
				@overrides = @name.overrides or @name.missionOverrides
				@name = @name.name
			else
				@audienceWeight = new SDP.Util.Weight(true)
				@genreWeight = new SDP.Util.Weight(false)
				@overrides = [BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE,BASE_OVERRIDE]

		setOverride: (genreName, catName, value) ->
			if SDP.Util.isArry(genreName)
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
				genreWeight: @genreWeight
				audienceWeight: @audienceWeight
				overrides: @overrides
			}

	class classes.ResearchProject

	class classes.Training

	class classes.Contract

	class classes.Publisher

	class classes.Reviewer

	class classes.ReviewMessage

	class classes.Company
		platforms = []

		constructor: (name, id = name) ->
			@getName = -> name
			@getId = -> id
			# companies should not allow internal modification after construction

		addPlatform: (item) ->
			item.companyId = @getId()
			platforms.push(item)

		getPlatform: (index) ->
			platforms[index]
)()

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
	}
	GDT.Company.addCompany(GameManager.company)

	GDT.ResearchProject = {
		projects: Research.bigProjects.slice()
		getAll: -> GDT.ResearchProject.projects.slice()
		getAvailable: (company, zone) ->
			GDT.ResearchProject.getAll().filter((p) ->
				p.targetZone is zone and p.canResearch(company)
			)
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
				results.push if (t.canSee and t.can(staff, staff.company) or not t.canUse?) or (not t.canSee and t.canUse(staff, staff.company))
			results
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
		generateConvertContracts = (type) ->
			(e) ->
				e.size = type
				e.id = e.name.replace(' ', '')
		GDT.Contract = {
			contracts: []
			getAll: -> GDT.Contract.contracts.slice()
			getAvailable: (company) ->
				results = []
				for c in GDT.Contract.getAll().filter((c) -> not contr.isAvailable? or contr.isAvailable(company))
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
				r = random.random()
				if random.random > 0.8 then r+= random.random()
				minPoints = switch template.size
					when 'small' then 11
					when 'medium' then 30
					when 'large' then 100
				minPoints += 6 if minPoints is 12 and company.staff.length > 2
				minPoints += minPoints * (company.getCurrentDate().year / 25)
				points = minPoints + minPoints * r
				pointPart = points / (template.dF + template.tF)
				d = pointPart * template.dF
				t = pointPart * template.tF
				d += d * 0.2 * random.random() * random.randomSign()
				t += t * 0.2 * random.random() * random.randomSign()
				d = Math.floor(d)
				t = Math.floor(t)
				pay = Math.floor(points*1e3/1e3) * 1e3
				weeks = if template.size is small then Math.floor(3 + 3 * random.random()) else Math.floor(3 + 7 * random.random())
				penalty = Math.floor((pay * 0.2 + pay * 0.3 * random.random())/1e3) * 1e3
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
		}
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
				for c in GDT.Publisher.getAll().filter((c) -> not contr.isAvailable? or contr.isAvailable(company))
					results.push(c)
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
					if publisher.generateCard
						item = publisher.generateCard(company)
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
							platform: if platform then platform.id else undefined
							gameSize: item.size,
							gameAudience: item.audience,
							minScore: item.minScore,
							payment: item.pay,
							penalty: item.penalty,
							royaltyRate: item.royaltyRate
						}
					else
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
		}
	)()


	GDT
)()



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
	settings.seed = Math.floor(Math.random() * 65535)
	settings.expireBy = GameManager.gameTime + 24 * GameManager.SECONDS_PER_WEEK * 1e3
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
###
GRAPHICAL
###
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
				$("head").append("<style id='#{e}' type='text/css'></style>") if $("##{id}").length is 0
				$("head").find("##{id}").append(content)

			c.addCss = (id, content) ->
				id = vis+id
				$("head").append("<style id='#{e}' type='text/css'></style>") if $("##{id}").length is 0
				$("head").find("##{id}").html(content)
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
Triggers all notifications in the situation they couldn't be triggered before (ie: before the GameManager.company.notification existed
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
Modifies GDT classes to make all objects indepedent of GameManager.company
###
( ->
	oldGame = Game::
	oldGameConst = Game
	Game = (company) ->
		oldGameConst.call(@, company)
		@company = company
		return

	Game:: = oldGame
)()

( ->
	oldChar = Character::
	oldCharConst = Character
	Character = (options) ->
		oldCharConst.call(@, options)
		@company = options.company or SDP.GDT.Company.getAllCompanies()[options.uid] or SDP.GDT.Company.getClientCompany()
		return

	Character:: = oldChar

	oldSave = Character::save
	Character::save = ->
		oldSave.call(@).companyId = @company.uid
)()

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