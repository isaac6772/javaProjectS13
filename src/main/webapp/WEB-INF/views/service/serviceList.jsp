<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>service.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/service/serviceList.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "serviceContainer">
		<div class = "title">
			<div class = "text">
				<span class = "text1">고객문의게시판</span>
			</div>
			<div class = "line"></div>
		</div>
		
		<div class = "conditionBox">
			<div class = "row1"></div>
			<div class = "search">
				<div class = "col1">
					<select>
						<option>제목</option>
						<option>내용</option>
						<option>제목+내용</option>
					</select>
				</div>
				<div class = "col2">
					<input type = "text" />
				</div>
				<div class = "btn">
					<img src = "${ctp}/icon/searchW.png" />
				</div>
			</div>
			<div class = "writeBox">
				<div class = "btn" onclick = "location.href = 'serviceInput'">글쓰기</div>
			</div>
		</div>
		
		<div class = "serviceList">
			<div class = "tableHeader">
				<div class = "col col1">
					<span>번호</span>
				</div>
				<div class = "col col2">
					<span>제목</span>
				</div>
				<div class = "col col3">
					<span>작성자</span>
				</div>
				<div class = "col col4">
					<span>작성일</span>
				</div>
				<div class = "col col5">
					<span>답변</span>
				</div>
			</div>
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>