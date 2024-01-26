'use strict';

$(function() {
	$('#nickNameSearch').keyup(function() {
		let word = $('#nickNameSearch').val().trim();
		
		for(let e of $('.friend')) {
			let data = $(e).find('.nickName').text();
			
			if(data.indexOf(word)==-1) $(e).hide();
			else $(e).show();
		}
		
	});
})

function listMenuShow() {
	$('.friendRequest').hide();
	$('.myfriendList').show();
	$('.listMenu').addClass('selected');
	$('.requestMenu').removeClass('selected');
}

function requestMenuShow() {
	$('.myfriendList').hide();
	$('.friendRequest').show();
	$('.listMenu').removeClass('selected');
	$('.requestMenu').addClass('selected');
}

function acceptFriend(idxWho) {
	$.ajax({
		url : contextPath + "/member/acceptFriend",
		data : {
			idxWho : idxWho
		},
		type : "post",
		success : function() {
			alert("친구 요청이 수락되었습니다.");
			location.href = 'myPage2?pag=1';
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function denyFriend(idx) {
	$.ajax({
		url : contextPath + "/member/denyFriend",
		data : {idx : idx},
		type : "post",
		success : function() {
			location.href = 'myPage2?pag=1';
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function deleteFriend(idx) {
	let ans = confirm("친구를 정말로 삭제하시겠습니까?");
	if(!ans) return false;
	
	$.ajax({
		url : contextPath + "/member/deleteFriend",
		data : {idx : idx},
		type : "post",
		success : function() {
			location.href = 'myPage2?pag=0';
		},
		error : function() {
			alert("전송오류");
		}
	});
}