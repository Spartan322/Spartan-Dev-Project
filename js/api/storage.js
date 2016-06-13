// Generated by CoffeeScript 1.10.0

/*
Implements the jStorage functionality of UltimateLib, allows easy conversion from UltimateLib
 */

(function() {
  SDP.Storage = (function(s) {
    var log;
    log = SDP.Logger.log;
    s.read = function(storeName, defaultVal) {
      var e, error;
      try {
        log("SDP.Storage.read Started from localStorage with ID SPD.Storage." + f);
        if (s.getStorageFreeSize()) {
          if (defaultVal != null) {
            return $.jStorage.get("SDP.Storage." + storeName, defaultVal);
          } else {
            return $.jStorage.get("SDP.Storage." + storeName);
          }
        }
      } catch (error) {
        e = error;
        log("SDP.Storage.read Local storage error occured. Error: " + e.message);
        return false;
      }
    };
    s.write = function(storeName, val, options) {
      var e, error;
      if (!s.getStorageFreeSize()) {
        return;
      }
      try {
        if (options != null) {
          $.jStorage.set("SDP.Storage." + storeName, val, {
            TTL: options
          });
        } else {
          $.jStorage.set("SDP.Storage." + storeName);
        }
        return log("SDP.Storage.write Local storage successful at ID SDP.Storage." + f);
      } catch (error) {
        e = error;
        log("SDP.Storage.write Local storage error occured! Error: " + e.message);
        return false;
      }
    };
    s.clearCache = function() {
      return $.jStorage.flush();
    };
    s.getAllKeys = function() {
      return $.jStorage.index();
    };
    s.getStorageSize = function() {
      return $.jStorage.storageSize();
    };
    s.getStorageFreeSize = function() {
      return $.jStorage.storageAvailable();
    };
    s.reload = function() {
      return $.jStorage.reInit();
    };
    s.onKeyChange = function(front, back, func) {
      return $.jStorage.listenKeyChange("SDP.Storage." + front + "." + back, func);
    };
    s.removeListeners = function(front, back, func) {
      if (func != null) {
        return $.jStorage.stopListening("SDP.Storage." + front + "." + back, func);
      } else {
        return $.jStorage.stopListening("SDP.Storage." + front + "." + back);
      }
    };
    return s;
  })(SDP.Storage || {});

}).call(this);
