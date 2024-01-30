<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussionChat.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/discussion/discussionChat.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		
		let idx = '${dVo.idx}';
		let sIdx = '${sIdx}';
	</script>
	<script src = "${ctp}/js/discussion/discussionChat.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />

	<div class = "discussionChatContainer">
		
		<div class = "rowGroup">
			<div class = "chatBox">
				<div class = "subject">
					<div class = "text">${dVo.subject}</div>
					<div class = "time"></div>
				</div>
				<div class = "chatArea" id = "chatArea"></div>
				<div class = "typing">	
					<textarea rows = "3" maxlength="500" id = "textMsg" onkeyup="textCheck(this)" readonly ></textarea>
					<div class = "submit">
						<div class = "length">
							<span id = "textLength">0</span>/500
						</div>
						<div class = "btn" id = "submitBtn" onclick = "textSend(this)">전송</div>
					</div>
				</div>
			</div>
			
			<div class = "memberBox">
				<div class = "participant">
					<div class = "title">참가자</div>
				</div>
				<div class = "spectator">
					<div class = "title">관전자</div>
				</div>
			</div>
		</div>		<!-- rowGroup -->
		
		<div class = "outIcon">
			<img src = "${ctp}/icon/out.png" title = "나가기" onclick = "location.href='${ctp}/discussion/discussionList'" />
		</div>
		
	</div>
 
</body>
</html>