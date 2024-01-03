<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberUpdate.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberUpdate.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict'
		let contextPath = "${ctp}";
		let nickName = '${vo.nickName}';
		let name = '${vo.name}';
		let email = '${vo.email}';
	</script>
	<script src = "${ctp}/js/memberUpdate.js"></script>
</head>
<body>
	<div class = "memberUpdateContainer">
		<div class = "title">
			<span>회원정보</span>
		</div>
		<div class = "box">
			<div class = "row">
				<div class = "col1">아이디</div>
				<div class = "col2">${vo.mid}</div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">닉네임</div>
				<div class = "col2">${vo.nickName}</div>
				<div class = "update">
					<input type = "text" name = "nickName" id = "nickName" />
					<span class = "inValidMsg"></span>
				</div>
				<div class = "col3"><img src = "${ctp}/icon/gt.png" width = "16px" onclick = "updateNickName(this)" /></div>
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveNick" onclick = "saveNickName(this)" /></div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">이름</div>
				<div class = "col2">${vo.name}</div>
				<div class = "update">
					<input type = "text" name = "name" id = "name" />
					<span class = "inValidMsg"></span>
				</div>
				<div class = "col3"><img src = "${ctp}/icon/gt.png" width = "16px" onclick = "updateName(this)" /></div>
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveName" onclick = "saveName(this)" /></div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">성별</div>
				<div class = "col2">${vo.gender}</div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">이메일</div>
				<div class = "col2">${vo.email}</div>
				<div class = "update mailBox">
					<input type = "text" name = "email" id = "email" />
					<div class = "mailCodeBtn" id = "mailCodeBtn1">인증코드</div>
				</div>
				<div class = "update mailBox mailSend">
					<input type = "text" name = "emailSend" id = "emailSend" />
					<div class = "mailCodeBtn" id = "mailCodeBtn2">확인</div>
				</div>
				<div class = "col3"><img src = "${ctp}/icon/gt.png" width = "16px" onclick = "updateEmail(this)" /></div>
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveEmail" onclick = "saveEmail(this)" /></div>
			</div>
		</div>
		<div class = "title">
			<span>활동내역</span>
		</div>
		<div class = "box">
			활동내역
		</div>
	</div>
</body>
</html>