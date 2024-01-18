<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/userInfo.css" />
<script src = "${ctp}/js/home/userInfo.js"></script>
<div class = "userInfo">
	<c:if test="${!empty sMid}">
		<div class = "box">
			<img src = "${ctp}/icon/alarm.png" />
		</div>
		<div class = "box">
			<img src = "${ctp}/icon/chat2.png" />
		</div>
		<div class = "box" onclick = "settingFormShow()">
			<img src = "${ctp}/icon/setting.png" />
			<div class = "settingForm">
				<div class = "arrow"></div>
				<div class = "item" onclick = "location.href='${ctp}/member/myPageIframe?myPage=myPage1'">내정보</div>
				<div class = "item" onclick = "location.href='${ctp}/member/memberLogout'">로그아웃</div>
			</div>
		</div>
	</c:if>
</div>