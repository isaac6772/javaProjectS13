<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<script src = "${ctp}/js/member/memberUpdate.js"></script>
</head>
<body>
	<div class = "memberUpdateContainer">
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
				<div class = "text">개인정보</div>
				<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
			</div>
		</div>
		<div class = "title">
			<span>회원정보</span>
		</div>
		<div class = "box box1">
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
				<div class = "save">
					<img src = "${ctp}/icon/check.png" width = "20px" id = "saveNick" onclick = "saveNickName()" />
				</div>
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
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveName" onclick = "saveName()" /></div>
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
					<div id = "msg"></div>
				</div>
				<div id = "loading"><img src = "${ctp}/util/loading.gif" width = "20px" /></div>
				<div class = "update mailBox mailSend">
					<input type = "text" name = "codeSend" id = "codeSend" />
					<div class = "mailCodeBtn" id = "mailCodeBtn2">확인</div>
				</div>
				<div id = "timer"></div>
				<div class = "col3"><img src = "${ctp}/icon/gt.png" width = "16px" onclick = "updateEmail(this)" /></div>
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveEmail" onclick = "saveEmail()" /></div>
			</div>
		</div>
		<div class = "title">
			<span>활동내역</span>
		</div>
		<div class = "box box2">
			<div class = "row">
				<div class = "col1">가입일자</div>
				<div class = "col2">
					<fmt:parseDate value = "${vo.joinDate}" pattern = "yyyy-MM-dd" var = "parsedDate" />
					<fmt:formatDate value="${parsedDate}" pattern = "yyyy년 M월 d일" var = "formattedDate" />
					${formattedDate}
				</div>
			</div>
			<div class = "row">
				<div class = "col1">포인트</div>
				<div class = "col2">${vo.point}</div>
			</div>
			<div class = "row">
				<div class = "col1">총방문횟수</div>
				<div class = "col2">${vo.visitCnt}</div>
			</div>
			<div class = "row">
				<div class = "col1">작성글개수</div>
				<div class = "col2"></div>
			</div>
			<div class = "row">
				<div class = "col1">작성댓글개수</div>
				<div class = "col2"></div>
			</div>
			<div class = "row">
				<div class = "col1">받은추천수</div>
				<div class = "col2"></div>
			</div>
			<div class = "row">
				<div class = "col1">받은비추천수</div>
				<div class = "col2"></div>
			</div>
		</div>
	</div>
</body>
</html>