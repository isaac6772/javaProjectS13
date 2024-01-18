'use strict';
let colors = ['#ec4d4d','#f99236','#7ddc02','#23c226','#23c28b','#23bdc2','#2374c2','#2345c2','#8623c2','#e70086'];

$(function() {
	// 키워드 색깔 랜덤 지정
	let items = $('.keyword');
	
	for(let item of items) {
		let random = Math.floor(Math.random()*10);
		$(item).css('background-color',colors[random]);
	}
	
});

function keywordInputShow() {
	$('#keywordInput').show();
	$('#keywordInput input').focus();
	$('.addKeyword').hide();
	$('.saveKeyword').show();
}

function saveKeyword() {
	if($('#keyword').val().trim()=='') {
		alert("키워드를 입력해주세요");
		return false;
	}
	
	$.ajax({
		url : contextPath + "/member/inputKeyword",
		type : "post",
		data : {keyword : $('#keyword').val().trim()},
		success : function(res) {
			if(res==0) {
				alert("이미 존재하는 키워드입니다.");
			}
			else {
				location.reload();
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function deleteKeyword(keyword) {
	$.ajax({
		url : contextPath + "/member/deleteKeyword",
		type : "post",
		data : {keyword : keyword},
		success : function() {
			location.reload();
		},
		error : function() {
			alert("전송오류");
		}
	});
}