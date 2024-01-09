<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminMain.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/adminMain.css" />
</head>
<body>
	<div class = "adminMainContainer">
		<div class = "mainNav">
			<div class = "logo">
				<a href = "${ctp}/home">
					<img src = "${ctp}/icon/homepageLogoW.png" />
				</a>
			</div>
			<div class = "line"></div>
			<div class = "menu">
				<div class = "col1">
					<img src = "${ctp}/icon/homeW.png" />
				</div>
				<div class = "col2">
					<a href = "dashboard" target = "mainContent">
						<span class = "text1">대시보드</span>
					</a>
				</div>
			</div>
			<div class = "menu">
				<div class = "col1">
					<img src = "${ctp}/icon/memberW.png" />
				</div>
				<div class = "col2">
					<a href = "memberManager" target = "mainContent">
						<span class = "text1">회원관리</span>
					</a>
				</div>
			</div>
			<div class = "menu">
				<div class = "col1">
					<img src = "${ctp}/icon/boardW.png" />
				</div>
				<div class = "col2">
					<span class = "text1">게시판관리</span>
				</div>
			</div>
			<div class = "menu">
				<div class = "col1">
					<img src = "${ctp}/icon/reportW.png" />
				</div>
				<div class = "col2">
					<span class = "text1">신고관리</span>
				</div>
			</div>
			<div class = "menu">
				<div class = "col1">
					<img src = "${ctp}/icon/adW.png" />
				</div>
				<div class = "col2">
					<span class = "text1">광고관리</span>
				</div>
			</div>
			<div class = "profileBox">
				<div class = "profile">
					<div class = "col1">
						<img src = "${ctp}/profile/${sProfile}" />
					</div>
					<div class = "col2">
						<div>
							<span class = "text1">${sNickName}</span>
						</div>
						<div>
							<span class = "text2">${sEmail}</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<iframe src = "${param.src}" name = "mainContent" id = "mainContent"></iframe>
	</div>
</body>
</html>