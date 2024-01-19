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
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>