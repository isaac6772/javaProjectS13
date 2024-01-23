'use strict';

$(function () {
 	let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
 	let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
 	let appCtx = pathname.substring(0, pathname.indexOf("/",2));
 	let root = url+appCtx;
 	
	let ws = new WebSocket("ws://"+root+"/chat?idx=" + idx + "&memberIdx=" + memberIdx);
	
    ws.onopen = function() {
        
    };
    ws.onmessage = function(e) {
		let data = JSON.parse(e.data);
		let msgType = JSON.parse(e.data).msgType;
		
        if(msgType=='member') {
			if(data.participant==1) {
				$('.memberBox .participant').append('<div>'+data.nickName+'</div>');
			}
			else {
				$('.memberBox .spectator').append('<div>'+data.nickName+'</div>');
			}
			console.log(data.participant);
		}
		else if(msgType=='memberList') {
			if(data.participant==1) {
				
			}
			else {
				
			}
			console.log("왜여기로 왔지?");
		}
    };
    ws.onclose = function() {
        
    };
});

function textCheck(e) {
	let length = $(e).val().length;
	$('#textLength').html(length);
	if(length!=0) {
		$('#submitBtn').addClass('clickBtn');
	}
	else $('#submitBtn').removeClass('clickBtn');
}