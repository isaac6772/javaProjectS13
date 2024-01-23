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
			let str = '<div class = "member member'+data.idx+'"><img src='+appCtx+'/profile/'+data.profile+' /><span>'+data.nickName+'</span></div>';
			if(data.participant==1) {
				$('.memberBox .participant').append(str);	
			}
			else $('.memberBox .spectator').append(str);
		}
		else if(msgType=='memberList') {
			for(let member of data.data) {
				let str = '<div class = "member member'+data.idx+'"><img src='+appCtx+'/profile/'+member.profile+' /><span>'+member.nickName+'</span></div>';
				if(member.participant==1) $('.memberBox .participant').append(str);
				else $('.memberBox .spectator').append(str);
			}
		}
		else if(msgType=='remove') {
			$('.memberBox .member' + data.idx).remove();
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