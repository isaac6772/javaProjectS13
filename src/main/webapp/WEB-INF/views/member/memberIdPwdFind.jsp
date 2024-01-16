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
					<div class = "col2"><input type = "text" id = "name" /></div>
				</div>
				<div class = "row row2">
					<div class = "col1">이메일</div>
					<div class = "col2"><input type = "text" id = "email" /></div>
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn" onclick = "findId()">아이디찾기</div>
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
					<div class = "col2"><input type = "text" id = "mid" /></div>
				</div>
				<div class = "row row2">
					<div class = "col1">이메일</div>
					<div class = "col2"><input type = "text" id = "email2" /></div>
				</div>
				<div class = "row row3">
					<div class = "col1">인증코드</div>
					<div class = "col2"><input type = "text" id = "mailCode" /></div>
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn btn1" onclick = "mailCodeSend()">
					<span>인증코드 발송</span>
				</div>
				<div class = "btn btn2" onclick = "mailCodeResend()">
					<span>재발송</span>
				</div>
				<div class = "btn btn3" onclick = "mailCodeCheck()">
					<span>인증확인</span>
				</div>
				<div id = "loading"><img src = "${ctp}/util/loading.gif" /></div>
				<div id = "timer"></div>
			</div>
			
			<form class = "table pwdResetForm" action = "${ctp}/member/memberPwdReset" name = "pwdResetForm" method = "post">
				<div class = "row row1">
					<div class = "col1">새비밀번호</div>
					<div class = "col2">
						<input type = "password" name = "pwd" id = "pwd" />
						<span id = "pwdMsg" class = "msg">비밀번호가 형식에 맞지않습니다.</span>
					</div>
				</div>
				<div class = "row row2">
					<div class = "col1">비밀번호확인</div>
					<div class = "col2">
						<input type = "password" id = "pwd2" />
						<span id = "pwd2Msg" class = "msg">비밀번호가 일치하지 않습니다.</span>
					</div>
				</div>
				<div>
					<div class = "btn" onclick = "savePwd()">저장</div>
				</div>
				<input type = "hidden" name = "email" id = "email3" value = "" />
			</form>
			
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>