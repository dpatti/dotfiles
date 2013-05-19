// Removes the items in the nav bar that you are not subscribed to and restricts access to /r/all and /r/pics
// This is what I call "self-control"

// hide nav
$("#sr-header-area>.separator").hide();
$("#sr-header-area .flat-list:not(:eq(1))").hide();

// hide main content of /r/all and /r/pics
var path = document.location.pathname;
if (path.match(/^\/r\/all\/?$/) || path.match(/^\/r\/pics\/?$/)) {
    $(".content").text("Nope.");
}

// remove next buutton if you are on page 2+
$('p.nextprev a:last').each(function(){
  var seen = $(this).attr('href').match(/count=(\d+)/);
  if (parseInt(seen[1]) >= 50)
    $(this).hide().prev().hide();
});

// check limit search
$('input[name=restrict_sr]').prop('checked', true);

if (!/(\/message\/|\/comments\/)/.test(document.location.pathname)) {
  new TimeRestriction({minutes: 15}, {hours: 6});
}
