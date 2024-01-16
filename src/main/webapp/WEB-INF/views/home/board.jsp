<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>board.jsp</title>
</head>
<body>
	<div class = "boardBox">
	
		<div class = "hot">
			<div class = "title">
				<span class = "text">추천글</span>
			</div>
			<div class = "line"></div>
			<div class = "boardList">
				<c:forEach var = "i" begin = "0" end = "9" varStatus = "st">
					<div class = "board item1">
						<div class = "subject">${b1Vos[i].title}</div>
						<div class = "part">${b1Vos[i].part}</div>
					</div>
				</c:forEach>
				<c:forEach var = "i" begin = "10" end = "19" varStatus = "st">
					<div class = "board item2">
						<div class = "subject">${b1Vos[i].title}</div>
						<div class = "part">${b1Vos[i].part}</div>
					</div>
				</c:forEach>
				<c:forEach var = "i" begin = "20" end = "29" varStatus = "st">
					<div class = "board item3">
						<div class = "subject">${b1Vos[i].title}</div>
						<div class = "part">${b1Vos[i].part}</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class = "recent">
			<div class = "title">
				<span class = "text">최신글</span>
			</div>
			<div class = "line"></div>
			<div class = "boardList">
				<c:forEach var = "vo" items = "${b2Vos}" varStatus = "st">
					<div class = "board">
						<div class = "subject">${vo.title}</div>
						<div class = "part">${vo.part}</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
	</div>
</body>
</html>