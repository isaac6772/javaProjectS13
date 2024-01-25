let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
let appCtx = pathname.substring(0, pathname.indexOf("/",2));
let root = url+appCtx;

$(function() {
	$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend", chatAlarmTotCntCalc);
	$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", alarmTotCntCalc);
	
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
	});
});

function settingFormShow() {
	if($('.userInfo .settingForm').is(':hidden')) {
		$('.userInfo .optionForm').hide();
		$('.userInfo .settingForm').show();
	}
	else $('.userInfo .settingForm').hide();
}

function chattingFormShow() {
	if($('.userInfo .chattingForm').is(':hidden')) {
		$('.userInfo .optionForm').hide();
		$('.userInfo .chattingForm').show();
		
		$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend");
	}
	else $('.userInfo .chattingForm').hide();
}

function alarmFormShow() {
	if($('.userInfo .alarmForm').is(':hidden')) {
		$('.userInfo .optionForm').hide();
		$('.userInfo .alarmForm').show();
		
		$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", function() {
			$.ajax({
				url : appCtx + "/member/alarmRead",
				success : function() {
					alarmTotCntCalc();
				},
				error : function() {
					alert("전송오류");
				}
			});
		});
	}
	else {
		$('.userInfo .alarmForm').hide();
		$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", alarmTotCntCalc);
	}
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
		$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend", chatAlarmTotCntCalc);
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

function chatAlarmTotCntCalc() {
	let sum = 0;
	for(let e of $('.chatAlarmCnt')) {
		sum += Number($(e).html());
	}
	if(sum != 0) {
		$('#chatAlarmTotal').show();
		$('#chatAlarmTotal').html(sum);	
	}
	else $('#chatAlarmTotal').hide();
}

function alarmTotCntCalc() {
	let length = 0;
	length = $('.alarm.noRead').length;
	if(length != 0) {
		$('#alarmTotal').show();
		$('#alarmTotal').html(length);	
	}
	else $('#alarmTotal').hide();
}
