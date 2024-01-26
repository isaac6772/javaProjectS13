<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/memberManager.css" />
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	'use strict';
	let contextPath = "${ctp}";
	let sw = 0;		// 체크박스 해제할지 체크할지를 정할 스위치 전역변수
</script>
<script src = "${ctp}/js/admin/memberManager.js"></script>
</head>
<body>
	<div class = "memberManagerContainer">
		<div class = "title">
			<img src = "${ctp}/icon/list.png" />
			<span>회원 리스트</span>
		</div>
		<form class = "conditionBox" name = "searchForm">
			<div class = "condition">
				<div class = "row row1">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">회원등급</span>
					</div>
					<div class = "col2">
						<select name = "level">
							<option value = "-1" ${pageVO.level==-1?'selected':''}>전체</option>
							<option ${pageVO.level==1?'selected':''}>1</option>
							<option ${pageVO.level==2?'selected':''}>2</option>
							<option ${pageVO.level==3?'selected':''}>3</option>
							<option ${pageVO.level==4?'selected':''}>4</option>
							<option ${pageVO.level==5?'selected':''}>5</option>
							<option ${pageVO.level==6?'selected':''}>6</option>
							<option value = "0" ${pageVO.level==0?'selected':''}>탈퇴</option>
						</select>
					</div>
				</div>
				<div class = "row row2">
					<div class = "col1">
						<img src = "${ctp}/icon/dot.png" />
						<span class = "text1">가입일자</span>
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
							<option value = "name" ${pageVO.searchType=='name'?'selected':''}>이름</option>
							<option value = "email" ${pageVO.searchType=='email'?'selected':''}>이메일</option>
						</select>
					</div>
				</div>
			</div>
			<div class = "searchBtn">
				<div class = "btn" onclick = "memberSearch()">검색</div>
			</div>
			<input type = "hidden" name = "pageSize" id = "pageSize" />
			<input type = "hidden" name = "pag" id = "pag" />
		</form>
		
		<div class = "result">
		
			<div class = "text">
				<span class = "text1">검색결과 :</span>
				<span class = "text2">총</span>
				 <span class = "text3">${pageVO.totRecCnt}</span><span class = "text4">명 검색되었습니다.</span>
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
					<option value = "10" ${pageVO.pageSize==10?'selected':''}>10명씩보기</option>
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
					<span>아이디</span>
				</div>
				<div class = "col col4">
					<span>닉네임</span>
				</div>
				<div class = "col col5">
					<span>이름</span>
				</div>
				<div class = "col col6">
					<span>이메일</span>
				</div>
				<div class = "col col7">
					<span>등급</span>
				</div>
				<div class = "col col8">
					<span>포인트</span>
				</div>
				<div class = "col col9">
					<span>방문횟수</span>
				</div>
				<div class = "col col10">
					<span>성별</span>
				</div>
				<div class = "col col11">
					<span>상태</span>
				</div>
				<div class = "col col12">
					<span>가입일자</span>
				</div>
				<div class = "col col13">
					<span>최근방문일자</span>
				</div>
				<div class = "col col14">
					<span>비고</span>
				</div>
			</div>
			
			<div class = "line"></div>
			
			<c:set var = "scrStartNo" value = "${pageVO.scrStartNo}" />
			<c:forEach var = "vo" items = "${vos}" varStatus = "st">
				<form class = "memberList" id = "memberListForm${vo.idx}" action = "memberUpdate">
					<div class = "col col1">
						<input type = "checkbox" />
					</div>
					<div class = "col col2">
						<span>${scrStartNo}</span>
					</div>
					<div class = "col col3">
						<span>${vo.mid}</span>
					</div>
					<div class = "col col4">
						<span>${vo.nickName}</span>
					</div>
					<div class = "col col5">
						<span>${vo.name}</span>
					</div>
					<div class = "col col6">
						<span>${vo.email}</span>
					</div>
					<div class = "col col7">
						<span>${vo.level}</span>
					</div>
					<div class = "col col8">
						<span>${vo.point}</span>
					</div>
					<div class = "col col9">
						<span>${vo.visitCnt}</span>
					</div>
					<div class = "col col10">
						<span>${vo.gender}</span>
					</div>
					<div class = "col col11">
						<c:if test="${vo.level==0}"><span class = "level0">탈퇴</span></c:if>
						<c:if test="${vo.level!=0}">
							<c:if test="${vo.login!=0}"><span class = "login">접속중</span></c:if>
							<c:if test="${vo.login==0}"><span class = "logout">로그아웃</span></c:if>
						</c:if>
					</div>
					<div class = "col col12">
						<span>${fn:substring(vo.joinDate,0,10)}</span>
					</div>
					<div class = "col col13">
						<span>${fn:substring(vo.lastDate,0,10)}</span>
					</div>
					<div class = "col col14">
						<img src = "${ctp}/icon/edit.png" title = "회원정보수정" onclick = "memberUpdate(this,'${vo.mid}','${vo.nickName}','${vo.name}','${vo.email}','${vo.level}','${vo.point}')" />
						<%-- <img src = "${ctp}/icon/chat.png" title = "1:1채팅" /> --%>
						<img src = "${ctp}/icon/memberDelete.png" title = "회원탈퇴" onclick = "memberDelete('${vo.idx}')" />
						<div class = "btn btnSave" onclick = "saveUpdate('${vo.idx}')">저장</div>
						<div class = "btn btnCancel" onclick = "cancelUpdate(this,'${vo.mid}','${vo.nickName}','${vo.name}','${vo.email}','${vo.level}','${vo.point}')">취소</div>
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