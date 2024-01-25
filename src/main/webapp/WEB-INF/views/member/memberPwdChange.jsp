<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberPwdChange.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberPwdChange.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
	</script>
	<script src = "${ctp}/js/member/memberPwdChange.js"></script>
</head>
<body>
	<div class = "rightSide">
		<div class = "header">
			<div class = "section">
				<div>
					<a href = "${ctp}/home" target = "_top">
						<img src = "${ctp}/icon/home.png" width = 17px height = 17px />
					</a>
				</div>
				<div class = "text symbol">></div>
				<div class = "text">
					<a href = "${ctp}/member/myPage1">계정관리</a>
				</div>
				<div class = "text symbol">></div>
				<div class = "text">비밀번호 변경</div>
				<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
			</div>
		</div>
		<div class = "submenu1">
			<div class = "row1 row">
				<div class = "col1">
					<img src = "${ctp}/icon/info.png" width = 22px />
					<span class = "text1">개인정보</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberUpdate'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row2 row">
				<div class = "col1">
					<img src = "${ctp}/icon/password.png" width = 22px />
					<span class = "text1">비밀번호</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberPwdChange'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row3 row">
				<div class = "col1">
					<img src = "${ctp}/icon/leave.png" width = 23px />
					<span class = "text1">회원탈퇴</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberDelete'">탈퇴</div>
				</div>
			</div>
		</div>
		<div class = "pwdChangeContainer">
			<form class = "pwdChangeForm" name = "pwdChangeForm" method = "post">
				<div class = "row">
					<div class = "col1">현재 비밀번호</div>
					<div class = "col2">
						<input type = "password" name = "pwd" id = "pwd" placeholder = "기존비밀번호를 입력해주세요" maxlength = 15 />
					</div>
				</div>
				<div class = "row2 row">
					<div class = "col1">새 비밀번호</div>
					<div class = "col2">
						<input type = "password" name = "newPwd" id = "newPwd" placeholder = "영어, 숫자, 특수문자 조합 4~15자" maxlength = 15 />
						<div id = "newPwdMsg" class = "msg"></div>
					</div>
				</div>
				<div class = "row3 row">
					<div class = "col1">새 비밀번호 확인</div>
					<div class = "col2">
						<input type = "password" name = "newPwd2" id = "newPwd2" placeholder = "영어, 숫자, 특수문자 조합 4~15자" maxlength = 15 />
						<div id = "newPwd2Msg" class = "msg"></div>
					</div>
				</div>
				<div class = "row4">
					<div class = "col1">
						<div class = "pwdChangeBtn" onclick = "pwdChange()">수정</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>