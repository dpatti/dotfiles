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

// Because I press Ctrl+W way too often in a textarea trying to delete a word.
// There is no way to catch the tab close event in Chrome, so the best we can do
// is the beforeunload event.
var warning = function(e) {
  var active = document.activeElement;

  // Only bother if it isn't blank. This could be an input, textarea, or
  // contenteditable.
  if (active.value || active.innerText) {
    e.returnValue = "You're typing, man. You sure about this?";
    // Also unregister the event because letting go of ctrl won't fire the keyup
    // below.
    window.removeEventListener('beforeunload', warning);
  }
};
// We are looking for the ctrl key when inside an input. If we press ctrl and
// we're inside an input, we register the handler to prevent us from closing
// accidentally. If we let go of ctrl, we should unregister the event.
var keyEvent = function(e) {
  var activeIsInput = document.activeElement.matches(':read-write');
  var isDown = (e.type == 'keydown')
  var isCtrl = (e.keyCode == 17);

  // Enable
  if (isDown && isCtrl && activeIsInput) {
    window.addEventListener('beforeunload', warning);
  }

  // Disable
  if (!isDown && isCtrl) {
    window.removeEventListener('beforeunload', warning);
  }
};
document.addEventListener('keydown', keyEvent, true);
document.addEventListener('keyup', keyEvent, true);
