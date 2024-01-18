<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>service.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/service/serviceList.css" />
	<script>
		'use strict';
		let contextPath = "${ctp}";
		let myIdx = '${sIdx}';
		let level = '${sLevel}';
	</script>
	<script src = "${ctp}/js/service/serviceList.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "serviceContainer">
	
		<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
		
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
				<div class = "btn" onclick = "pageSizeChange()">
					<img src = "${ctp}/icon/searchW.png" />
				</div>
			</div>
			<div class = "writeBox">
				<div class = "btn" onclick = "location.href = 'serviceInput'">글쓰기</div>
			</div>
			<input type = "hidden" name = "pag" id = "pag" />
			<input type = "hidden" name = "pageSize" id = "pageSize" value = "10" />
		</form>
		
		<div class = "pagingContainer">
			
			<div class = "col1"></div>
		
			<div class = "pagingBox">
				<c:if test="${pageVO.pag>1}">
					<div class = "item" onclick = "pageMove(1)"><img src = "${ctp}/icon/startPage.png" /></div>
					<div class = "item" onclick = "pageMove(${pageVO.pag-1})"><img src = "${ctp}/icon/prevBtn.png" /></div>
				</c:if>
				<c:forEach var = "i" begin = "${pageVO.curBlock*pageVO.blockSize + 1}" end = "${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus = "st">
					<c:if test="${i <= pageVO.totPage}"><div onclick = "pageMove(${i})" class = "item number ${pageVO.pag==i?'selected':''}">${i}</div></c:if>
				</c:forEach>
				<c:if test="${pageVO.pag<pageVO.totPage}">
					<div class = "item" onclick = "pageMove(${pageVO.pag+1})"><img src = "${ctp}/icon/nextBtn.png" /></div>
					<div class = "item" onclick = "pageMove(${pageVO.totPage})"><img src = "${ctp}/icon/endPage.png" /></div>
				</c:if>
			</div>
			
			<div class = "pageSizeBox">
				<select id = "pageSizeSelect" onchange = "pageSizeChange()">
					<option value = "10" ${pageVO.pageSize==10?'selected':''}>10개씩보기</option>
					<option value = "20" ${pageVO.pageSize==20?'selected':''}>20개씩보기</option>
					<option value = "30" ${pageVO.pageSize==30?'selected':''}>30개씩보기</option>
				</select>
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
					<span>분류</span>
				</div>
				<div class = "col col4">
					<span>작성자</span>
				</div>
				<div class = "col col5">
					<span>작성일</span>
				</div>
				<div class = "col col6">
					<span>답변</span>
				</div>
			</div>
			
			<c:set var = "scrStartNo" value = "${pageVO.scrStartNo}" />
			<c:forEach var = "vo" items = "${vos}" varStatus = "st">
				<div class = "listContent">
					<div class = "col col1">
						<span>${scrStartNo}</span>
					</div>
					<div class = "col col2">
						<a href = 'serviceContent?idx=${vo.idx}'>${vo.title}</a>
						<div>
							<c:if test="${vo.open=='비공개'}">
								<img src = "${ctp}/icon/lock.png" />
							</c:if>
							<c:if test="${vo.dateDiff==0}">
								<img src = "${ctp}/icon/new.png" />
							</c:if>
						</div>
					</div>
					<div class = "col col3">
						<span>${vo.part}</span>
					</div>
					<div class = "col col4">
						<span>${vo.nickName}</span>
					</div>
					<div class = "col col5">
						<c:if test="${vo.dateDiff==0}">${fn:substring(vo.writeDate,11,16)}</c:if>
						<c:if test="${vo.dateDiff!=0}">${fn:substring(vo.writeDate,0,10)}</c:if>
					</div>
					<div class = "col col6">
						<c:if test="${vo.reply==0}">
							<div class = "waiting">대기중</div>
						</c:if>
						<c:if test="${vo.reply!=0}">
							<div class = "answer">답변완료</div>
						</c:if>
					</div>
				</div>
				<c:set var = "scrStartNo" value = "${scrStartNo-1}" />
			</c:forEach>
			
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>