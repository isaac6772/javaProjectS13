<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage2.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/myPage2.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
	</script>
	<script src = "${ctp}/js/member/myPage2.js"></script>
</head>
<body>
	<div class = "rightSide">
	
		<div class = "header">
			<div class = "section">
				<div>
					<a href = "${ctp}/home" target = "_top">
						<img src = "${ctp}/icon/home.png" width = 17px height = 17px />
					</a>
				</div>
				<div class = "text symbol">></div>
				<div class = "text">친구관리</div>
				<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
			</div>
		</div>
		
		<div class = "friendListBox">
			<div class = "searchBar">
				<input type = "text" id = "nickNameSearch" placeholder = "닉네임 검색" />
			</div>
			<div class = "listBox">
			
				<div class = "section">
					<div class = "listMenu ${pag==0?'selected':''}" onclick = "listMenuShow()">
						<img src = "${ctp}/icon/human.png" />
					</div>
					<div class = "requestMenu ${pag==1?'selected':''}" onclick = "requestMenuShow()">
						<img src = "${ctp}/icon/request.png" />
					</div>
				</div>
				
				<div class = "myfriendList ${pag==0?'selected':''}">
					<c:forEach var = "vo" items = "${friends}" varStatus = "st">
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
									<span class = "text1 nickName">${vo.nickName}</span>
								</div>
								<div>
									<span class = "text2">${vo.introduce}</span>
								</div>
							</div>
							<div class = "option">
								<div class = "deleteFriend">
									<div onclick = "deleteFriend('${vo.idx}')">친구삭제</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				
				<div class = "friendRequest ${pag==1?'selected':''}">
					<c:forEach var = "request" items = "${friendRequests}" varStatus = "st">
						<div class = "request">
							<div class = "text">
								<span>${request.nickName}</span>
								<span>님이 친구 요청을 보냈습니다.</span>
							</div>
							<div class = "empty"></div>
							<div class = "btn accept" onclick = "acceptFriend('${request.memberIdxWho}')">요청수락</div>
							<div class = "btn deny" onclick = "denyFriend('${request.idx}')">거절</div>
						</div>
					</c:forEach>
				</div>
			</div>		<!-- listBox -->	
		</div>
		
	</div>		<!-- rightSide -->
</body>
</html>