<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage2.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/myPage1.css" />
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
				<div class = "text">친구관리</div>
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
		<div class = "submenu1">
			<div class = "row1 row">
				<div class = "col1">
					<img src = "${ctp}/icon/info.png" width = 22px />
					<span class = "text1">개인정보</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberUpdate'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row2 row">
				<div class = "col1">
					<img src = "${ctp}/icon/password.png" width = 22px />
					<span class = "text1">비밀번호</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberPwdChange'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row3 row">
				<div class = "col1">
					<img src = "${ctp}/icon/leave.png" width = 23px />
					<span class = "text1">회원탈퇴</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberDelete'">탈퇴</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>