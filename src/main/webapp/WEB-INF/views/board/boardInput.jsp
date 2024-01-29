<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardInput.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/board/boardInput.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/ckeditor/ckeditor.js"></script>
	<script src = "${ctp}/js/board/boardInput.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "boardInputContainer">
		
		<form class = "inputContainer" name = "inputForm" method = "post">
		
			<div class = "titleBox">
				<div class = "row1">
					<select name = "part">
						<option>일반</option>
						<option>일상</option>
						<option>스포츠</option>
						<option>연예</option>
						<c:if test="${sLevel==77}">
							<option style = "color : red;font-weight : bolder">공지</option>
						</c:if>
					</select>
				</div>
				<div class = "row2">
					<input type = "text" name = "title" placeholder = "제목을 입력해주세요." />
				</div>
			</div>
			
			<div class = "infoBox">
				욕설, 비방, 다른 사람을 불쾌하게 하는 게시물은 경고없이 삭제될 수 있습니다.
			</div>
			
			<div class = "ckeditor">
				<textarea name="content" id="CKEDITOR" class="form-control" required></textarea>
			</div>
			
			<div class = "btnBox" onclick = "inputFormSubmit()">
				<div class = "btn btn1">글등록</div>
			</div>
			
			<input type = "hidden" name = "nickName" value = "${sNickName}" />
			<input type = "hidden" name = "memberIdx" value = "${sIdx}" />
		</form>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>