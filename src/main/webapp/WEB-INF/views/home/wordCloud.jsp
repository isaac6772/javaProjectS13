<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>wordCloud.jsp</title>
	<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
</head>
<body>
	<div class = "wordCloudBox">
		<div id="myChart"></div>
	</div>
</body>
</html>