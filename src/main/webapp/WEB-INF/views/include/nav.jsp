<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>nav.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/nav.css" />
</head>
<body>
	<div class = "navContainer">
		<div class = "mainMenu">
			<div class = "menuItem">
				<div class = "row1">
					<img src = "${ctp}/icon/news.png" />
				</div>
				<div class = "row2">
					<span>뉴스</span>
				</div>
			</div>
			<div class = "menuItem">
				<div class = "row1">
					<img src = "${ctp}/icon/debate.png" />
				</div>
				<div class = "row2">
					<span>토론</span>
				</div>
			</div>
			<div class = "menuItem item3" onclick = "location.href = '${ctp}/board/boardList'">
				<div class = "row1">
					<img src = "${ctp}/icon/board.png" />
				</div>
				<div class = "row2">
					<span>게시판</span>
				</div>
			</div>
			<div class = "menuItem">
				<div class = "row1">
					<img src = "${ctp}/icon/comunity.png" />
				</div>
				<div class = "row2">
					<span>커뮤니티</span>
				</div>
			</div>
			<div class = "menuItem" onclick = "location.href = '${ctp}/service/serviceList'">
				<div class = "row1">
					<img src = "${ctp}/icon/service.png" />
				</div>
				<div class = "row2">
					<span>고객센터</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>