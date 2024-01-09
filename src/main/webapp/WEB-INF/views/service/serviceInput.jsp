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
	<script src = "${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		$(function() {
			CKEDITOR.replace("content",{
	    		height : 480,
	    		filebrowserUploadUrl:"${ctp}/imageUpload",
	    		uploadUrl : "${ctp}/imageUpload"		
	    	});
		});
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "serviceInputContainer">
	
		<div class = "title">
			<div class = "text">
				<span class = "text1">고객문의게시판</span>
			</div>
			<div class = "line"></div>
		</div>
		
		<textarea rows="6" name="content" id="CKEDITOR" required></textarea>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>