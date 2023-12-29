<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "homeContainer">
		<div class = "leftSide">
			<div class = "wordCloudBox">
			
			</div>
			<div class = "boardBox">
			
			</div>
			<div class = "debateBox">
			
			</div>
		</div>
		<div class = "rightSide">
			<div class = "loginBox">
				<span>로그인</span>
				<div class = "line"></div>
				<input type = "text" name = "mid" id = "mid" placeholder = "아이디" />
				<input type = "password" name = "pwd" id = "pwd" placeholder = "비밀번호" />
				<div class = "idSaveBox">
					<span>아이디 저장</span>
				</div>
				<div id = "login">
					<span>로그인</span>
				</div>
				<div class = "joinFind">
					<span><a href = "${ctp}/member/memberJoin">회원가입</a></span> | <span><a href = "#">아이디/비밀번호 찾기</a></span>
				</div>
				<div class = "line"></div>
				<div class = "kakaoLogin">
					<span>카카오 계정으로 로그인</span>
				</div>
			</div>
			<div class = "adBox">
			
			</div>
			<div class = "comunityBox">
			
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>
