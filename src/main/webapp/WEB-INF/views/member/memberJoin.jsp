<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberJoin.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberJoin.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict'
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/memberJoin.js"></script>
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
					<input type = "radio" class = "radio" value = "남자" name = "gender" id = "gender1" checked /><span>남자</span>
					<input type = "radio" class = "radio" value = "여자" name = "gender" id = "gender2" /><span>여자</span>
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