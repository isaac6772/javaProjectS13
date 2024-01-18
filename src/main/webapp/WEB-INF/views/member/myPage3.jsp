<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage3.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/myPage3.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/member/myPage3.js"></script>
</head>
<body>
	<div class = "rightSide">
	
		<div class = "header">
			<div class = "section">
				<div>
					<a href = "${ctp}/home" target = "_top">
						<img src = "${ctp}/icon/home.png" width = 17px height = 17px />
					</a>
				</div>
				<div class = "text symbol">></div>
				<div class = "text">뉴스관리</div>
			</div>
			<div class = "myInfo">
				<div class = "col1 col">
					<img src = "${ctp}/profile/${sProfile}" />
				</div>
				<div class = "col2 col">
					<span class = "text1">${sNickName}</span>
					<span class = "text2">▼</span>
				</div>
				<div class = "col3 col"><img src = "${ctp}/icon/bell.png" width = 24px height = 22px/></div>
				<div class = "col4 col"><img src = "${ctp}/icon/message.png" width = 25px height = 20px/></div>
				<div class = "col5 col"><img src = "${ctp}/icon/menu.png" width = 20px /></div>
			</div>
		</div>
		
		<div class = "keywordContainer">
			<div class = "title">
				<span>키워드 수정</span>
			</div>
			<div class = "keywordBox">
				<c:forEach var = "keyword" items = "${fn:split(mVo.keyword,'/')}">
					<c:if test="${!empty keyword}">
						<div class = "keyword">
							<span>${keyword}</span>&nbsp;
							<span class = "delete" onclick = "deleteKeyword('${keyword}')">×</span>
						</div>
					</c:if>
				</c:forEach>
				<div class = "keyword input" id = "keywordInput">
					<input type = "text" id = "keyword" maxlength = "15" />
				</div>
				<div class = "addKeyword">
					<img src = "${ctp}/icon/plus.png" onclick = "keywordInputShow()" />
				</div>
				<div class = "saveKeyword" >
					<img src = "${ctp}/icon/save.png" onclick = "saveKeyword()" />
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>