<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Home.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/home.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/0989d78570.js" crossorigin="anonymous"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
		let exp = '${mVo.exp}';
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
			<jsp:include page="/WEB-INF/views/home/login.jsp" />
			<jsp:include page="/WEB-INF/views/home/community.jsp" />
			<jsp:include page="/WEB-INF/views/home/ad.jsp" />
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>
