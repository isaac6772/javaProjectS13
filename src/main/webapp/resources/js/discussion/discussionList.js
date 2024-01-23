'use strict';

$(function() {
	$(document).keydown(function(e) {
		if(e.keyCode==27) $('.discussionModalContainer').hide();
	});
	
	$('#partNews').change(function() {
		if($('#partNews').prop('checked')==true) {
			$('.modalContent .link').css('display','flex');	
			$('#link').focus();
		}
	});
	
	$('#partFree').change(function() {
		if($('#partFree').prop('checked')==true) $('.modalContent .link').css('display','none');
	});
	
	$('#file').change(function(e) {
		let file = $('#file').val();
		let ext = file.substring(file.lastIndexOf('.')+1);
		let maxSize = 1024 * 1024 * 5;
		
		if(ext != 'jpg' && ext != 'png' && ext != 'gif') {
			alert("jpg, png, gif 파일의 형식만 업로드 가능합니다.");
			$('#file').val("");
		}
		else if(document.getElementById("file").files[0].size > maxSize) {
			alert("5MB이하의 파일만 업로드 가능합니다.");
			$('#file').val("");
		}
		
		if(e.target.files && e.target.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#preView').attr('src',e.target.result);
			}
			reader.readAsDataURL(e.target.files[0]);
		}
		else {
			$('#preView').attr('src', contextPath + '/util/noImage.jpg');
		}
		
	});
});

function createDiscussion() {
	if(level=='') {
		alert("로그인시 이용가능한 서비스입니다.");
		return false;
	}
	$('.discussionModalContainer').show();
}

function hideForm() {
	discussionForm.reset();
	$('.discussionModalContainer').hide();
}

function makeDiscussion() {
	if($('#subject').val().trim()=='') {
		alert("제목을 입력해주세요");
		return false;
	}
	else if($('#partNews').prop('checked')==true && $('#link').val().trim()=='') {
		alert("링크를 입력해주세요");
		return false;
	}
	else if($('#discussionDate').val().trim()=='') {
		alert("날짜를 입력해주세요");
		return false;
	}
	else if($('#file').val()=='') {
		alert("썸네일 사진을 등록해주세요");
		return false;
	}
	
	discussionForm.submit();
}

function reservation(idx) {
	$.ajax({
		url : contextPath + "/discussion/reservation",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==0) {
				alert("입장 30분전에는 예약하실 수 없습니다.");
				location.reload();
			}
			else if(res==1){
				alert("에약되었습니다.");
				location.reload();
			}
			else {
				alert("로그인 후 이용바랍니다.");
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}
