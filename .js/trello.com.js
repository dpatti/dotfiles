// Color in due dates between 24hs and next Friday
Date.prototype.nextWeekday = function(day) {
  var cur = this.getDay();
  var next = day - cur;
  if (next <= 0) next += 7;

  this.setDate(this.getDate() + next);
  return this;
};

$(document).on('DOMNodeInserted', function(){
  var nextFriday = new Date().nextWeekday(5);
  $(this).find('.badge.due-future').each(function(){
    var date = new Date($(this).text() + (new Date().getYear() + 1900));
    if (date < nextFriday) {
      $(this).css({
        'background-color': 'rgb(121, 184, 172)',
        'border-color': 'rgb(121, 184, 172)',
      }).find('span').css('color', '#fff');
    }
  });
});
