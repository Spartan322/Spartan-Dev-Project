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
		timestamp = toTimeStr new Date()
		str = ""
		str = if c? then "#{timestamp} : Error! #{e}\n #{c.message}" else "#{timestamp} : #{e}"
		console.log(str)

	s
)(SDP.Logger or {})