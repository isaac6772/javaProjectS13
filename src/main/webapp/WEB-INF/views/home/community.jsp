<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<div class = "comunityBox">
	<div class = "title">
		<div>
			<span class = "text1">친구</span>
			<img src = "${ctp}/icon/friend.png" width = 18px height = 19px />
		</div>
		<div>
			<span class = "text2" id = "loginFriendCnt">0</span>
			<span class = "text3">명 접속중</span>
		</div>
	</div>
	<div class = "line"></div>
	<c:if test="${!empty sMid}">
		<div class = "friendList">
			<c:forEach var = "vo" items = "${friendList}" varStatus = "st">
				<div class = "friend">
					<div class = "profile">
						<img src = "${ctp}/profile/${vo.profile}" />
						<c:if test="${vo.login!=0}">
							<img src = "${ctp}/icon/loginCircle.png" class = "loginState login" />
						</c:if>
						<c:if test="${vo.login==0}">
							<img src = "${ctp}/icon/logoutCircle.png" class = "loginState logout" />
						</c:if>
					</div>
					<div class = "info">
						<div>
							<span class = "text1">${vo.nickName}</span>
						</div>
						<div>
							<span class = "text2">${vo.introduce}</span>
						</div>
					</div>
					<div class = "chat">
						<img src = "${ctp}/icon/chat3.png" />
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty sMid}">
		<div class = "loginRequired">
			<span>로그인이 필요한 서비스입니다.</span>
		</div>
	</c:if>
</div>