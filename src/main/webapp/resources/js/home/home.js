'use strict';

let url = window.location.host;	//		웹브라우저의 주소창의 포트까지 가져옴(localhost:9090)
let pathname = window.location.pathname; //		 '/'부터 오른쪽에 있는 모든 경로(/javaProjectS13)
let appCtx = pathname.substring(0, pathname.indexOf("/",2));
let root = url+appCtx;
let ws;

$(function() {
	$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", alarmTotCntCalc);
	
	$('#login').on('click',function() {
		let mid = $('#mid').val().trim();
		let pwd = $('#pwd').val().trim();
		
		if(mid==''||pwd=='') {
			alert("아이디 또는 비밀번호를 입력해주세요");
			return false;
		}
		loginForm.submit();
	});
	$('#logout').click(function() {
		location.href = appCtx + "/member/memberLogout";
	});
	$('.loginToggleBox').click(function() {
		if($('.loginToggleBox').hasClass('checked')) {
			$('.loginToggleBox').removeClass('checked');
			idSave.value = "n";
		}
		else {
			$('.loginToggleBox').addClass('checked');
			idSave.value = "y";
		}
	});
	$('#myPage1').click(function() {
		location.href = appCtx + "/member/myPageIframe?myPage=memberUpdate";
	});
	$('#myPage2').click(function() {
		location.href = appCtx + "/member/myPageIframe?myPage=myPage1";
	});
	$('#adminPage').click(function() {
		location.href = appCtx + "/admin/adminMain?src=dashboard";
	});
	
	// 레벨 진행도 계산
	let progress = '0';
	if(maxExp!='0') progress = exp/maxExp*100 + '%';
	else progress = '100%';
	
	$('.progressBar').css('width',progress);
	
	// 비밀번호 입력창에서 엔터키 누르면 로그인 되는 기능
	$('#pwd').keyup(function(e) {
		if(e.keyCode == 13) {
			$('#login').click();
		}
	})
	
	// 슬라이드 이미지
	let slide = document.getElementById("adImgBox");
	let index = 0;
	let itemCnt = $('.adImgBox .item').length;
	
	setInterval(autoSlide,3000);
	
	function autoSlide() {
		index += 100;
		if(index==100) slide.style.transition = "transform 0.3s";
		
		if(index==100*itemCnt) {
			slide.style.transition = "none";
			index = 0;
			slide.style.transform = "translateX(-"+index+"%)";
		}
		else slide.style.transform = "translateX(-"+index+"%)";
	}
	
	// 현재 접속 중인 친구의 수
	let loginFriendCnt = $('.friendList .friend .login').length;
	$('#loginFriendCnt').html(loginFriendCnt);
	
	// 뉴스 리스트 불러오기(문서가 모두 로딩된후)
	loadKeywordNews(keyword);
	
	// 뉴스 모달 닫기
	$('.newsModalContainer').click(function(e) {
		if(e.target == document.getElementById("newsModal")) $('.newsModalContainer').hide();
	});
	
	// 뉴스 모달 닫기
	$(document).keydown(function(e) {
		if(e.keyCode=='27') {
			$('.newsModalContainer').hide();
		}
	})
	
	// 워드클라우드 모듈불러오기
	zingchart.MODULESDIR = 'https://cdn.zingchart.com/modules/';
	
	//워드클라우드 환경설정
	var myConfig = {
		type: 'wordcloud',
		options: {
		    words: JSON.parse(wordCloud),
			minLength: 5,
		 	ignore: [""],
		 	maxItems: 70,
		 	aspect: 'spiral', // 'flow-top' | 'flow-center'
		  
		 	colorType: 'palette',
		 	palette: ['#8BC34A','#673AB7','#FF9800','#4CAF50','#D32F2F', '#5D4037', '#1976D2', '#E53935', '#6D4C41', '#1E88E5', '#F44336', '#795548', '#2196F3', '#EF5350', '#8D6E63', '#42A5F5'],
		  
		 	style: {
		  		fontFamily: 'Crete Round',
				tooltip: {
					text: '%text: %hits',
			 		visible: false,
			        alpha: 0.9,
			        backgroundColor: '#1976D2',
			        borderRadius: 2,
			        borderColor: 'none',
			        fontColor: 'white',
			        fontFamily: 'Georgia',
			        textAlpha: 1
				}
			}
		},
	  
		source: {
	    	//text: '--President Barack Obama<br> Selma 50th anniversary speech<br>March 7, 2015',
	    	//Source: https://obamawhitehouse.archives.gov/the-press-office/2015/03/07/remarks-president-50th-anniversary-selma-montgomery-marches
	    	fontColor: '#64B5F6',
	    	fontSize: 10,
	    	fontFamily: 'Georgia',
	    	fontWeight: 'normal',
	    	marginBottom: '10%'
	 	}
	};
	
	//워드클라우드 렌더링
	zingchart.render({
		id: 'myChart',
		data: myConfig,
	    height: 400,
	    width: '100%'
	});
	
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

function loadKeywordNews(keyword) {
	$('#loadLayer').load(appCtx + "/keywordNews?keyword=" + keyword + " #newsList");
}

function prevBoard() {
	let index = $('#hotPag').html() - 1;
	if(index>=1) {
		$('.slideBox').css("transform","translateX(-"+(index-1)*100+"%)");
		$('#hotPag').html(index);
	}
}

function nextBoard() {
	let index = $('#hotPag').html() - 1;
	if(index<=1) {
		$('.slideBox').css("transform","translateX(-"+(Number(index)+1)*100+"%)");
		$('#hotPag').html(index+2);
	}
}

function partChange(part) {
	$('#recentBoard').load(appCtx + "/recentBoard?part="+part+' #boardLoad');
}

function newsModalShow(e) {
	let content = $(e).find('.articleContent').html();
	$('#newsModalContent').html(content);
	$('.newsModalContainer').show();
}

function privateChat(friendIdx, myIdx, friendNickName) {
	$('.comunityBox .listGroup').hide();
	$('.comunityBox .chatGroup').show();
	$('.comunityBox .privateChat').css('display','flex');
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
	$('.comunityBox .listGroup').show();
	$('.comunityBox .chatGroup').hide();
	$('.comunityBox .privateChat').hide();
	
	$('.friendList').load(appCtx + "/friendList?idx=" + memberIdx + " .friend");
	
	ws.close();
}

function alarmFormShow() {
	if($('.memberBox .alarmForm').is(':hidden')) {
		$('.memberBox .alarmForm').show();
		
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
		$('.memberBox .alarmForm').hide();
		$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", alarmTotCntCalc);
	}
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

function deleteAlarm(idx) {
	$.ajax({
		url : appCtx + "/member/deleteAlarm",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==1) {
				$('#alarmLoadLayer').load(appCtx + "/member/alarmList" + " .alarm", alarmTotCntCalc);
			}
			else alert("삭제실패");
		},
		error : function() {
			alert("전송오류");
		}
	});
}