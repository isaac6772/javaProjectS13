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
		let keyword = '${keyword}';
		let flag = ${flag};
	</script>
	<script src = "${ctp}/js/news/news.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "newsContainer">
		
		<div class = "keywordContainer">
			<c:if test="${!empty keywords}">
				<div class = "description">*최근 7일 동안의 인기 검색 키워드 입니다.</div>
				<div class = "keywordBox">
					<c:forEach var = "keyword" items = "${keywords}">
						<div class = "keyword" onclick = "location.href='news?keyword=${keyword.text}'">
							<span>${keyword.text}</span>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
		
		<div class = "mainLoading"><img src = "${ctp}/util/loading2.gif" /></div>
		
		<div class = "newsGroup">
			<div class = "newsLoaderLayer">
				<div class = "newsList">
					<input type = "hidden" class = "startLocation" value = "${startLocation}" />
					<c:forEach var = "vo" items = "${nVos}">
						<div class = "article">
							<div class = "img" onclick = "newsModalShow(this)">
								<c:if test="${empty vo.fileName}">
									<img src = "${ctp}/util/noImage.jpg" width = 100px height = 100px />
								</c:if>
								<c:if test="${!empty vo.fileName}">
									<img src = "${vo.fileName}" width = 100px height = 100px />
								</c:if>
							</div>
							<div class = "title" onclick = "newsModalShow(this)">
								<div class = "text1">${vo.title}</div>
								<div class = "text2">[${vo.timeDiff}전]</div>
							</div>
							<div class = "articleContent">
								${vo.article}
								<br>
								원본링크 : <a href = "${vo.link}" target ="_blank">${vo.link}</a>
							</div>
						</div>
					</c:forEach>
				</div>		<!-- newsList -->
			</div>		<!-- newsLoaderLayer -->
			<div class = "newsMore">
				<div class = "set" onclick = "newsMore()">
					<span>더보기</span>&nbsp;
					<span><img src = "${ctp}/icon/arrowB.png" /></span>
				</div>
			</div>
		</div>		<!-- newsGroup -->
		
		<div class = "newsMoreLoading"><img src = "${ctp}/util/loading2.gif" /></div>
		
		<div class = "newsModalContainer" id = "newsModal">
			<div class = "newsContent">
				<div id = "newsModalContent"></div>
			</div>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>