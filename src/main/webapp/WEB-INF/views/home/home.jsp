<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Home.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/home.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
	<script src="https://kit.fontawesome.com/0989d78570.js" crossorigin="anonymous"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
		let exp = '${mVo.exp}';
		let maxExp = '${maxExp}';
		let keyword = '${keyword}';
		let wordCloud = '${wordCloud}';
	</script>
	<script src = "${ctp}/js/home/home.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "homeContainer">
		<div class = "leftSide">
			<jsp:include page="/WEB-INF/views/home/news.jsp" />
			<jsp:include page="/WEB-INF/views/home/wordCloud.jsp" />
			<jsp:include page="/WEB-INF/views/home/board.jsp" />
		</div>
		<div class = "rightSide">
			<div class = "stickBox">
				<jsp:include page="/WEB-INF/views/home/login.jsp" />
				<jsp:include page="/WEB-INF/views/home/community.jsp" />
				<jsp:include page="/WEB-INF/views/home/ad.jsp" />
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>
