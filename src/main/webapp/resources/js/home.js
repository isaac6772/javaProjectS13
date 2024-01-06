'use strict';
		
$(function() {
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
		location.href = contextPath + "/member/memberLogout";
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
		location.href = contextPath + "/member/myPageIframe?myPage=memberUpdate";
	});
	$('#myPage2').click(function() {
		location.href = contextPath + "/member/myPageIframe?myPage=myPage1";
	});
	$('#adminPage').click(function() {
		location.href = contextPath + "/admin/adminMain";
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
});