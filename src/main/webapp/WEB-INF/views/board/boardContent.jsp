<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/board/boardContent.css" />
	<script>
		'use strict';
		let contextPath = "${ctp}";
	</script>
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src = "${ctp}/js/board/boardContent.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<div class = "boardContentContainer">
	
		<div class = "btnContainer">
			<div class = "btn">
				<img src = "${ctp}/icon/arrowT.png" />
				<span>이전글</span>
			</div>
			<div class = "btn">
				<img src = "${ctp}/icon/arrowB.png" />
				<span>다음글</span>
			</div>
			<div class = "btn">목록</div>
		</div>
	
		<div class = "contentContainer">
			<div class = "part">
				<span>${bVo.part} ></span>
			</div>
			<div class = "title">
				<span>${bVo.title}</span>
			</div>
			<div class = "profile">
				<div class = "profileImg">
					<img src = "${ctp}/profile/${bVo.profile}" />
				</div>
				<div class = "profileInfo">
					<div>
						<span class = "nickName">${bVo.nickName}</span>
						<img src = "${ctp}/icon/level${bVo.level}.png" class = "level" />
					</div>
					<div>
						<span class = "date">${fn:substring(bVo.writeDate,0,16)}</span>
					</div>
				</div>
				<div class = "option">
					<img src = "${ctp}/icon/option.png" onclick = "optionFormShow(this)" />
					<div class = "optionForm">
						<div onclick = "location.href='boardUpdate?idx=${bVo.idx}'">수정</div>
						<div>삭제</div>
						<div>신고</div>
					</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "content">
				${bVo.content}
			</div>
			<div class = "goodBadinfo">
				<div>
					<img src = "${ctp}/icon/like.png" />
					<span>추천</span><span>33</span>
				</div>
				<div>
					<img src = "${ctp}/icon/dislike.png" />
					<span>비추천</span><span>2</span>
				</div>
				<div>
					<img src = "${ctp}/icon/comment.png" />
					<span>댓글</span><span>5</span>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "replTitle">
				<span>댓글</span>
			</div>
			<form class = "inputReply" action = "inputReply" name = "inputReplyForm" method = "post">
				<div class = "writer">
					<span>${sNickName}</span>
				</div>
				<div class = "replContent">
					<textarea placeholder = "댓글을 남겨보세요" maxlength = "1000" name = "content"></textarea>
				</div>
				<div class = "btnBox">
					<button class = "btn" type = "submit">등록</button>
				</div>
				<input type = "hidden" name = "boardIdx" value = "${bVo.idx}" />
				<input type = "hidden" name = "nickName" value = "${sNickName}" />
				<input type = "hidden" name = "memberIdx" value = "${sIdx}" />
			</form>
			
			<c:forEach var = "vo" items = "${replyVos}" varStatus = "st">
				<c:if test="${vo.replyIdx==0}">
					<div class = "replyGroup">
						<div class = "replyBox motherReply">
							<div class = "profile">
								<img src = "${ctp}/profile/${vo.profile}" />
							</div>
							<div class = "replContent">
								<div class = "row1">
									<span>${vo.nickName}</span>
									<span>${fn:substring(vo.writeDate,0,16)}</span>
									<img src = "${ctp}/icon/option.png" />
								</div>
								<div class = "row2">${vo.content}</div>
								<div class = "row3">
									<span class = "pointer" onclick = "reReplyFormShow(this)">
										<span>답글</span>
										<span class = "reReplyCnt"></span>
									</span>
								</div>
							</div>
						</div>
						<div class = "reReplyForm">
							<form class = "inputReply" action = "inputReply" name = "reReplyForm" method = "post">
								<div class = "writer">
									<span>${sNickName}</span>
								</div>
								<div class = "replContent">
									<textarea placeholder = "댓글을 남겨보세요" maxlength = "1000" name = "content"></textarea>
								</div>
								<div class = "btnBox">
									<button class = "btn" type = "submit">등록</button>
								</div>
								<input type = "hidden" name = "boardIdx" value = "${bVo.idx}" />
								<input type = "hidden" name = "nickName" value = "${sNickName}" />
								<input type = "hidden" name = "memberIdx" value = "${sIdx}" />
								<input type = "hidden" name = "replyIdx" value = "${vo.idx}" />
							</form>
							<c:forEach var = "reVo" items = "${replyVos}" varStatus = "st2">
								<c:if test="${vo.idx==reVo.replyIdx}">
									<div class = "replyBox reReply">
										<div class = "profile">
											<img src = "${ctp}/profile/${reVo.profile}" />
										</div>
										<div class = "replContent">
											<div class = "row1">
												<span>${reVo.nickName}</span>
												<span>${fn:substring(reVo.writeDate,0,16)}</span>
											</div>
											<div class = "row2">${reVo.content}</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>	<!-- contentContainer-end -->
		
	</div>	<!-- boardContentContainer-end -->
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>