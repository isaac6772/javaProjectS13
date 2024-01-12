<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/board/boardList.css" />
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "${ctp}/js/board/boardList.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "boardListContainer">
		
		<div class = "listContainer">
			<div class = "line"></div>
			
			<div class = "optionBox">
				<div class = "type ${pageVO.scope=='전체글'?'selected':''}" onclick = "pageScopeChange('전체글')">전체글</div>
				<div class = "type ${pageVO.scope=='추천글'?'selected':''}" onclick = "pageScopeChange('추천글')">추천글</div>
				<div class = "type ${pageVO.scope=='공지'?'selected':''}" onclick = "pageScopeChange('공지')">공지</div>
				<div class = "partBox">
					<div class = "part ${pageVO.part=='전체'?'selected':''}">전체</div>
					<div class = "part ${pageVO.part=='일반'?'selected':''}">일반</div>
					<div class = "part ${pageVO.part=='일상'?'selected':''}">일상</div>
					<div class = "part ${pageVO.part=='스포츠'?'selected':''}">스포츠</div>
					<div class = "part ${pageVO.part=='연예'?'selected':''}">연예</div>
				</div>
				<div class = "pageSize">
					<select>
						<option>10개</option>
						<option>20개</option>
						<option>30개</option>
					</select>
				</div>
				<div class = "write">
					<div class = "btn" onclick = "location.href='boardInput'">
						<img src = "${ctp}/icon/pencil.png" />
						<span>글쓰기</span>
					</div>
				</div>
			</div>
			
			<div class = "table tableHeader">
				<div class = "col col1">번호</div>
				<div class = "col col2">분류</div>
				<div class = "col col3">제목</div>
				<div class = "col col4">작성자</div>
				<div class = "col col5">작성일</div>
				<div class = "col col6">조회</div>
				<div class = "col col7">추천수</div>
			</div>
			
			<div class = "informList">
				<c:forEach var = "vo" items = "${iVos}" varStatus = "st">
					<div class = "table tableContent">
						<div class = "col col1">공지</div>
						<div class = "col col2">${vo.title}</div>
						<div class = "col col3">${vo.nickName}</div>
						<div class = "col col4">${fn:substring(vo.writeDate,0,10)}</div>
						<div class = "col col5">${vo.viewNum}</div>
						<div class = "col col6">${vo.good}</div>
					</div>
					<c:set var = "scrStartNo" value = "${scrStartNo-1}" />
				</c:forEach>
			</div>
			
			<div class = "boardList">
				<c:set var = "scrStartNo" value = "${pageVO.scrStartNo}" />
				<c:forEach var = "vo" items = "${vos}" varStatus = "st">
					<div class = "table tableContent">
						<div class = "col col1">${scrStartNo}</div>
						<div class = "col col2">${vo.title}</div>
						<div class = "col col3">${vo.nickName}</div>
						<div class = "col col4">${fn:substring(vo.writeDate,0,10)}</div>
						<div class = "col col5">${vo.viewNum}</div>
						<div class = "col col6">${vo.good}</div>
					</div>
					<c:set var = "scrStartNo" value = "${scrStartNo-1}" />
				</c:forEach>
			</div>
			
			<div class = "pagingContainer">
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
			</div>
			
			<form name = "pagingForm">
				<input type = "hidden" name = "pag" id = "pag" value = "${pageVO.pag}" />
				<input type = "hidden" name = "pageSize" id = "pageSize" value = "${pageVO.pageSize}" />
				<input type = "hidden" name = "searchType" id = "searchType" value = "${pageVO.searchType}" />
				<input type = "hidden" name = "searchString" id = "searchString" value = "${pageVO.searchString}" />
				<input type = "hidden" name = "part" id = "part" value = "${pageVO.part}" />
				<input type = "hidden" name = "scope" id = "scope" value = "${pageVO.scope}" />
			</form>
			
		</div>
		
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>