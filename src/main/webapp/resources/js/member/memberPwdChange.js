'use strict'

let regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<"'])[\w"'`~!@#$%^&*()_\-+=\|\]\[}{;:/?.>,<]{4,15}$/;
let pwdFlag = false;
let pwd2Flag = false;

$(function() {
	$('#newPwd').keyup(function() {
		pwdCheck();
	});
	$('#newPwd2').keyup(function() {
		pwd2Check();
	});
});

function pwdCheck() {
	if(regPwd.test($('#newPwd').val().trim())) {
			pwdFlag = true;
			$('#newPwdMsg').html('');
	}
	else {
		pwdFlag = false;
		$('#newPwdMsg').html('비밀번호의 형식이 올바르지 않습니다.');
	}
}

function pwd2Check() {
	if($('#newPwd').val().trim()==$('#newPwd2').val().trim()) {
		pwd2Flag = true;
		$('#newPwd2Msg').html("");
	}
	else {
		pwd2Flag = false;
		$('#newPwd2Msg').html("비밀번호가 일치하지 않습니다.");
	}
}

function pwdChange() {
	pwdCheck();
	pwd2Check();
	
	if(pwdFlag==false||pwd2Flag==false) return false;
	
	pwdChangeForm.submit();
}

