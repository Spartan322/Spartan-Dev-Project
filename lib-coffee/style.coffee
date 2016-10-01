consoleControl = require('console-control-strings')
util = require('util')

style = (->
	styleObj = {
		enabled: true
		enableColor: true
		enableBeep: false
		stream: process.stderr
	}

	class styleObj.FormattedStyle
		_stream = styleObj.stream
		_style = {}
		_string = ''

		constructor: (fmt) ->
			if fmt.constructor is styleObj.FormattedStyle
				_style = fmt.getStyle()
				_string = fmt.getFormat()
			else
				_style = fmt
				_string = styleObj.generateFormatString(fmt)

		setStream: (stream) ->
			_stream = stream

		resetStream: -> _stream = styleObj.stream

		syncString: -> _string = styleObj.generateFormatString(_style)

		format: (msg) ->
			styleObj.format(_string, msg)

		write: (msg) ->
			if not _stream then return
			_stream.write(@format(msg))

		getFormat: -> _string

		getStyle: -> _style

		toString: -> _string

	styleObj.generateFormatString = (format) ->
		output = ''
		if not styleObj.enabled or not format then return output
		settings = []
		if styleObj.enableColor
			if format.fg then settings.push(format.fg)
			if format.bg then settings.push('bg#{format.bg[0].toUpperCase()+format.bg.slice(1)}')
		if format.bold then settings.push('bold')
		if format.italic then settings.push('italic')
		if format.underline then settings.push('underline')
		if format.inverse then settings.push('inverse')
		if settings.length then output += consoleControl.color(settings)
		if styleObj.enableBeep and settings.beep then output += consoleControl.beep()
		"#{output}%s"+ if styleObj.enableColor then consoleControl.color('reset') else ''

	styleObj.format = (fmt, msg) ->
		if fmt.constructor is styleObj.FormattedStyle then fmt = fmt.getFormat()
		else if fmt.constructor is Object then fmt = styleObj.generateFormatString(fmt)
		util.format(fmt, msg)

	styleObj.write = (msg, style) ->
		if not styleObj.stream then return
		if style.constructor is styleObj.FormattedStyle then styleObj.stream.write(style.format(msg))
		else if style.constructor is String then styleObj.stream.write(styleObj.format(style, msg))
		else styleObj.stream.write(styleObj.format(styleObj.generateFormatString(style), msg))

	styleObj
)()

module.exports = exports = style