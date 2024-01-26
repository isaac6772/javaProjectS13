<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberInfo.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberInfo.css" />
	<script src = "${ctp}/js/member/memberInfo.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "memberInfoContainer">
	
		<div class = "title">
			<span>회원정보</span>
		</div>
		<div class = "box box1">
			<div class = "row">
				<div class = "col1">아이디</div>
				<div class = "col2">${(vo.userInfo=='n' && vo.idx != sIdx && sLevel != 77) ? '(비공개)' : vo.mid}</div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">닉네임</div>
				<div class = "col2">${(vo.userInfo=='n' && vo.idx != sIdx && sLevel != 77) ? '(비공개)' : vo.nickName}</div>
				<div class = "update">
					<input type = "text" name = "nickName" id = "nickName" />
					<span class = "inValidMsg"></span>
				</div>
				<div class = "save">
					<img src = "${ctp}/icon/check.png" width = "20px" id = "saveNick" onclick = "saveNickName()" />
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">이름</div>
				<div class = "col2">${(vo.userInfo=='n' && vo.idx != sIdx && sLevel != 77) ? '(비공개)' : vo.name}</div>
				<div class = "update">
					<input type = "text" name = "name" id = "name" />
					<span class = "inValidMsg"></span>
				</div>
				<div class = "save"><img src = "${ctp}/icon/check.png" width = "20px" id = "saveName" onclick = "saveName()" /></div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">성별</div>
				<div class = "col2">${(vo.userInfo=='n' && vo.idx != sIdx && sLevel != 77) ? '(비공개)' : vo.gender}</div>
			</div>
			<div class = "line"></div>
			<div class = "row">
				<div class = "col1">이메일</div>
				<div class = "col2">${(vo.userInfo=='n' && vo.idx != sIdx && sLevel != 77) ? '(비공개)' : vo.email}</div>
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
				<div class = "col2">${vo.boardCnt}</div>
			</div>
			<div class = "row">
				<div class = "col1">작성댓글개수</div>
				<div class = "col2">${vo.replyCnt}</div>
			</div>
			<div class = "row">
				<div class = "col1">받은추천수</div>
				<div class = "col2">${vo.totGood}</div>
			</div>
			<div class = "row">
				<div class = "col1">받은비추천수</div>
				<div class = "col2">${vo.totBad}</div>
			</div>
		</div>		<!-- box2 -->
		
	</div>		<!-- memberInfoContainer -->			
</body>
</html>