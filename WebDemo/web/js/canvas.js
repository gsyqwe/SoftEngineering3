$(function(){
 
    $(".parent").hover(function(){
        $(this).find(".son").finish();
        $(this).find(".son").slideDown(200);
        this.style.background="yellowgreen";
    },function(){
        $(this).find(".son").finish();
        $(this).find(".son").slideUp(200);
        this.style.background="lightseagreen";
    })
    //清空
    $(".xpc li").click(function(){
        var w=$(this).attr("data-role");
        var h=$(this).attr("data-role");
        obj.xp($(".xp"),w,h);
    })
    
    ///收起
    var flag=true;
    $(".sq").click(function(e){
        if(flag){
            $(".parent:not(.sq)").css({
                display:"none"
            })
            $(".sq").html("&#xe61c;");
            flag=false;
        }else{
            $(".parent:not(.sq)").css({
                display:"block"
            })
            $(".sq").html("&#xe61b;");
            flag=true;
        }
    })

})