<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussion.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/discussion/discussion.css" />
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
			<div class = "btn">
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
						<div class = "btn">신청하기</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>