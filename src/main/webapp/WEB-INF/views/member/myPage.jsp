<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage.jsp</title>
	<style>
		body {
			margin : 0px;
			padding : 0px;
		}
		.myPageContainer {
			width : 65%;
			height : 100vh;
			margin : 0 auto;
			display : flex;
		}
		.leftSide {
			width : 330px;
			box-shadow: 1px 1px 16px 0 rgba(0,0,0,.16);
			padding : 20px;
		}
		.leftSide a {
			color : black;
			text-decoration: none;
		}
		.leftSide .logo .text1 {
			font-weight: bolder;
			font-size : 22px;
			vertical-align: top;
			margin-left : -7px;
		}
	</style>
</head>
<body>
	<div class = "myPageContainer">
		<div class = "leftSide">
			<a href = "${ctp}/home" class = "logo">
				<img src = "${ctp}/util/logo.png" width = "25px" height = "29px" />
				<span class = "text1">TALK HUB</span>
			</a>
		</div>
		<div class = "rightSide">
		
		</div>
	</div>
</body>
</html>