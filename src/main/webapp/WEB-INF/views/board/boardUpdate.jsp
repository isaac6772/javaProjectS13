<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardUpdate.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/board/boardUpdate.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/ckeditor/ckeditor.js"></script>
	<script src = "${ctp}/js/board/boardUpdate.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "boardUpdateContainer">
		
		<form class = "updateContainer" name = "updateForm" method = "post">
		
			<div class = "titleBox">
				<div class = "row1">
					<select name = "part">
						<option ${vo.part=='일반'?'selected':''}>일반</option>
						<option ${vo.part=='일상'?'selected':''}>일상</option>
						<option ${vo.part=='스포츠'?'selected':''}>스포츠</option>
						<option ${vo.part=='연예'?'selected':''}>연예</option>
					</select>
				</div>
				<div class = "row2">
					<input type = "text" name = "title" placeholder = "제목을 입력해주세요." value = "${vo.title}" />
				</div>
			</div>
			
			<div class = "infoBox">
				욕설, 비방, 다른 사람을 불쾌하게 하는 게시물은 경고없이 삭제될 수 있습니다.
			</div>
			
			<div class = "ckeditor">
				<textarea name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea>
			</div>
			
			<div class = "btnBox" onclick = "updateFormSubmit()">
				<div class = "btn btn1">수정</div>
			</div>
			
			<input type = "hidden" name = "nickName" value = "${sNickName}" />
			<input type = "hidden" name = "memberIdx" value = "${sIdx}" />
			<input type = "hidden" name = "idx" value = "${vo.idx}" />
		</form>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>