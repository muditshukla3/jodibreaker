$('.cls_continue').on('click',function(){

$('.cls_box').dialog({width:550,autoOpen:false,height:300,modal:true});
    $('.cls_box').dialog('open');
});


$('.cls_continue_mob').on('click',function(){

    if(!$(this).hasClass('cls_skip'))
    { $('input[name=mobile_no]').val($('#cls_mob').val());}
    else { $('input[name=mobile_no]').val('');}
    $('#user_jodi').submit();
});