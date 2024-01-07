<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/memberManager.css" />
</head>
<body>
	<div class = "memberManagerContainer">
		<div class = "title">
			<img src = "${ctp}/icon/" />
			<span>회원 리스트</span>
		</div>
		<div class = "condition">
			
		</div>
		<div class = "result">
			<span>검색결과 : 총 12명 검색되었습니다.</span>
		</div>
		<div class = "memberList">
		
		</div>
	</div>
</body>
</html>