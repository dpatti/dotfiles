//quit if we're not at an index page
if (document.location.href.indexOf("res") != -1)
    return;

var date = new Date();
date.setTime(date.getTime()+(2*24*60*60*1000));
var cook = date.toGMTString();
date.setTime(date.getTime()-(3*24*60*60*1000));
var del = date.toGMTString();

function hidePost(node){
    node.nextUntil("br[clear]").hide();
    node.prev().prev().prev().prevUntil(".filesize").hide();
}

function showPost(node){
    node.nextUntil("br[clear]").show();
    node.prev().prev().prev().prevUntil(".filesize").show();	
}

$("span").each(function(){
    var id = $(this).attr("id");
    if(id != "" && id.indexOf("nothread") != -1){
        var action; //what action can be taken on the post
        if (document.cookie.indexOf(id) != -1){
            //was hiding
            action = "Show";
            //also actually hide the post while we're here
            hidePost($(this));
        } else {
            //was showing
            action = "Hide";
        }
        $(this).find("a:last").before("<span class='hide'><a href='javascript:;'>"+action+"</a>]</span>[");
            $(this).find(".hide a").click(function(){
                var node = $(this).parent().parent();
                var id = node.attr("id");
                if (document.cookie.indexOf(id) != -1){
                    //now showing
                    showPost(node);
                    $(this).text("Hide");
                    document.cookie = id+"=; expires="+del+"; path=/";
                } else {
                    //now hiding
                    hidePost(node);
                    $(this).text("Show");
                    document.cookie = id+"=true; expires="+cook+"; path=/";
                }
            });
    }
});

