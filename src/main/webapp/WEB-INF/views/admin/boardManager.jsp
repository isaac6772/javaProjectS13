<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/boardManager.css" />
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	'use strict';
	let contextPath = "${ctp}";
	let sw = 0;		// 체크박스 해제할지 체크할지를 정할 스위치 전역변수
</script>
<script src = "${ctp}/js/admin/boardManager.js"></script>
</head>
<body>
	<div class = "memberManagerContainer">
		<div class = "title">
			<img src = "${ctp}/icon/list.png" />
			<span>게시판 관리</span>
		</div>
		<form class = "conditionBox" name = "searchForm">
			<div class = "condition">
				<div class = "row row1">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">분류</span>
					</div>
					<div class = "col2">
						<select name = "part">
							<option ${pageVO.part=='전체'?'selected':''}>전체</option>
							<option ${pageVO.part=='일반'?'selected':''}>일반</option>
							<option ${pageVO.part=='일상'?'selected':''}>일상</option>
							<option ${pageVO.part=='스포츠'?'selected':''}>스포츠</option>
							<option ${pageVO.part=='연예'?'selected':''}>연예</option>
						</select>
					</div>
				</div>
				<div class = "row row2">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">검색일자</span>
					</div>
					<div class = "col2">
						<input type = "date" name = "fromDate" value = "${pageVO.fromDate}" /> ~ <input type = "date" name = "toDate" value = "${pageVO.toDate}" />
					</div>
				</div>
				<div class = "row row3">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">검색어</span>
					</div>
					<div class = "col2">
						<input type = "text" name = "searchString" value = "${pageVO.searchString}" />
						<select name = "searchType">
							<option value = "content" ${pageVO.searchType=='content'?'selected':''}>내용</option>
							<option value = "title" ${pageVO.searchType=='title'?'selected':''}>제목</option>
							<option value = "nickName" ${pageVO.searchType=='nickName'?'selected':''}>닉네임</option>
						</select>
					</div>
				</div>
			</div>
			<div class = "searchBtn">
				<div class = "btn" onclick = "boardSearch()">검색</div>
			</div>
			<input type = "hidden" name = "pageSize" id = "pageSize" />
			<input type = "hidden" name = "pag" id = "pag" />
		</form>
		
		<div class = "result">
		
			<div class = "text">
				<span class = "text1">검색결과 :</span>
				<span class = "text2">총</span>
				 <span class = "text3">${pageVO.totRecCnt}</span><span class = "text4">개 검색되었습니다.</span>
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
			
			<div class = "pageSizeBox">
				<select id = "pageSizeSelect" onchange = "boardSearch()">
					<option value = "10" ${pageVO.pageSize==10?'selected':''}>10개씩보기</option>
					<option value = "20" ${pageVO.pageSize==20?'selected':''}>20명씩보기</option>
					<option value = "30" ${pageVO.pageSize==30?'selected':''}>30명씩보기</option>
				</select>
			</div>
			
		</div>
		
		<div class = "memberListBox">
			<div class = "tableHeader">
				<div class = "col col1">
					<input type = "checkbox" onchange = "checkAll()" />
				</div>
				<div class = "col col2">
					<span>번호</span>
				</div>
				<div class = "col col3">
					<span>닉네임</span>
				</div>
				<div class = "col col4">
					<span>제목</span>
				</div>
				<div class = "col col5">
					<span>조회수</span>
				</div>
				<div class = "col col6">
					<span>댓글수</span>
				</div>
				<div class = "col col7">
					<span>추천수</span>
				</div>
				<div class = "col col8">
					<span>비추천수</span>
				</div>
				<div class = "col col9">
					<span>작성일자</span>
				</div>
				<div class = "col col10">
					<span>비고</span>
				</div>
			</div>
			
			<div class = "line"></div>
			
			<c:set var = "scrStartNo" value = "${pageVO.scrStartNo}" />
			<c:forEach var = "vo" items = "${bVos}" varStatus = "st">
				<form class = "memberList" id = "memberListForm${vo.idx}" action = "memberUpdate">
					<div class = "col col1">
						<input type = "checkbox" />
					</div>
					<div class = "col col2">
						<span>${scrStartNo}</span>
					</div>
					<div class = "col col3">
						<span>${vo.nickName}</span>
					</div>
					<div class = "col col4">
						<span>${vo.title}</span>
					</div>
					<div class = "col col5">
						<span>${vo.viewNum}</span>
					</div>
					<div class = "col col6">
						<span>${vo.replyCnt}</span>
					</div>
					<div class = "col col7">
						<span>${vo.good}</span>
					</div>
					<div class = "col col8">
						<span>${vo.bad}</span>
					</div>
					<div class = "col col9">
						<span>${fn:substring(vo.writeDate,0,16)}</span>
					</div>
					<div class = "col col10">
						${vo.part}
					</div>
					<input type = "hidden" name = "idx" value = "${vo.idx}" class = "hiddenIdx" />
				</form>
				<c:set var = "scrStartNo" value = "${scrStartNo-1}" />
			</c:forEach>
		</div>
		
		<div class = "managerFooter">
			<div class = "btnContainer">
				<div class = "btn" onclick = "deleteSelectedMember()">선택삭제</div>
				<!-- 선택 삭제할 회원 전체의 idx를 저장하는 폼태그 -->
				<form name = "memberDeleteForm">
					<input type = "hidden" id = "deleteMemberIdx" name = "memberIdxArray" />
				</form>
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
			<!-- 가운데 정렬을 위한 임시 div태그 -->
			<div class = "col3">
			
			</div>
		</div>
		
	</div>
</body>
</html>