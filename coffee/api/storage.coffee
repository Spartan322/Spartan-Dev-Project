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