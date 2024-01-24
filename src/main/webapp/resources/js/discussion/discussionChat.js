'use strict';

let ws;



$(function () {
 	let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
 	let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
 	let appCtx = pathname.substring(0, pathname.indexOf("/",2));
 	let root = url+appCtx;
 	
	ws = new WebSocket("ws://"+root+"/chat?idx=" + idx + "&memberIdx=" + memberIdx);
	
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
			else {
				$('.memberBox .spectator').append(str);
				$('.chatBox .typing').hide();	
			}
		}
		else if(msgType=='memberList') {
			for(let member of data.data) {
				let str = '<div class = "member member'+member.idx+'"><img src='+appCtx+'/profile/'+member.profile+' /><span>'+member.nickName+'</span></div>';
				if(member.participant==1) $('.memberBox .participant').append(str);
				else $('.memberBox .spectator').append(str);
			}
		}
		else if(msgType=='remove') {
			$('.memberBox .member' + data.idx).remove();
		}
		else if(msgType=='time') {
			let minute = Math.floor(data.data/60)==0 ? '' : Math.floor(data.data/60) + '분 ';
			let second = data.data%60 + '초';
			
			if(data.option=='before') {
				$('.chatBox .subject .time').html('<span>토론 시작전까지 '+ minute + second +' 남았습니다.</span>');
			}
			else if(data.option=='start') {
				$('.chatBox .subject .time').html('<span>토론시작되었습니다.</span>');
			}
			else if(data.option=='going') {
				$('.chatBox .subject .time').html('<span>토론 종료전까지 '+ minute + second +' 남았습니다.</span>');
				$('.chatBox textarea').prop('readonly',false);
				$('.chatBox .typing').css('background-color','white');
				$('.chatBox .typing textarea').css('background-color','white');
			}
			else if(data.option=='end') {
				$('.chatBox .subject .time').html('<span>토론이 종료되었습니다.</span>');
				$('.chatBox textarea').prop('readonly',true);
				$('.chatBox .typing').css('background-color','#dbdbdb');
				$('.chatBox .typing textarea').css('background-color','#dbdbdb');
			}
		}
		else if(msgType=='msg') {
			if(data.memberIdx==memberIdx) {
				let str = '<div class = "myChat"><div class = "text">'+data.data+'</div></div>';
				$('.chatBox .chatArea').append(str);
			}
			else {
				let str = '<div class = "chat"><div class = "profile"><div class = "box"><img src = "'+appCtx+'/profile/'+data.profile+'" />';
				str += '<span>'+data.nickName+' : </span></div></div><div class = "text">'+data.data+'</div></div>';
				$('.chatBox .chatArea').append(str);
			}
			document.getElementById("chatArea").scrollTop = document.getElementById("chatArea").scrollHeight;
		}
    };
    ws.onclose = function() {
        
    };
    
    $('.chatBox .typing textarea').keyup(function(e) {
		if(e.keyCode==13) {
			$('#submitBtn').click();
		}
	});
    
});

function textCheck(e) {
	let length = $(e).val().trim().length;
	$('#textLength').html(length);
	if(length!=0) {
		$('#submitBtn').addClass('clickBtn');
	}
	else $('#submitBtn').removeClass('clickBtn');
}

function textSend(e) {
	if($(e).hasClass('clickBtn')) {
		let text = $('#textMsg').val().trim();
		text = text.replace(/\n|\r/g,"");
		let msg = "{\"msgType\":\"msg\",\"data\":\""+text+"\",\"memberIdx\":\""+memberIdx+"\",\"discussionIdx\":\""+idx+"\"}";
		ws.send(msg);
		$('#textMsg').val('');
	}
}