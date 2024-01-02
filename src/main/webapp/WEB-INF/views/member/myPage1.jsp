<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage1.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/myPage1.css" />
</head>
<body>
	<div class = "rightSide">
		<div class = "submenu1">
			<div class = "row1 row">
				<div class = "col1">
					<img src = "${ctp}/icon/info.png" />
					<span class = "text1">내정보</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberUpdate'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row2 row">
				<div class = "col1">
					<img src = "${ctp}/icon/password.png" />
					<span class = "text1">비밀번호</span>
				</div>
				<div class = "col2">
					<div class = "btn">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row3 row">
				<div class = "col1">
					<img src = "${ctp}/icon/leave.png" />
					<span class = "text1">회원탈퇴</span>
				</div>
				<div class = "col2">
					<div class = "btn">탈퇴</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>