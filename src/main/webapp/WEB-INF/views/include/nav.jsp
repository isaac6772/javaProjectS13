<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>nav.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/nav.css" />
</head>
<body>
	<div class = "navContainer">
		<div class = "navMenu">
			<a href = "#">뉴스</a>
			<a href = "#">토론</a>
			<a href = "#">게시판</a>
			<a href = "#">커뮤니티</a>
			<a href = "#">고객센터</a>
		</div>
	</div>
</body>
</html>