<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>header.jsp</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/header.css" />
</head>
<body>
	<div class = "headerContainer">
		<div class = "logo">
			<a href = "${ctp}/">
				<img src = "${ctp}/icon/homepageLogo.png" />
			</a>
		</div>
		<div class = "searchBarBox">
			<div class = "searchBar">
				<div class = "icon">
					<img src = "${ctp}/icon/search.png" />
				</div>
				<div class = "search">
					<input type = "text" name = "search" id = "search" autofocus />
				</div>
			</div>
		</div>
	</div>
</body>
</html>