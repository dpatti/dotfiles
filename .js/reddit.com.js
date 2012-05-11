// Removes the items in the nav bar that you are not subscribed to and restricts access to /r/all and /r/pics
// This is what I call "self-control"

$(document).ready(function(){
    // hide nav
    $("#sr-header-area>.separator").hide();
    $("#sr-header-area .flat-list:not(:eq(1))").hide();

    // hide main content of /r/all and /r/pics
    var path = document.location.pathname;
    if (path.match(/^\/r\/all\/?$/) || path.match(/^\/r\/pics\/?$/)) {
        $(".content").text("Nope.");
    }
});

