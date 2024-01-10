<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>serviceContent.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/service/serviceContent.css" />
	<script>
		'use strict'
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/service/serviceContent.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "serviceContentContainer">
	
		<div class = "title">
			<div class = "text">
				<span class = "text1" onclick = "location.href='serviceList'">고객문의게시판</span>
			</div>
			<div class = "line"></div>
		</div>
		
		<form class = "conditionBox" name = "conditionForm">
			<div class = "row1"></div>
			<div class = "search">
				<div class = "col1">
					<select name = "searchType">
						<option value = "title" ${pageVO.searchType=='title'?'selected':''}>제목</option>
						<option value = "content" ${pageVO.searchType=='content'?'selected':''}>내용</option>
						<option value = "all" ${pageVO.searchType=='all'?'selected':''}>제목+내용</option>
					</select>
				</div>
				<div class = "col2">
					<input type = "text" name = "searchString" value = "${pageVO.searchString}" />
				</div>
				<div class = "btn" onclick = "search()">
					<img src = "${ctp}/icon/searchW.png" />
				</div>
			</div>
			<div class = "writeBox">
				<div class = "btn" onclick = "location.href = 'serviceInput'">글쓰기</div>
			</div>
			<input type = "hidden" name = "pag" id = "pag" />
			<input type = "hidden" name = "pageSize" id = "pageSize" value = "10" />
		</form>
		
		<div class = "contentContainer">
			<div class = "row row1">
				<div class = "col col1">
					<span>제목</span>
				</div>
				<div class = "col col2">
					${vo.title}
				</div>
			</div>
			<div class = "row">
				<div class = "col col1">
					<span>분류</span>
				</div>
				<div class = "col col2">
					${vo.part}
				</div>
				<div class = "col col3">
					<span>작성시간</span>
				</div>
				<div class = "col col4">
					<fmt:parseDate var = "writeDate" value = "${vo.writeDate}" pattern = "yyyy-MM-dd HH:mm:ss" />
					<fmt:formatDate value="${writeDate}" pattern = "yyyy년 MM월 dd일 / HH시 mm분" />
				</div>
			</div>
			<div class = "row row3">
				<div class = "col col1">
					<span>공개여부</span>
				</div>
				<div class = "col col2">
					${vo.open}
				</div>
				<div class = "col col3">
					<span>작성자</span>
				</div>
				<div class = "col col4">
					${vo.nickName}
				</div>
			</div>
			<div class = "row row4">
				<div class = "col col1">
					<span>문의내용</span>
				</div>
				<div class = "col col2">
					<div class = "content">
						<c:forEach var = "image" items = "${images}" varStatus = "st">
							<img src = "${ctp}/board/${image}" />
						</c:forEach>
						<span>${vo.content}</span>
					</div>
				</div>
			</div>
		</div>
		
		<div class = "btnBox">
			<c:if test="${vo.reply==0&&sLevel==77}">
				<div class = "replyBtn btn" onclick = "location.href='serviceReply?idx=${vo.idx}'">답변쓰기</div>
			</c:if>
			<c:if test="${sLevel==77||vo.memberIdx==sIdx}">
				<div class = "deleteBtn btn" onclick = "deleteService(${vo.idx})">게시물삭제</div>
			</c:if>
		</div>
			
		
		<c:if test="${vo.reply!=0}">
		
			<div class = "replyContainer contentContainer">
				<div class = "row row1">
					<div class = "col col1">
						<img src = "${ctp}/icon/answer.png" />
					</div>
					<div class = "col col2">
						${replyVO.title}
					</div>
				</div>
				<div class = "row">
					<div class = "col col1">
						<span>작성자</span>
					</div>
					<div class = "col col2">
						${replyVO.nickName}
					</div>
					<div class = "col col3">
						<span>작성시간</span>
					</div>
					<div class = "col col4">
						<fmt:parseDate var = "writeDate" value = "${replyVO.writeDate}" pattern = "yyyy-MM-dd HH:mm:ss" />
						<fmt:formatDate value="${writeDate}" pattern = "yyyy년 MM월 dd일 / HH시 mm분" />
					</div>
				</div>
				<div class = "row row4">
					<div class = "col col1">
						<span>답변</span>
					</div>
					<div class = "col col2">
						<div class = "content">
							<c:forEach var = "image" items = "${replyImages}" varStatus = "st">
								<img src = "${ctp}/board/${image}" />
							</c:forEach>
							<span>${replyVO.content}</span>
						</div>
					</div>
				</div>
			</div>
			
			<div class = "btnBox">
				<c:if test="${sLevel==77}">
					<div class = "deleteBtn btn" onclick = "deleteService(${replyVO.idx})">답글삭제</div>
				</c:if>
			</div>
			
		</c:if>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>