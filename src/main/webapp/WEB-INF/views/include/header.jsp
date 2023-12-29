<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>header.jsp</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/header.css" />
</head>
<body>
	<div class = "headerContainer">
		<div>
			<a href = "${ctp}/">
				<img src = "${ctp}/util/logo.png" width = "75px" />
				<span>TALK HUB</span>
			</a>
		</div>
	</div>
</body>
</html>