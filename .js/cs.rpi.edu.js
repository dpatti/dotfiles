var apply_blur = function(el){
  $(el).css('opacity', 0.5);
};

var today = new Date(), year = today.getFullYear();
$('.main_panel tr:not(:first)').find('td').toArray().reverse().reduce(function(blur, el){
  if (blur) {
    return apply_blur(el) || true;
  }
  var match = $(el).text().match(/^\w{3} \d+/);
  if (match) {
    var date = new Date(match);
    date.setFullYear(year);
    // Set to tomorrow since we're college kids and midnight is not the actual date boundary
    date.setDate(date.getDate() + 1);
    if (date < today) {
      return apply_blur(el) || true;
    }
  }

  return false;
}, false);
