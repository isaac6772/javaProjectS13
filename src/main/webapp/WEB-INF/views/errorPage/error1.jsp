<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page errorPage="/WEB-INF/views/errorPage/errorMessage1.jsp" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>error1.jsp</title>
</head>
<body>
	<h2>에러를 발생시켜주는 JSP페이지</h2>
<%
	int su = 10 / 0;
%>
	결과 : <%=su %><br/>
	<div>
		<a href = "errorMain" class = "btn btn-success">돌아가기</a>
	</div>
</body>
</html>