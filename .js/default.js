var TimeRestriction = (function(){
  function TimeRestriction(permitted, cooldown, callback){
    var last = this.last_visit()
      , now = Date.now();

    // Parse if we were given objects
    permitted = this.parse_time(permitted);
    cooldown = this.parse_time(cooldown);

    if (last + cooldown < now) {
      // Fresh visit
      this.add_visit();
    } else if (last + permitted < now) {
      // Restrict access
      (callback || this.restrict).call(this, last + cooldown);
    }
  }

  TimeRestriction.KEY = '__time_restriction';

  TimeRestriction.prototype.parse_time = function(time){
    if (typeof time !== 'object')
      return time;

    var values = { days: 24, hours: 60, minutes: 60, seconds: 1000 };
    return ['days', 'hours', 'minutes', 'seconds'].reduce(function(acc, key){
      return (acc + (time[key] || 0)) * values[key];
    }, 0);
  };

  TimeRestriction.prototype.last_visit = function(){
    return parseInt(localStorage.getItem(TimeRestriction.KEY)) || 0;
  };

  TimeRestriction.prototype.add_visit = function(){
    localStorage.setItem(TimeRestriction.KEY, Date.now());
  };

  TimeRestriction.prototype.restrict = function(expires){
    $('body > *').hide().parent().append('This will be unavailable until ' + new Date(expires).toTimeString());
  };

  return TimeRestriction;
})();
