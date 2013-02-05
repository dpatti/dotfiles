$('.panel.navigation-thumbs').hide();

// Left/right arrows are bound to document in the other jQuery instance, so
// catch it before they can and stop it
$('body').bind('keydown', function(e){ console.log(e.target); e.stopPropagation(); });

// And no homepage gallery
$('.panel.left').remove();
