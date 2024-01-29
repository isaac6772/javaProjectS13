<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reportManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/reportManager.css" />
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	'use strict';
	let contextPath = "${ctp}";
	let sw = 0;		// 체크박스 해제할지 체크할지를 정할 스위치 전역변수
</script>
<script src = "${ctp}/js/admin/reportManager.js"></script>
</head>
<body>
	<div class = "reportManagerContainer">
		<div class = "title">
			<img src = "${ctp}/icon/list.png" />
			<span>신고 관리</span>
		</div>
		<form class = "conditionBox" name = "searchForm">
			<div class = "condition">
				<div class = "row row1">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">신고분류</span>
					</div>
					<div class = "col2">
						<select name = "part">
							<option ${pageVO.part=='전체'?'selected':''}>전체</option>
							<option ${pageVO.part=='욕설/비방'?'selected':''}>욕설/비방</option>
							<option ${pageVO.part=='성희롱'?'selected':''}>성희롱</option>
							<option ${pageVO.part=='기타'?'selected':''}>기타</option>
						</select>
					</div>
				</div>
				<div class = "row row2">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">신고일자</span>
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
							<option value = "mid" ${pageVO.searchType=='mid'?'selected':''}>아이디</option>
							<option value = "nickName" ${pageVO.searchType=='nickName'?'selected':''}>닉네임</option>
							<option value = "content" ${pageVO.searchType=='content'?'selected':''}>신고사유</option>
						</select>
					</div>
				</div>
			</div>
			<div class = "searchBtn">
				<div class = "btn" onclick = "reportSearch()">검색</div>
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
				<select id = "pageSizeSelect" onchange = "memberSearch()">
					<option value = "10" ${pageVO.pageSize==10?'selected':''}>10개씩보기</option>
					<option value = "20" ${pageVO.pageSize==20?'selected':''}>20개씩보기</option>
					<option value = "30" ${pageVO.pageSize==30?'selected':''}>30개씩보기</option>
				</select>
			</div>
			
		</div>
		
		<div class = "reportListBox">
			<div class = "tableHeader">
				<div class = "col col1">
					<input type = "checkbox" onchange = "checkAll()" />
				</div>
				<div class = "col col2">
					<span>번호</span>
				</div>
				<div class = "col col3">
					<span>신고당한사람</span>
				</div>
				<div class = "col col4">
					<span>처리유무</span>
				</div>
				<div class = "col col5">
					<span>신고유형</span>
				</div>
				<div class = "col col6">
					<span>분류</span>
				</div>
				<div class = "col col7">
					<span>신고사유</span>
				</div>
				<div class = "col col8">
					<span>신고날짜</span>
				</div>
				<div class = "col col9">
					<span>비고</span>
				</div>
			</div>
			
			<div class = "line"></div>
			
			<c:set var = "scrStartNo" value = "${pageVO.scrStartNo}" />
			<c:forEach var = "vo" items = "${rVos}" varStatus = "st">
				<form class = "reportList" id = "reportListForm${vo.idx}">
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
						<c:if test="${empty vo.checkField}">
							<span style = "color : red">N</span>
						</c:if>
						<c:if test="${!empty vo.checkField}">
							<span style = "color : blue">${vo.checkField}</span>
						</c:if>
					</div>
					<div class = "col col5">
						<c:if test="${vo.reportType=='board'}">게시판</c:if>
						<c:if test="${vo.reportType=='boardReply'}">댓글</c:if>
					</div>
					<div class = "col col6">
						<span>${vo.part}</span>
					</div>
					<div class = "col col7">
						<span>${vo.content}</span>
					</div>
					<div class = "col col8">
						<span>${fn:substring(vo.reportDate,0,16)}</span>
					</div>
					<div class = "col col9">
						<img src = "${ctp}/icon/document.png" title = "자세히보기" onclick = "goContent('${vo.reportType}','${vo.reportIdx}')" />
						<img src = "${ctp}/icon/delete2.png" title = "글 삭제" onclick = "deleteContent('${vo.reportType}','${vo.reportIdx}','${vo.reporter}','${vo.memberIdx}','${vo.idx}')" />
					</div>
					<input type = "hidden" name = "idx" value = "${vo.idx}" class = "hiddenIdx" />
				</form>
				<c:set var = "scrStartNo" value = "${scrStartNo-1}" />
			</c:forEach>
		</div>
		
		<div class = "managerFooter">
			<div class = "btnContainer">
				<div class = "btn" onclick = "deleteSelectedReport()">선택삭제</div>
				<form name = "reportDeleteForm">
					<input type = "hidden" id = "deleteReportIdx" name = "reportIdxArray" />
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