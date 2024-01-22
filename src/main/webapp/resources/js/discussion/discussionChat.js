'use strict';

$(function () {
 	let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
 	let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
 	let appCtx = pathname.substring(0, pathname.indexOf("/",2));
 	let root = url+appCtx;
 	
	let ws = new WebSocket("ws://"+root+"/chat");
	
    ws.onopen = function() {
        $('#chatStatus').text('Info: connection opened.');
 
        $('input[name=chatInput]').on('keydown', function(e){
            if(e.keyCode==13){
                let msg = $('input[name=chatInput]').val();
                ws.send(msg);
                $('input[name=chatInput]').val('');
            }
        });
    };
    ws.onmessage = function(e) {
        $('textarea').prepend(e.data+'\n');
    };
    ws.onclose = function() {
        $('#chatStatus').text('Info: connection closed.');
    };
});