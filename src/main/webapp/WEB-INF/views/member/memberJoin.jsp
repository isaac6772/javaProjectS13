<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberJoin.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/memberJoin.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
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
		
		let intervalId;
		let totalTime;
		let minute;
		let second;
		
		$(function() {
			$('#mid').keyup(function() {
				if(regMid.test($('#mid').val().trim())) {
					midFlag = true;
					$('#mid').removeClass("inValid");
					$('#mid').addClass("valid");
					$('#mid').next().html("");
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
					pwdFlag = true;
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
					nickNameFlag = true;
					$('#nickName').removeClass("inValid");
					$('#nickName').addClass("valid");
					$('#nickName').next().html("");
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
				$('#timer').html('<img src = "${ctp}/util/loading.gif" width = "27px" height = "27px" />')
				
				totalTime = 30;
				
				$.ajax({
					url : "${ctp}/member/mailCodeSend",
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
					url : "${ctp}/member/mailCodeCheck",
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
							$('#email').prop('readonly',true);
							$('#emailCode').prop('readonly',true);
							$('#email').css('background-color','lightgray');
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
		});
		
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "memberJoinContainer">
		<div class = "joinTitle">회원가입</div>
		<form name = "joinForm" id = "joinForm" method = "post">
			<div class = "row">
				<div class = "column1">아이디</div>
				<div class = "column2">
					<input type = "text" name = "mid" id = "mid" />
					<div class = "msg"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>비밀번호</span></div>
				<div class = "column2">
					<input type = "password" name = "pwd" id = "pwd" />
					<div class = "msg"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>비밀번호 확인</span></div>
				<div class = "column2">
					<input type = "password" id = "pwd2" />
					<div class = "msg"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>닉네임</span></div>
				<div class = "column2">
					<input type = "text" name = "nickName" id = "nickName" />
					<div class = "msg"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>이름</span></div>
				<div class = "column2">
					<input type = "text" name = "name" id = "name" />
					<div class = "msg"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>이메일</span></div>
				<div class = "column2">
					<div class = "mailBox">
						<input type = "text" name = "email" id = "email" />
						<div class = "mailCodeBtn mailSend">인증코드발송</div>
					</div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>매일인증코드</span></div>
				<div class = "column2 mail">
					<div class = "mailCodeBox">
						<input type = "text" name = "emailCode" id = "emailCode" placeholder = "메일로 전송된 코드를 입력해주세요" />
						<div class = "mailCodeBtn mailCode">인증하기</div>
					</div>
					<div id = "timer"></div>
				</div>
			</div>
			<div class = "row">
				<div class = "column1"><span>성별</span></div>
				<div class = "column2">
					<input type = "radio" class = "radio" name = "radio" id = "radio1" checked /><span>남자</span>
					<input type = "radio" class = "radio" name = "radio" id = "radio2" /><span>여자</span>
				</div>
			</div>
			<div class = "buttonBox">
				<div class = "joinButton">회원가입</div>
			</div>
		</form>
	</div>
	
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>