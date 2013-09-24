$('.cls_continue').on('click',function(){
if($('#id_jodi').val()!=0 || $.trim($('#id_jodi_custom').val())!=''){
    if($('#id_jodi').val()!=0 && $.trim($('#id_jodi_custom').val())!=''){
        alert('Kindly create one Jodi to proceed');
    }else{
        $('.cls_box').dialog({width:550,autoOpen:false,height:300,modal:true});
        $('.cls_box').dialog('open');
    }

}else{
        alert('Kindly create your Jodi to proceed');
}

});


$('.cls_continue_mob').on('click',function(e){
    e.preventDefault();
    if(!$(this).hasClass('cls_skip'))
    {
        $('input[name=mobile_no]').val($('#cls_mob').val());
    }else {
        $('input[name=mobile_no]').val('');
    }
    $('#user_jodi').submit();
});


$('.shareagain').on('click',function(){
    var j = $(this);
    j.SRC = 'http://www.pointeeworld.com/wallpost/';
    j.DATA = {'sharenow':j.data('jodiid')};
    $f.makeRequest(j,function(r){
        if(r.message == 1){

            $('.cls_msg').dialog({width:500,autoOpen:false,height:200,modal:true});
            $('.cls_msg').dialog('open');
            $('.right_just').css({height:'100px'});
        }
    });
})