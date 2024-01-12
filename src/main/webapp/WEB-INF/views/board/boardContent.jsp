<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/board/boardContent.css" />
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/board/boardContent.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "boardContentContainer">
	
		<div class = "btnContainer">
			<div class = "btn">
				<img src = "${ctp}/icon/arrowT.png" />
				<span>이전글</span>
			</div>
			<div class = "btn">
				<img src = "${ctp}/icon/arrowB.png" />
				<span>다음글</span>
			</div>
			<div class = "btn">목록</div>
		</div>
	
		<div class = "contentContainer">
			<div class = "part">
				<span>${vo.part}</span>
			</div>
			<div class = "title">
				<span>${vo.title}</span>
			</div>
			<div class = "profile">
				
			</div>
			<div class = "line"></div>
			<div class = "content">
				${vo.content}
			</div>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>