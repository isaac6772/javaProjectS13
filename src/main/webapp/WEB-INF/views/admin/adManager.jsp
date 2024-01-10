<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/adManager.css" />
</head>
<body>
	
	<div class = "adManagerContainer">
		
		<div class = "box1">
			<div class = "col1">
				<div class = "row1">
					<span>선택가능한 광고</span>
				</div>
				<div class = "row2">
				
				</div>
				<div class = "row3">
					<div class = "relative">
						<input type = "checkbox" /><span>전체선택</span>
					</div>
					<div class = "btn">선택삭제</div>
				</div>
			</div>
			<div class = "col2">
				<div class = "btn">
					<span class = "text1">선택</span>
					<span class = "text2">▶</span>
				</div>
			</div>
			<div class = "col3">
				<div class = "row1">
					<span>게시중인 광고</span>
				</div>
				<div class = "row2">
				
				</div>
				<div class = "row3">
					<div class = "relative">
						<input type = "checkbox" /><span>전체선택</span>
					</div>
					<div class = "btn">선택취소</div>
				</div>
			</div>
		</div>
		
		<div class = "line"></div>
		
		<div class = "btnBox">
			<div class = "btn">확인</div>
		</div>
		
	</div>
	
</body>
</html>