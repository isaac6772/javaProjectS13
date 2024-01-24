<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussionRecord.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/discussion/discussionRecord.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		
		let idx = '${dVo.idx}';
		let memberIdx = '${sIdx}';
	</script>
	<script src = "${ctp}/js/discussion/discussionRecord.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "discussionRecordContainer">
	
		<div class = "chatBox">
			<div class = "subject">
				<div class = "text">${dVo.subject}</div>
				<div class = "time">
					<fmt:parseDate var = "parsedDate" value = "${dVo.discussionDate}" pattern = "yyyy-MM-dd HH:mm:ss" />
					<fmt:formatDate var = "formattedDate" value = "${parsedDate}" pattern = "yyyy년MM월dd일 hh시mm분" />
					${formattedDate}
				</div>
			</div>
			<div class = "chatArea" id = "chatArea">
				<c:forEach var = "vo" items = "${cVos}" varStatus = "st">
					<c:if test="${vo.memberIdx==sIdx}">
						<div class = "myChat"><div class = "text">${vo.message}</div></div>
					</c:if>
					<c:if test="${vo.memberIdx!=sIdx}">
						<div class = "profile">
							<div class = "box">
								<img src = "${ctp}/profile/${vo.profile}" />
								<span>${vo.nickName}</span>
							</div>
						</div>
						<div class = "chat">
							<div class = "text">${vo.message}</div>
							<div class = "time">${fn:substring(vo.msgDate,11,16)}</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<div class = "btnBox">
			<div class = "outIcon">
				<img src = "${ctp}/icon/out.png" title = "나가기" onclick = "location.href='${ctp}/discussion/discussionList'" />
			</div>
		</div>
		
	</div>
	
</body>
</html>