<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdPwdFind.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberIdPwdFind.css">
	<script>
		'use strict'
		let contextPath = "${ctp}";
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src = "${ctp}/js/member/memberIdPwdFind.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "idPwdFindContainer">
		<div class = "title">
			계정정보 찾기
		</div>
		
		<div class = "idFindBox">
			<div class = "subject">
				<div class = "item item1">아이디찾기</div>
				<div class = "item item2" onclick = "pwdFindBoxShow()">비밀번호 찾기</div>
				<div class = "line"></div>
			</div>
			<div class = "table">
				<div class = "row row1">
					<div class = "col1">이름</div>
					<div class = "col2"><input type = "text" /></div>
				</div>
				<div class = "row row2">
					<div class = "col1">이메일</div>
					<div class = "col2"><input type = "text" /></div>
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn">아이디찾기</div>
			</div>
		</div>
		
		<div class = "pwdFindBox">
			<div class = "subject">
				<div class = "item item1" onclick = "idFindBoxShow()">아이디찾기</div>
				<div class = "item item2">비밀번호 찾기</div>
				<div class = "line"></div>
			</div>
			<div class = "table">
				<div class = "row row1">
					<div class = "col1">아이디</div>
					<div class = "col2"><input type = "text" /></div>
				</div>
				<div class = "row row2">
					<div class = "col1">이메일</div>
					<div class = "col2"><input type = "text" /></div>
				</div>
				<div class = "row row3">
					<div class = "col1">인증코드</div>
					<div class = "col2"><input type = "text" /></div>
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn">인증코드 발송</div>
			</div>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>