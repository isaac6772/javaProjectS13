<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/home.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/0989d78570.js" crossorigin="anonymous"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
		let exp = '${vo.exp}';
		let maxExp = '${maxExp}';
	</script>
	<script src = "${ctp}/js/home.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "homeContainer">
		<div class = "leftSide">
			<div class = "wordCloudBox">
				${param.maxExp}
			</div>
			<div class = "boardBox">
			
			</div>
			<div class = "debateBox">
			
			</div>
		</div>
		<div class = "rightSide">
			<c:if test="${empty sMid}">
				<form class = "loginBox" name = "loginForm" method = "post" action = "${ctp}/member/memberLogin">
					<div class = "title">로그인</div>
					<div class = "line"></div>
					<input type = "text" name = "mid" id = "mid" value = "${cookie.cMid.value}" placeholder = "아이디" />
					<input type = "password" name = "pwd" id = "pwd" placeholder = "비밀번호" />
					<div class = "idSaveBox">
						<div class = "loginToggleBox ${(!empty cookie.cMid.value)? 'checked' : ''}">
							<input type = "hidden" name = "idSave" id = "idSave" ${(!empty cookie.cMid.value)? 'value="y"' : 'value="n"'}/>
							<div class = "toggleBtn"></div>
						</div>
						<div class = "text">&nbsp;&nbsp;아이디 저장</div>
					</div>
					<div id = "login">
						<span>로그인</span>
					</div>
					<div class = "joinFind">
						<span><a href = "${ctp}/member/memberJoin">회원가입</a></span> | <span><a href = "#">아이디/비밀번호 찾기</a></span>
					</div>
					<div class = "line"></div>
				</form>
			</c:if>
			<c:if test="${!empty sMid}">
				<div class = "memberBox">
					<div class = "row1">프로필</div>
					<div class = "line"></div>
					<div class = "row2">
						<div class = "profile">
							<img src = "${ctp}/profile/${sProfile}" />
						</div>
						<div class = "info">
							<div class = "row1">
								<div>${sNickName}</div>
								<div class = "col2" id = "myPage1"><i class="fa-solid fa-gear" style="color: #bdc4d1;"></i></div>
							</div>
							<div class = "row2">
								<span class = "text1">레벨 : ${vo.level}</span>
								<span class = "text2">(${vo.exp} / ${maxExp})</span>
							</div>
						</div>
					</div>
					<div class = "row3">
						<div class = "progressContainer">
							<div class = "progressBar"></div>
						</div>
					</div>
					<div class = "row4">
						<span>알림</span> | <span>쪽지</span>
					</div>
					<div class = "line"></div>
					<div class = "row5">
						<div class = "col1">
							<span><i class="fa-solid fa-coins" style="color: #eacc0b;"></i> point&nbsp;</span>
							<span class = "text2">${vo.point}</span>
						</div>
						<div class = "col2">
							<span class = "text1" id = "myPage2">마이페이지</span>
						</div>
					</div>
					<div class = "row6">
						<div class = "logout" id = "logout">
							<i class="fa-solid fa-power-off" style="color: #edeff3;"></i>
							<span>로그아웃</span>
						</div>
					</div>
				</div>
			</c:if>
			<div class = "adBox">
			
			</div>
			<div class = "comunityBox">
			
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>
