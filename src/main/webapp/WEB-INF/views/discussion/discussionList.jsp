<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussion.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/discussion/discussion.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = "${ctp}";
		let level = "${sLevel}";
	</script>
	<script src = "${ctp}/js/discussion/discussion.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "discussionContainer">
		
		<div class = "btnBox">
			<div class = "btn" onclick = "createDiscussion()">
				<img src = "${ctp}/icon/discussion.png" />				
				<span>토론개설</span>
			</div>
		</div>
		
		<div>
			<div class = "calendarBtn">
				<img src = "${ctp}/icon/calendar.png" />
			</div>
		</div>
		
		<div class = "discussionList">
			<c:forEach var = "vo" items = "${dVos}" varStatus = "">
				<div class = "discussion">
					<div class = "img">
						<img src = "${ctp}/data/discussion/${vo.fileName}" />
					</div>
					<div class = "info">
						<div class = "subject">${vo.subject}</div>
						<div class = "line line1"></div>
						<div class = "row">
							<div class = "col1">개설자</div>
							<div class = "col2">${vo.memberIdx}</div>
						</div>
						<div class = "row">
							<div class = "col1">시작시간</div>
							<div class = "col2">
								<span>${fn:substring(vo.discussionDate,0,16)}</span>
								<span>(${vo.discussionTime}분)</span>
							</div>
						</div>
						<div class = "row">
							<div class = "col1">분류</div>
							<div class = "col2">${vo.part}</div>
						</div>
						<div class = "row">
							<div class = "col1">참가자</div>
							<div class = "col2">${vo.participant}</div>
						</div>
						<div class = "line line2"></div>
						<c:if test="${vo.state=='신청중' && vo.reservationOk==false}">
							<div class = "btn btn1" onclick = "reservation('${vo.idx}')">예약하기</div>
						</c:if>
						<c:if test="${vo.state=='신청중' && vo.reservationOk==true}">
							<div class = "btn btn2" onclick = "cancelReservation('${vo.idx}')">
								<div class = "group">
									<span>예약됨</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>예약취소</span>
								</div>
							</div>
						</c:if>
						<c:if test="${vo.state=='토론중'}">
							<div class = "btn btn3">
								<div class = "group" onclick = "location.href = '${ctp}/discussion/enterDiscussion?idx=${vo.idx}'">
									<span>토론중</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>관전</span>
								</div>
							</div>
						</c:if>
						<c:if test="${vo.state=='종료'}">
							<div class = "btn btn4">
								<div class = "group">
									<span>종료</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>보기</span>
								</div>
							</div>
						</c:if>
						<c:if test="${vo.state=='입장대기'}">
							<div class = "btn btn5" onclick = "location.href = '${ctp}/discussion/enterDiscussion?idx=${vo.idx}'">입장</div>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>		<!-- discussionList -->
		
	</div>		<!-- discussionContainer -->
	
	<div class = "discussionModalContainer">
		<form class = "modalContent" method = "post" action = "makeDiscussion" name = "discussionForm" enctype = "multipart/form-data">
			<div class = "title">
				<span>토론개설</span>
			</div>
			<div class = "row subject">
				<div class = "col1">주제</div>
				<div class = "col2">
					<input type = "text" name = "subject" id = "subject" />
				</div>
			</div>
			<div class = "row part">
				<div class = "col1">분류</div>
				<div class = "col2">
					<input type = "radio" name = "part" id = "partFree" value = "자유" checked>자유
					<input type = "radio" name = "part" id = "partNews" value = "뉴스">뉴스
				</div>
			</div>
			<div class = "row link">
				<div class = "col1">링크</div>
				<div class = "col2">
					<input type = "text" name = "link" id = "link" />
				</div>
			</div>
			<div class = "row headCount">
				<div class = "col1">참가인원</div>
				<div class = "col2">
					<input type = "number" name = "headCount" id = "headCount" min = "3" max = "10" value = "3" />
				</div>
			</div>
			<div class = "row time">
				<div class = "col1">토론시간</div>
				<div class = "col2">
					<input type = "number" name = "discussionTime" id = "discussionTime" min = "5" max = "60" value = "5" />
					<span>(분)</span>
				</div>
			</div>
			<div class = "row date">
				<div class = "col1">토론날짜</div>
				<div class = "col2">
					<input type = "datetime-local" name = "discussionDate" id = "discussionDate" />
				</div>
			</div>
			<div class = "row photo">
				<div class = "col1">썸네일</div>
				<div class = "col2">
					<input type = "file" name = "file" id = "file" />
				</div>
			</div>
			<div class = "row preview">
				<div class = "col1">미리보기</div>
				<div class = "col2">
					<img src = "${ctp}/util/noImage.jpg" id = "preView" />
				</div>
			</div>
			<div class = "btnBox">
				<div class = "btn1" onclick = "makeDiscussion()">만들기</div>
				<div class = "btn2" onclick = "hideForm()">취소</div>
			</div>
		</form>	<!-- modalContent -->
	</div>	 <!-- discussionModalContainer -->
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>