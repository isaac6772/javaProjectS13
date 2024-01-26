$(function() {
	$('.replContent textarea').on('keyup',function() {
		this.style.height = 'auto';
		this.style.height = this.scrollHeight + 'px';
	});
	
	// 각 댓글에 있는 대댓글의 수를 문서로딩시에 써준다.
	for(let e of $('.replyGroup')) {
		let cnt = $(e).find('.reReply').length;
		if(cnt != 0) $(e).find('.reReplyCnt').html(cnt);
	}
	
	$(document).click(function(e) {
		if(!$(e.target).hasClass('optionIcon')) {
			$('.optionModal').hide();
		}
	});
	
	$('.reportModalContainer').click(function(e) {
		console.log("1");
		console.log(e);
		console.log(e.target);
		console.log($('.reportModal'));
		console.log($('.reportModal')[0]);
		console.log(document.getElementById('reportModal'));
		if(e.target != $('.reportModal')[0]) $('.reportModalContainer').hide();
	});
});

function reReplyFormShow(e) {
	if($(e).closest('.replyGroup').find('.reReplyForm').is(':hidden')) {
		$(e).closest('.replyGroup').find('.reReplyForm').show();
		$(e).closest('.replyGroup').find('.reReplyForm textarea').focus();
	}
	else $(e).closest('.replyGroup').find('.reReplyForm').hide();
}

function optionModalShow(e) {
	if($(e).parent().find('.optionModal').is(':hidden')) {
		$('.optionModal').hide();
		$(e).parent().find('.optionModal').show();
	}
	else $(e).parent().find('.optionModal').hide();
}

function updateReply(e,nickName,idx,boardIdx) {
	let content = $(e).closest('.replContent').find('.row2').html();
	let str = '';
	str += '<form class = "inputReply update" action = "updateReply" method = "post">';
	str += '<div class = "writer">';
	str += '<span>'+nickName+'</span></div>';
	str += '<div class = "replContent">';
	str += '<textarea placeholder = "댓글을 남겨보세요" maxlength = "1000" name = "content" required>'+content+'</textarea></div>';
	str += '<div class = "btnBox">';
	str += '<button type = "button" class = "btn btnCancel" onclick = "updateCancel(this)">취소</button>';
	str += '<button class = "btn btnUpdate" type = "submit" style = "margin-left : 5px">수정</button></div>';
	str += '<input type = "hidden" name = "idx" value = "'+idx+'" />';
	str += '<input type = "hidden" name = "boardIdx" value = "'+boardIdx+'" />';
	
	$(e).closest('.motherReply').find('.profile').hide();
	$(e).closest('.motherReply').find('.replContent').hide();
	$(e).closest('.replyGroup').find('.reReplyForm').hide();
	$(e).closest('.motherReply').append(str);
}

function updateRereply(e,nickName,idx,boardIdx) {
	let content = $(e).closest('.replContent').find('.row2').html();
	let str = '';
	str += '<form class = "inputReply update" action = "updateReply" method = "post">';
	str += '<div class = "writer">';
	str += '<span>'+nickName+'</span></div>';
	str += '<div class = "replContent">';
	str += '<textarea placeholder = "댓글을 남겨보세요" maxlength = "1000" name = "content" required>'+content+'</textarea></div>';
	str += '<div class = "btnBox">';
	str += '<button type = "button" class = "btn btnCancel" onclick = "updateCancel(this)">취소</button>';
	str += '<button class = "btn btnUpdate" type = "submit" style = "margin-left : 5px">수정</button></div>';
	str += '<input type = "hidden" name = "idx" value = "'+idx+'" />';
	str += '<input type = "hidden" name = "boardIdx" value = "'+boardIdx+'" />';
	
	$(e).closest('.reReply').find('.profile').hide();
	$(e).closest('.reReply').find('.replContent').hide();
	$(e).closest('.reReply').append(str);
}

function updateCancel(e) {
	$(e).closest('.replyBox').find('.profile').show();
	$(e).closest('.replyBox').find('.replContent').show();
	$(e).closest('.replyBox').find('form.inputReply.update').hide();
	$(e).closest('.replyBox').find('.optionModal').hide();
}

function deleteReply(e,idx, boardIdx) {
	let ans = confirm("댓글을 삭제할까요?");
	if(!ans) {
		$(e).closest('.optionModal').hide();
		return false;
	}
	
	location.href='deleteReply?idx='+idx+'&boardIdx='+boardIdx;
}

function setGood(idx) {
	$.ajax({
		url : contextPath + "/board/setGood",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==-1) {
				alert("자신의 게시물은 추천할 수 없습니다.");
			}
			else if(res==1) {
				alert("추천을 누르셨습니다.");
				$('.goodBadinfo').load(location.href + ' .goodBadinfo');
			}
			else alert("로그인 후 이용가능합니다.");
		},
		error : function() {
			alert("전송오류");
		}
	})
}

function setBad(idx) {
	$.ajax({
		url : contextPath + "/board/setBad",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==-1) {
				alert("자신의 게시물은 비추천할 수 없습니다.");
			}
			else if(res==1) {
				$('.goodBadinfo').load(location.href + ' .goodBadinfo');
				alert("비추천을 누르셨습니다.");
			}
			else alert("로그인 후 이용가능합니다.");
		},
		error : function() {
			alert("전송오류");
		}
	})
}

function cancelRecommend(idx) {
	$.ajax({
		url : contextPath + "/board/cancelRecommend",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res!=0) {
				$('.goodBadinfo').load(location.href + ' .goodBadinfo');
				alert("취소되었습니다.");
			}
			else alert("오류발생");
		},
		error : function() {
			alert("전송오류");
		}
	})
}

function memberOptionModalShow(e) {
	if($(e).parent().find('.memberOptionModal').is(':hidden')) {
		$('.memberOptionModal').hide();
		$(e).parent().find('.memberOptionModal').show();	
	}
	else $(e).parent().find('.memberOptionModal').hide();
}

function requestFriend(idx,e) {
	$(e).parent().hide();
	$.ajax({
		url : contextPath + "/member/requestFriend",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==1) {
				alert("친구요청되었습니다. 상대방이 수락하면 친구가 될 수 있습니다.");
			}
			else if(res==0) {
				alert("이미 요청 처리중입니다.");
			}
			else if(res==-1) {
				alert("이미 친구 상태입니다.");
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function report() {
	$('.reportModalContainer').show();
}