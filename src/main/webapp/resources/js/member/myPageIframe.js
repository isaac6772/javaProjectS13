'use strict';
		
function myPage(e) {
	if(e.getAttribute('href')=='myPage1') {
		$('#myPage1').css('font-weight','bolder');
		$('#myPage2').css('font-weight','normal');
		$('#myPage3').css('font-weight','normal');
	}
	else if(e.getAttribute('href')=='myPage2') {
		$('#myPage1').css('font-weight','normal');
		$('#myPage2').css('font-weight','bolder');
		$('#myPage3').css('font-weight','normal');
	}
	else if(e.getAttribute('href')=='myPage3') {
		$('#myPage1').css('font-weight','normal');
		$('#myPage2').css('font-weight','normal');
		$('#myPage3').css('font-weight','bolder');
	}
}


$(function() {
	// 추후 확장성을 고려한 코드 설계(다른 페이지 경로에서 마이페이지의 특정 페이지로 들어오는 경우)
	let myPage = document.getElementById("myPage").src;
	let strSrc = myPage.substring(myPage.lastIndexOf('/')+1);
	if(strSrc=='myPage1'||strSrc=='memberUpdate') $('#myPage1').css('font-weight','bolder');
	else if(strSrc=='myPage2') $('#myPage2').css('font-weight','bolder');
	else if(strSrc=='myPage3') $('#myPage3').css('font-weight','bolder');
	
	// 프로필 사진 등록하기
	$('#profile').change(function() {
		let file = document.getElementById("profile");
		let fName = file.value;
		let ext = fName.substring(fName.lastIndexOf('.')+1).toLowerCase();
		let maxSize = 1024 * 1024 * 10;
		
		if(fName.trim()=='') return false;
		if(file.files[0].size > maxSize) alert("10MB이하의 사진만 가능합니다.");
		else if(ext != 'jpg' && ext != 'png') alert("jpg, png 형식의 사진만 가능합니다");
		else profileForm.submit();
	})
});

function profileChangeFormShow() {
	if($('#profileChange').is(':visible')) $('#profileChange').hide()
	else $('#profileChange').show();
}

// 사용자 설정 프로필 사진 바꾸기
function customProfile() {
	$('#profile').click();
}
		