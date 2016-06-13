// Generated by CoffeeScript 1.10.0
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  SDP.GDT.Weight = (function() {
    var MAX_VAL, MIN_VAL;

    MIN_VAL = 0;

    MAX_VAL = 1;

    function Weight(val1, val2, val3, val4, val5, val6) {
      var arr;
      if (val1 == null) {
        val1 = 0.8;
      }
      if (val2 == null) {
        val2 = val1;
      }
      if (val3 == null) {
        val3 = val2;
      }
      if (val5 == null) {
        val5 = val4;
      }
      if (val6 == null) {
        val6 = val5;
      }
      this.toGenre = bind(this.toGenre, this);
      this.toAudience = bind(this.toAudience, this);
      this.isAudience = bind(this.isAudience, this);
      this.isGenre = function() {
        if (val4 != null) {
          return true;
        } else {
          return false;
        }
      };
      val1 = val1.clamp(MIN_VAL, MAX_VAL);
      val2 = val2.clamp(MIN_VAL, MAX_VAL);
      val3 = val3.clamp(MIN_VAL, MAX_VAL);
      arr = [val1, val2, val3];
      if (this.isGenre()) {
        val4 = val4.clamp(MIN_VAL, MAX_VAL);
        val5 = val5.clamp(MIN_VAL, MAX_VAL);
        val6 = val6.clamp(MIN_VAL, MAX_VAL);
        arr.push(val4, val5, val6);
      }
      this.get = function() {
        return arr;
      };
    }

    Weight.prototype.isAudience = function() {
      return !this.isGenre();
    };

    Weight.prototype.toAudience = function() {
      var a;
      if (this.isAudience()) {
        return this;
      }
      a = this.get();
      return new Weight(a[0], a[1], a[2]);
    };

    Weight.prototype.toGenre = function() {
      var a;
      if (this.isGenre) {
        return this;
      }
      a = this.get();
      return new Weight(a[0], a[1], a[2], 0.8);
    };

    Weight.Default = function(forGenre) {
      if (forGenre == null) {
        forGenre = true;
      }
      if (forGenre) {
        return new Weight(0.8, 0.8, 0.8, 0.8);
      }
      return new Weight(0.8);
    };

    return Weight;

  })();

}).call(this);