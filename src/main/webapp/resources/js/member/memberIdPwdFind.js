function pwdFindBoxShow() {
	$('.idFindBox').hide();
	$('.pwdFindBox').show();
}

function idFindBoxShow() {
	$('.idFindBox').show();
	$('.pwdFindBox').hide();
}

function findId() {
	let name = $('#name').val().trim();
	let email = $('#email').val().trim();
	
	if(name=='') {
		alert("이름을 입력해주세요");
		return false;
	}
	else if(email=='') {
		alert("이메일을 입력해주세요");
		return false;
	}
	
	$.ajax({
		url : "memberIdFind",
		type : "post",
		data : {
			name : name,
			email : email
		},
		success : function(res) {
			if(res==0) alert("일치하는 회원정보가 없습니다.");
			else alert("검색결과 : " + res);
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function mailCodeSend() {
	let mid = $('#mid').val().trim();
	let email = $('#email2').val().trim();
	
	if(mid=='') {
		alert("아이디를 입력해주세요");
		return false;
	}
	else if(email=='') {
		alert("이메일을 입력해주세요");
		return false;
	}
	
	$('#loading').show();
	totalTime = 15;
	
	$.ajax({
		url : "memberPwdFind",
		type : "post",
		data : {
			mid : mid,
			email : email
		},
		success : function(res) {
			if(res==0) {
				$('#loading').hide();
				alert("일치하는 회원정보가 없습니다.");	
			}
			else {
				$('#loading').hide();
				$('.pwdFindBox .row3').css("display","flex");
				$('.pwdFindBox #mid').prop('readonly',true);
				$('.pwdFindBox #mid').css('backgroundColor','#f1f1f1;');
				$('.pwdFindBox #email2').prop('readonly',true);
				$('.pwdFindBox #email2').css('backgroundColor','#f1f1f1;');
				$('.pwdFindBox .btnBox .btn1').hide();
				$('.pwdFindBox .btnBox .btn2').show();
				$('.pwdFindBox .btnBox .btn3').show();
				minute = Math.floor(totalTime/60);
				second = totalTime%60;
				$('#timer').html(minute + " : " + second);
				$('#timer').show();
				intervalId = setInterval(timecount,1000);
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}

function mailCodeResend() {
	clearInterval(intervalId);
	totalTime = 15;
	$('#loading').css("left","62%");
	$('#loading').show();
	$('#timer').hide();
	
	$.ajax({
		url : "memberPwdFind",
		type : "post",
		data : {
			mid : $('#mid').val().trim(),
			email : $('#email2').val().trim()
		},
		success : function(res) {
			if(res==0) {
				$('#loading').hide();
				alert("일치하는 회원정보가 없습니다.");	
			}
			else {
				$('#loading').hide();
				minute = Math.floor(totalTime/60);
				second = totalTime%60;
				$('#timer').html(minute + " : " + second);
				$('#timer').show();
				intervalId = setInterval(timecount,1000);
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}

let intervalId;
let totalTime = 15;
let minute;
let second;

function timecount() {
	totalTime--;
	if(totalTime<=0) {
		clearInterval(intervalId);
		$('#timer').html("시간초과");
		return false;
	}
	minute = Math.floor(totalTime/60);
	second = totalTime%60;
	$('#timer').html(minute + " : " + second);
}

function mailCodeCheck() {
	let mailCode = $('#mailCode').val().trim();
	if(totalTime<=0) {
		alert("인증시간이 만료되었습니다.");
		return false;
	}
	
	$.ajax({
		url : contextPath + "/member/memberJoin/mailCodeCheck",
		data : {mailCode : mailCode},
		type : "post",
		success : function(res) {
			if(res==0) {
				alert("메일코드를 발급받으세요.");
			}
			else if(res==1) {
				alert("메일이 인증되었습니다.");
				$('.btnBox').hide();
				$('.pwdResetForm').show();
			}
			else if(res==2) {
				alert("인증코드가 일치하지 않습니다.");
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}

let pwdFlag = false;
let pwd2Flag = false;
let regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<"'])[\w"'`~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<]{4,15}$/;

function savePwd() {
	pwdConfirm();
	pwd2Confirm();
	if(pwdFlag && pwd2Flag) {
		$('#email3').val($('#email2').val().trim());
		pwdResetForm.submit();
	}
}

function pwdConfirm() {
	let pwd = $('#pwd').val().trim();
	if(!regPwd.test(pwd)) {
		pwdFlag = false;
		$('#pwdMsg').show();
	}
	else {
		pwdFlag = true;
		$('#pwdMsg').hide();
	}
}

function pwd2Confirm() {
	let pwd = $('#pwd2').val().trim();
	if(pwd!=$('#pwd').val().trim()) {
		pwd2Flag = false;
		$('#pwd2Msg').show();
	}
	else {
		pwd2Flag = true;
		$('#pwd2Msg').hide();
	}
}

$(function() {
	$('#pwd').keyup(function() {
		pwdConfirm();
	});
	
	$('#pwd2').keyup(function() {
		pwd2Confirm();
	});
})