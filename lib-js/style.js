// Generated by CoffeeScript 1.11.0
var consoleControl, exports, style, util;

consoleControl = require('console-control-strings');

util = require('util');

style = (function() {
  var styleObj;
  styleObj = {
    enabled: true,
    enableColor: true,
    enableBeep: false,
    stream: process.stderr
  };
  styleObj.FormattedStyle = (function() {
    var _stream, _string, _style;

    _stream = styleObj.stream;

    _style = {};

    _string = '';

    function FormattedStyle(fmt) {
      if (fmt.constructor === styleObj.FormattedStyle) {
        _style = fmt.getStyle();
        _string = fmt.getFormat();
      } else {
        _style = fmt;
        _string = styleObj.generateFormatString(fmt);
      }
    }

    FormattedStyle.prototype.setStream = function(stream) {
      return _stream = stream;
    };

    FormattedStyle.prototype.resetStream = function() {
      return _stream = styleObj.stream;
    };

    FormattedStyle.prototype.syncString = function() {
      return _string = styleObj.generateFormatString(_style);
    };

    FormattedStyle.prototype.format = function(msg) {
      return styleObj.format(_string, msg);
    };

    FormattedStyle.prototype.write = function(msg) {
      if (!_stream) {
        return;
      }
      return _stream.write(this.format(msg));
    };

    FormattedStyle.prototype.getFormat = function() {
      return _string;
    };

    FormattedStyle.prototype.getStyle = function() {
      return _style;
    };

    FormattedStyle.prototype.toString = function() {
      return _string;
    };

    return FormattedStyle;

  })();
  styleObj.generateFormatString = function(format) {
    var output, settings;
    output = '';
    if (!styleObj.enabled || !format) {
      return output;
    }
    settings = [];
    if (styleObj.enableColor) {
      if (format.fg) {
        settings.push(format.fg);
      }
      if (format.bg) {
        settings.push('bg#{format.bg[0].toUpperCase()+format.bg.slice(1)}');
      }
    }
    if (format.bold) {
      settings.push('bold');
    }
    if (format.italic) {
      settings.push('italic');
    }
    if (format.underline) {
      settings.push('underline');
    }
    if (format.inverse) {
      settings.push('inverse');
    }
    if (settings.length) {
      output += consoleControl.color(settings);
    }
    if (styleObj.enableBeep && settings.beep) {
      output += consoleControl.beep();
    }
    return (output + "%s") + (styleObj.enableColor ? consoleControl.color('reset') : '');
  };
  styleObj.format = function(fmt, msg) {
    if (fmt.constructor === styleObj.FormattedStyle) {
      fmt = fmt.getFormat();
    } else if (fmt.constructor === Object) {
      fmt = styleObj.generateFormatString(fmt);
    }
    return util.format(fmt, msg);
  };
  styleObj.write = function(msg, style) {
    if (!styleObj.stream) {
      return;
    }
    if (style.constructor === styleObj.FormattedStyle) {
      return styleObj.stream.write(style.format(msg));
    } else if (style.constructor === String) {
      return styleObj.stream.write(styleObj.format(style, msg));
    } else {
      return styleObj.stream.write(styleObj.format(styleObj.generateFormatString(style), msg));
    }
  };
  return styleObj;
})();

module.exports = exports = style;
