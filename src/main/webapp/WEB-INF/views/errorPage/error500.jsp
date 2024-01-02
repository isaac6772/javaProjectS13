<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>error500.jsp</title>
</head>
<body>
	<h2>에러 발생시 호출되는 페이지입니다.(error500.jsp)</h2>
	<hr/>
	<h2>현재 시스템 정비중입니다.(500에러 발생시 보이는 화면)</h2>
	<div>(사용에 불편을 드려서 죄송합니다.)</div>
	<div>빠른시일내에 복구되도록 하겠습니다.</div>
	<hr/>
	<a href = "${ctp}/errorPage/errorMain">돌아가기</a>
</body>
</html>