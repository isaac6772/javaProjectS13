<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussion.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/discussion/discussion.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/discussion/discussion.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "discussionContainer">
		
		<div class = "btnBox">
			<div class = "btn" onclick = "createDiscussion()">
				<img src = "${ctp}/icon/discussion.png" />				
				<span>토론개설</span>
			</div>
		</div>
		
		<div>
			<div class = "calendarBtn">
				<img src = "${ctp}/icon/calendar.png" />
			</div>
		</div>
		
		<div class = "discussionList">
			<c:forEach var = "vo" items = "${dVos}" varStatus = "">
				<div class = "discussion">
					<div class = "img">
						<img src = "${ctp}/util/noImage.jpg" />
					</div>
					<div class = "info">
						<div class = "subject">${vo.subject}</div>
						<div class = "line line1"></div>
						<div class = "row">
							<div class = "col1">토론개설자</div>
							<div class = "col2">${vo.memberIdx}</div>
						</div>
						<div class = "row">
							<div class = "col1">토론시작시간</div>
							<div class = "col2">${vo.discussionDate}</div>
						</div>
						<div class = "row">
							<div class = "col1">분류</div>
							<div class = "col2">${vo.part}</div>
						</div>
						<div class = "row">
							<div class = "col1">참가자</div>
							<div class = "col2">${vo.participant}</div>
						</div>
						<div class = "line line2"></div>
						<div class = "btn">참가하기</div>
					</div>
				</div>
			</c:forEach>
		</div>		<!-- discussionList -->
		
	</div>		<!-- discussionContainer -->
	
	<div class = "discussionModalContainer">
		<form class = "modalContent" name = "discussionForm">
			<div class = "title">
				<span>토론개설</span>
			</div>
			<div class = "row subject">
				<div class = "col1">주제</div>
				<div class = "col2">
					<input type = "text" name = "subject" id = "subject" />
				</div>
			</div>
			<div class = "row part">
				<div class = "col1">분류</div>
				<div class = "col2">
					<input type = "radio" name = "part" value = "자유">자유
					<input type = "radio" name = "part" value = "뉴스">뉴스
				</div>
			</div>
			<div class = "row link">
				<div class = "col1">링크</div>
				<div class = "col2">
					<input type = "text" name = "link" id = "link" />
				</div>
			</div>
			<div class = "row headCount">
				<div class = "col1">참가인원</div>
				<div class = "col2">
					<input type = "number" name = "headCount" id = "headCount" min = "3" max = "10" value = "3" />
				</div>
			</div>
			<div class = "row date">
				<div class = "col1">토론날짜</div>
				<div class = "col2">
					<input type = "datetime-local" name = "discussionDate" id = "discussionDate" />
				</div>
			</div>
			<div class = "row photo">
				<div class = "col1">썸네일</div>
				<div class = "col2">
					<input type = "file" name = "fileName" id = "fileName" />
				</div>
			</div>
			<div class = "row preview">
				<div class = "col1">미리보기</div>
				<div class = "col2">
					<img src = "${ctp}/util/noImage.jpg" />
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn1">만들기</div>
				<div class = "btn2" onclick = "hideForm()">취소</div>
			</div>
		</form>	<!-- modalContent -->
	</div>	 <!-- discussionModalContainer -->
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>