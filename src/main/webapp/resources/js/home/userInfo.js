let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
let appCtx = pathname.substring(0, pathname.indexOf("/",2));
let root = url+appCtx;

$(function() {
	$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend");
	$('#chatAlarmTotal').html('33');
	
	let sum = 0;
	let elements = $('.chatAlarmCnt');
	console.log(elements);
	for(let e of elements) {
		sum += $(e).html();
		console.log($(e).html());
	}
	
	$('#chatInput').keyup(function(e) {
		if(e.keyCode==13) {
			let text = $('#chatInput').val().trim();
			if(text=='') {
				$('#chatInput').val('');
				return false;
			}
			text = text.replace(/\n|\r/g,"");
			ws.send(text);
			$('#chatInput').val('');
		}
	})
});

function settingFormShow() {
	if($('.userInfo .settingForm').is(':hidden')) {
		$('.userInfo .optionForm').hide();
		$('.userInfo .settingForm').show();
	}
	else $('.userInfo .settingForm').hide();
}

function chattingFormShow(e) {
	if($('.userInfo .chattingForm').is(':hidden')) {
		$('.userInfo .optionForm').hide();
		$('.userInfo .chattingForm').show();
		
		$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend");
	}
	else $('.userInfo .chattingForm').hide();
}

function privateChat(friendIdx, myIdx, friendNickName) {
	$('.userInfo .listGroup').hide();
	$('.userInfo .chatGroup').show();
	$('.userInfo .privateChat').css('display','flex');
	$('#friendNickName').html(friendNickName);
	$('#chatInput').val('');
	$('#chatInput').focus();
	
	let roomNumber = Math.min(friendIdx,myIdx) + "/" + Math.max(friendIdx,myIdx);
	$('#chatLoadLayer').load(appCtx + "/chatRecord?roomNumber=" + roomNumber + " #chatRecord", function() {		// 채팅기록불러오기
		document.getElementById("chatRecord").scrollTop = document.getElementById("chatRecord").scrollHeight;
	});	
	
	
	ws = new WebSocket("ws://"+root+"/chat2?myIdx="+myIdx+"&friendIdx="+friendIdx);
	
	ws.onmessage = function(e) {
		let myIdx = e.data.substring(0,e.data.indexOf("/"));
		let msg = e.data.substring(e.data.indexOf("/") + 1);
		
		if(myIdx==memberIdx) {
			$('.privateChat .chatRecord').append('<div class = "me"><div class = "chat">'+msg+'</div></div>');
		}
		else {
			$('.privateChat .chatRecord').append('<div class = "you"><div class = "chat">'+msg+'</div></div>');
		}
		document.getElementById("chatRecord").scrollTop = document.getElementById("chatRecord").scrollHeight;
	}
}

function returnFriendList() {
	$('.userInfo .listGroup').show();
	$('.userInfo .chatGroup').hide();
	$('.userInfo .privateChat').hide();
	
	$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend");
	
	ws.close();
}
