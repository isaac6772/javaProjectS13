<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>serviceInput.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/service/serviceInput.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/service/serviceInput.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "serviceInputContainer">
	
		<div class = "title">
			<div class = "text">
				<span class = "text1" onclick = "location.href = 'serviceList'">고객문의게시판</span>
			</div>
			<div class = "line"></div>
		</div>
		
		<form name = "myForm" class = "contentContainer" method = "post" enctype = "multipart/form-data">
			<div class = "row row1">
				<div class = "col col1">
					<span>제목</span>
				</div>
				<div class = "col col2">
					<input type = "text" id = "title" name = "title" />
				</div>
			</div>
			<div class = "row">
				<div class = "col col1">
					<span>분류</span>
				</div>
				<div class = "col col2">
					<input type = "radio" name = "part" value = "일반문의" checked />건의사항
					<input type = "radio" name = "part" value = "광고문의" />광고문의
				</div>
			</div>
			<div class = "row">
				<div class = "col col1">
					<span>공개</span>
				</div>
				<div class = "col col2">
					<input type = "radio" value = "비공개" name = "open" checked />비공개
					<input type = "radio" value = "공개" name = "open" />공개
				</div>
			</div>
			<div class = "row row4">
				<div class = "col col1">
					<span>문의내용</span>
				</div>
				<div class = "col col2">
					<textarea class = "content" name = "content" id = "content"></textarea>
				</div>
			</div>
			<div class = "row row5">
				<div class = "col col1">
					<span>파일첨부</span>
				</div>
				<div class = "col col2">
					<input type = "file" name = "fileList" multiple onchange = "fileValid()" id = "file" />
				</div>
			</div>
			<input type = "hidden" value = "${sIdx}" name = "memberIdx" />
			<input type = "hidden" value = "${sNickName}" name = "nickName" />
		</form>
		
		<div class = "btnBox">
			<div class = "btn" onclick = "formSubmit()">문의하기</div>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>