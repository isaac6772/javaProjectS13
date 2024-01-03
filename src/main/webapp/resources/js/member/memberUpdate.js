'use strict'

let regNickName = /^[\w가-힣]{2,7}$/;
let regName = /^[가-힣]{1,20}$/;
let nickNameFlag = false;
let nameFlag = false;
let emailFlag = false;

let intervalId;
let totalTime;
let minute;
let second;

function updateNickName(e) {
	$('#nickName').show();
	$('#nickName').focus();
	$('#nickName').val(nickName);
	$(e).parent().hide();
	$(e).parent().prev().prev().hide();
	$(e).parent().next().show();
}
function saveNickName() {
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
function saveName() {
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
	$(e).parent().prev().prev().prev().prev().prev().hide();
	$(e).parent().next().show();
	$('#mailCodeBtn1').show();
}
function saveEmail() {
	if(emailFlag==false) {
		alert("메일인증을 받아주세요");
		return false;
	}
	location.href = contextPath + "/member/emailUpdate?email=" + $('#email').val().trim();
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
	
	$('#mailCodeBtn1').click(function() {
		clearInterval(intervalId);
		$('#email').prop('readonly',true);
		$('#email').css('backgroundColor','#ebebeb');
		$('.mailSend').hide();
		$('#codeSend').hide();
		$('#mailCodeBtn2').hide();
		$('#loading').show();
		$('#timer').html('');
		$.ajax({
			url : contextPath + "/member/mailCodeSend",
			data : {email : $('#email').val().trim()},
			type : "post",
			success : function(res) {
				if(res==1) {
					$('#loading').hide();
					totalTime = 30;
					intervalId = setInterval(count,1000);
					$('.mailSend').show();
					$('#codeSend').show();
					$('#mailCodeBtn2').show();
				}
			},
			error : function() {
				alert("전송오류");
			}
		});
		
		function count() {
			minute = Math.floor(totalTime/60)<10 ? '0'+ Math.floor(totalTime/60) : Math.floor(totalTime/60);
			second = totalTime%60<10 ? '0'+ totalTime%60 : totalTime%60;
			$('#timer').html(minute + " : " + second);
			totalTime--;
			if(totalTime<=0) {
				clearInterval(intervalId);
				$('#timer').html('<font style = "color:red">시간초과</font>');
			}
		}
	});
	
	$('#mailCodeBtn2').click(function() {
		if(totalTime<=0) {
			alert("인증시간이 만료되었습니다.");
			return false;	
		}
		if($('#codeSend').val().trim()=='') {
			alert("코드를 입력해주세요");
			return false;	
		}
		$.ajax({
			url : contextPath + "/member/mailCodeCheck",
			type : "post",
			data : {mailCode : $('#codeSend').val().trim()},
			success : function(res) {
				if(res==1) {
					alert("인증되었습니다");
					clearInterval(intervalId);
					$('#codeSend').prop('readonly',true);
					$('#codeSend').css("backgroundColor",'#ebebeb');
					$('#timer').html('');
					$('#mailCodeBtn1').off('click');
					$('#mailCodeBtn2').off('click');
					emailFlag = true;
				}
				else {
					alert("코드가 일치하지 않습니다.");
				}
			},
			error : function() {
				alert("전송오류");
			}
		});
	});
});