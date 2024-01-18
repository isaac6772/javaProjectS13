<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Home.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/news/news.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
	</script>
	<script src = "${ctp}/js/news/news.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "newsContainer">
		
		<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
		
		<div class = "keywordContainer">
			<div class = "keywordBox">
				<c:forEach var = "keyword" items = "${fn:split(mVo.keyword,'/')}">
					<c:if test="${!empty keyword}">
						<div class = "keyword">
							<span>${keyword}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<div class = "newsList">
			<c:forEach var = "vo" items = "${nVos}">
				<div class = "article">
					<div class = "img">
						<img src = "${vo.fileName}" width = 100px height = 100px />
					</div>
					<div>
						${vo.title}
					</div>
				</div>
			</c:forEach>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>