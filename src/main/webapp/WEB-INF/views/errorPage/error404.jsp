<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>error404.jsp</title>
</head>
<body>
	<div style = "margin : 100px auto; width : 60%;">
		<div style = "text-align : center; font-size : 30px; font-weight : bolder;">에러가 발생하였습니다(에러코드:404)</div>
		<div style = "text-align : center; margin-top : 50px; margin-bottom : 70px;">
			<img src = "${ctp}/icon/error.png" />
		</div>
		<div style = "text-align : center;">
			<a href = "${ctp}/home">돌아가기</a>
		</div>
	</div>
</body>
</html>