'use strict'

let regNickName = /^[\w가-힣]{2,7}$/;
let regName = /^[가-힣]{1,20}$/;
let nickNameFlag = false;
let nameFlag = false;

function updateNickName(e) {
	$('#nickName').show();
	$('#nickName').focus();
	$('#nickName').val(nickName);
	$(e).parent().hide();
	$(e).parent().prev().prev().hide();
	$(e).parent().next().show();
}
function saveNickName(e) {
	if($('#nickName').val().trim()==nickName) {
		$('#nickName').next().html("기존 닉네임과 동일합니다.");
	}
	if(nickNameFlag==true) {
		location.href = contextPath + "/member/nickNameUpdate?nickName=" + $('#nickName').val().trim();
	}
}
function updateName(e) {
	$('#name').show();
	$('#name').focus();
	$('#name').val(name);
	$(e).parent().hide();
	$(e).parent().prev().prev().hide();
	$(e).parent().next().show();
}
function saveName(e) {
	if($('#name').val().trim()==name) {
		$('#name').next().html("기존 이름과 동일합니다.");
	}
	if(nameFlag==true) {
		location.href = contextPath + "/member/memnberNameUpdate?name=" + $('#name').val().trim();
	}
}
function updateEmail(e) {
	$('#email').show();
	$('#email').focus();
	$('#email').val(email);
	$(e).parent().hide();
	$(e).parent().prev().prev().prev().hide();
	$(e).parent().next().show();
	$('#mailCodeBtn1').show();
}

$(function() {
	$('#nickName').keyup(function() {
		if($('#nickName').val().trim()==nickName) {
			$('#nickName').next().html("기존 닉네임과 동일합니다.");
			nickNameFlag = false;
		}
		else if(regNickName.test($('#nickName').val().trim())) {
			$.ajax({
				url : contextPath + "/member/memberNickCheck",
				data : {nickName : $('#nickName').val().trim()},
				type : "post",
				success : function(res) {
					if(res==0) {
						$('#nickName').next().html("중복된 닉네임이 존재합니다.");
						nickNameFlag = false;
					}
					else {
						$('#nickName').next().html("");
						nickNameFlag = true;
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
		else {
			$('#nickName').next().html("닉네임이 형식에 맞지 않습니다.");
			nickNameFlag = false;
		}
	});
	
	$('#name').keyup(function() {
		if(regName.test($('#name').val().trim())) {
			nameFlag = true;
			$('#name').next().html("");
		}
		else {
			nameFlag = false;
			$('#name').next().html("이름이 형식에 맞지 않습니다.");
		}
	});
	
	$('.mailCodeBtn').click(function() {
		//ajax메일전송처리 그리고 성공시
		$('.mailSend').show();
		$('#emailSend').show();
		$('#mailCodeBtn2').show();
	});
});