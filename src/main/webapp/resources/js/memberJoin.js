'use strict';
let midFlag = false;
let pwdFlag = false;
let pwd2Flag = false;
let nickNameFlag = false;
let nameFlag = false;
let emailFlag = false;

let regMid = /^[a-zA-Z0-9]{4,15}$/;
let regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<"'])[\w"'`~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<]{4,15}$/;
let regNickName = /^[\w가-힣]{2,7}$/;
let regName = /^[가-힣]{1,20}$/;

let totalTime;
let intervalId;
let minute;
let second;

$(function() {
	$('#mid').keyup(function() {
		if(regMid.test($('#mid').val().trim())) {
			$.ajax({
				url : contextPath + "/member/memberMidCheck",
				data : {mid : $('#mid').val().trim()},
				type : "post",
				success : function(res) {
					if(res==0) {
						midFlag = false;
						$('#mid').removeClass("valid");
						$('#mid').addClass("inValid");
						$('#mid').next().html("중복된 아이디가 존재합니다.");
					}
					else {
						midFlag = true;
						$('#mid').removeClass("inValid");
						$('#mid').addClass("valid");
						$('#mid').next().html("");
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
		else {
			midFlag = false;
			$('#mid').removeClass("valid");
			$('#mid').addClass("inValid");
			$('#mid').next().html("아이디가 형식에 맞지 않습니다.");
		}
	});
	$('#pwd').keyup(function() {
		if(regPwd.test($('#pwd').val().trim())) {
			pwdFlag = true;
			$('#pwd').removeClass("inValid");
			$('#pwd').addClass("valid");
			$('#pwd').next().html("");
		}
		else {
			pwdFlag = false;
			$('#pwd').removeClass("valid");
			$('#pwd').addClass("inValid");
			$('#pwd').next().html("비밀번호가 형식에 맞지 않습니다.");
		}
	});
	$('#pwd2').keyup(function() {
		if($('#pwd').val()==$('#pwd2').val()) {
			pwd2Flag = true;
			$('#pwd2').removeClass("inValid");
			$('#pwd2').addClass("valid");
			$('#pwd2').next().html("");
		}
		else {
			pwd2Flag = false;
			$('#pwd2').removeClass("valid");
			$('#pwd2').addClass("inValid");
			$('#pwd2').next().html("비밀번호가 일치하지 않습니다.");
		}
	});
	$('#nickName').keyup(function() {
		if(regNickName.test($('#nickName').val().trim())) {
			$.ajax({
				url : contextPath + "/member/memberNickCheck",
				data : {nickName : $('#nickName').val().trim()},
				type : "post",
				success : function(res) {
					if(res==0) {
						nickNameFlag = false;
						$('#nickName').removeClass("valid");
						$('#nickName').addClass("inValid");
						$('#nickName').next().html("중복된 닉네임이 존재합니다.");
					}
					else {
						nickNameFlag = true;
						$('#nickName').removeClass("inValid");
						$('#nickName').addClass("valid");
						$('#nickName').next().html("");
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
		else {
			nickNameFlag = false;
			$('#nickName').removeClass("valid");
			$('#nickName').addClass("inValid");
			$('#nickName').next().html("닉네임이 형식에 맞지 않습니다.");
		}
	});
	$('#name').keyup(function() {
		if(regName.test($('#name').val().trim())) {
			nameFlag = true;
			$('#name').removeClass("inValid");
			$('#name').addClass("valid");
			$('#name').next().html("");
		}
		else {
			nameFlag = false;
			$('#name').removeClass("valid");
			$('#name').addClass("inValid");
			$('#name').next().html("이름이 형식에 맞지 않습니다.");
		}
	});
	$('.mailSend').click(function() {
		if($('#email').val().trim()=='') {
			alert("이메일을 입력해주세요");
			return false;
		}
		$('#timer').html('<img src = "'+contextPath+'/util/loading.gif" width = "27px" height = "27px" />')
		$('#email').prop('readonly',true);
		$('#email').css('background-color','lightgray');
		totalTime = 30;
		
		$.ajax({
			url : contextPath + "/member/mailCodeSend",
			type : "post",
			data : {email : $('#email').val()},
			success : function(res) {
				if(res==1) {
					clearInterval(intervalId);
					intervalId = setInterval(updateTime,1000);
				}
				else alert("메일전송실패");
			},
			error : function() {
				alert("전송오류");
			}
		});
		
		function updateTime() {
			minute = (Math.floor(totalTime/60)+"").length==1 ? '0' + Math.floor(totalTime/60) : Math.floor(totalTime/60);
			second = (totalTime%60+"").length==1 ? '0' + totalTime%60 : totalTime%60;
			$('#timer').html(minute + " : " + second);
			totalTime--;
			if(totalTime<0) {
				clearInterval(intervalId);
				$('#timer').html("시간초과");
			}
		}
	});
	$('.mailCode').on('click',function() {
		if(totalTime<=0) {
			alert("인증시간이 초과되었습니다. 메일코드를 재발급받아주세요");
			return false;
		}
		
		$.ajax({
			url : contextPath + "/member/mailCodeCheck",
			type : "post",
			data : {mailCode : $('#emailCode').val().trim()},
			success : function(res) {
				if(res==0) {
					alert("메일코드를 발급받으세요");
				}
				else if(res==1) {
					alert("메일이 인증되었습니다.");
					emailFlag = true;
					clearInterval(intervalId);
					$('#timer').html("");
					$('.mailCode').off('click');
					$('.mailCode').removeClass('mailCode');
					$('.mailSend').off('click');
					$('.mailSend').removeClass('mailSend');
					
					$('#emailCode').prop('readonly',true);
					
					$('#emailCode').css('background-color','lightgray');
				}
				else {
					alert("인증코드가 일치하지 않습니다.");
				}
			},
			error : function() {
				alert("전송오류");
			}
		})
	});
	$('.joinButton').on('click', function() {
		if(midFlag==false) $('#mid').addClass("inValid");
		if(pwdFlag==false) $('#pwd').addClass("inValid");
		if(pwd2Flag==false) $('#pwd2').addClass("inValid");
		if(nickNameFlag==false) $('#nickName').addClass("inValid");
		if(nameFlag==false) $('#name').addClass("inValid");
		if(emailFlag==false) alert("메일인증을 해주세요");
		if(midFlag==true&&pwdFlag==true&&pwd2Flag==true&&nickNameFlag==true&&nameFlag==true&&emailFlag==true) {
			joinForm.submit();
		}
	})
});