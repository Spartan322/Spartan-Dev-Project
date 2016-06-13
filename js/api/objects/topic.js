// Generated by CoffeeScript 1.10.0
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

SDP.GDT.__notUniqueTopic = function(id) {
  var item;
  item = {
    id: id
  };
  return !Checks.checkUniqueness(item, 'id', Topics.topics);
};

SDP.GDT.Topic = (function() {
  function Topic(name, id, genreWeight, audienceWeight) {
    var c, cats, g, i, j, len, len1, ref, ref1;
    if (id == null) {
      id = name;
    }
    this.genreWeight = genreWeight != null ? genreWeight : SDP.GDT.Weight.Default();
    this.audienceWeight = audienceWeight != null ? audienceWeight : SDP.GDT.Weight.Default(false);
    this.add = bind(this.add, this);
    this.toInput = bind(this.toInput, this);
    this.setOverride = bind(this.setOverride, this);
    name = name.localize("topic");
    this.getName = function() {
      return name;
    };
    this.missionOverride = [];
    ref = SDP.Enum.Genre.toArray();
    for (i = 0, len = ref.length; i < len; i++) {
      g = ref[i];
      cats = [];
      ref1 = SDP.Enum.ResearchCategory;
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        c = ref1[j];
        cats.push(0);
      }
      this.missionOverride.push(cats);
    }
    this.getId = function() {
      return id;
    };
  }

  Topic.prototype.setOverride = function(genreName, categoryName, value) {
    var pos, ref, ref1;
    pos = genreName.constructor === String && categoryName.constructor === String ? SDP.GDT.getOverridePositions(genreName, categoryName) : [genreName, categoryName];
    if ((0 <= (ref = pos[0]) && ref <= this.missionOverride.length) && (0 <= (ref1 = pos[1]) && ref1 <= this.missionOverride[pos[0]].length)) {
      return this.missionOverride[pos[0]][pos[1]] = value;
    }
  };

  Topic.prototype.toInput = function() {
    var id;
    id = this.getId();
    while (SDP.GDT.__notUniqueTopic(id)) {
      id += '_';
    }
    this.getId = function() {
      return id;
    };
    return {
      id: this.getId(),
      name: this.getName(),
      genreWeightings: this.genreWeight instanceof SDP.GDT.Weight ? this.genreWeight.toGenre().get() : this.genreWeight,
      audienceWeightings: this.audienceWeight instanceof SDP.GDT.Weight ? this.audienceWeight.toAudience().get() : this.audienceWeight,
      missionOverrides: this.missionOverride
    };
  };

  Topic.prototype.add = function() {
    return SDP.GDT.addTopic(this);
  };

  return Topic;

})();
