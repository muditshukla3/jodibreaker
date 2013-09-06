$clientData = {};
$clientData.xhr =[];
function ff() {
    var t = this;    
    t.makeRequest = function(obj,callback){
        if (typeof obj == undefined) {
            return;
        }
        if (obj.SRC == '') {
            return;
        }
        callback = callback || function(){}
        obj.method = obj.METHOD || 'POST';
        obj.clientcashing = obj.clientcashing || false 
        obj.dataType = obj.DATATYPE || 'json';
        obj.url = obj.SRC || '';
        obj.data = obj.DATA || '';
        obj.headers = obj.HEADERS || '';
        obj.contentType = obj.CONTENTTYPE || 'application/x-www-form-urlencoded; charset=UTF-8';
        obj.cache = obj.CACHE || false;
        obj.beforeSend = obj.BEFORESEND || function(){};
        obj.async = obj.ASYNC || true;
        obj.callback403 = obj.CALLBACK403 || function () {
            try{
                obj.loc = top.window.location;
            }catch(e){
                obj.loc = window.parent.top.location;
            }
             obj.loc = obj.loc.href;

        }
        obj.callback500 = obj.CALLBACK500 || function(r){};
        
        if ($clientData.xhr[obj.url] == undefined || !obj.clientcashing) {
            $.ajax({
                url: obj.url,
                type: obj.method,
                dataType : obj.dataType,
                data : obj.data,
                header : obj.header,
                contentType : obj.contentType,
                cache : obj.cache,
                beforeSend : obj.beforeSend,
                async : obj.async,
                processData: obj.PROCESSDATA || true
            }).done(function(r) {
                $clientData.xhr[obj.url] = r;
                callback(r);           
            }).fail(function(xmlReq, textStatus, errorThrown){
    
                }).always(function(xhr,statusText){
                switch (xhr.status) {
                    case 200:
                        break;
                    case 403:
                        obj.callback403();
                        break;
                    case 500:
                        obj.callback500();
			    
                }
            });
        }else{
            callback($clientData.xhr[obj.url]);
        }
    
        
        
    }
    
    t.popup =function(obj,callback){
	
        if (typeof obj.div == undefined) {
            return;
        }
        callback = callback || function(){};
        obj.autoopen = obj.autoopen || false;
        obj.closeOnEscape = obj.closeOnEscape || true;
        obj.dialogClass = obj.dialogClass || '';
        obj.height = obj.height || 'auto';
        obj.maxheight = obj.maxheight || $(window).height()/2;
        obj.maxwidth = obj.maxwidth || $(window).width()/2;
        obj.minHeight = obj.minHeight || 150;
        obj.minWidth = obj.minWidth || 150;
        obj.modal = obj.modal || true;
        obj.closeText = obj.closeText || "close";
        obj.position = obj.position || '{my : "center", at : "center", of : "bottom"}';
        obj.resizable = obj.resizable || true;
        obj.title = obj.title || '';
        obj.width = obj.width || 300;
        obj.beforeClose = obj.beforeClose || function(){};
        obj.close = obj.close || function(){};
        obj.create = obj.create || function(){};
        obj.focus = obj.focus || function(){};
        obj.open = obj.open || function(){};
	
	
        obj.div.dialog({
            autoOpen: obj.autoopen, 
            closeOnEscape : obj.closeOnEscape,
            dialogClass : obj.dialogClass, 
            height : obj.height,
            maxheight : obj.maxheight, 
            maxwidth : obj.maxwidth,
            minHeight : obj.minHeight, 
            minWidth : obj.minWidth,
            modal : obj.modal, 
            position : obj.position,
            resizable : obj.resizable, 
            title: obj.title,
            width : obj.width, 
            beforeClose : obj.beforeClose,
            close : obj.close, 
            create : obj.create,
            focus : obj.focus, 
            open : obj.open			
        });
	
        obj.div.dialog('open');
        callback();
	
    }
    
}

var $f = new ff();