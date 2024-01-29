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
	<jsp:include page="/WEB-INF/views/include/userInfo.jsp" />
	
	<div class = "boardContentContainer">
	
		<div class = "btnContainer">
			<c:if test="${bVo.prevIdx!=0}">
				<div class = "btn" onclick = "location.href='boardContent?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&searchType=${pageVO.searchType}&searchString=${pageVO.searchString}&part=${pageVO.part}&scope=${pageVO.scope}&idx=${bVo.prevIdx}'">
					<img src = "${ctp}/icon/arrowT.png" />
					<span>이전글</span>
				</div>
			</c:if>
			<c:if test="${bVo.nextIdx!=0}">
				<div class = "btn" onclick = "location.href='boardContent?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&searchType=${pageVO.searchType}&searchString=${pageVO.searchString}&part=${pageVO.part}&scope=${pageVO.scope}&idx=${bVo.nextIdx}'">
					<img src = "${ctp}/icon/arrowB.png" />
					<span>다음글</span>
				</div>
			</c:if>
			<!-- 게시판리스트에서 페이지 정보를 그대로 가져와서 목록이동시 이전 페이지 정보대로 리스트로 이동함 -->
			<div class = "btn" onclick = "location.href='boardList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&searchType=${pageVO.searchType}&searchString=${pageVO.searchString}&part=${pageVO.part}&scope=${pageVO.scope}'">목록</div>
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
					<div class = "memberName">
						<span class = "nickName" onclick = "memberOptionModalShow(this)">${bVo.nickName}</span>
						<img src = "${ctp}/icon/level${bVo.level}.png" class = "level" />
						<div class = "memberOptionModal">
							<div class = "item" onclick = "location.href='${ctp}/member/memberInfo?idx=${bVo.memberIdx}'">회원정보</div>
							<c:if test="${sIdx!=vo.memberIdx}">
								<div class = "item" onclick = "requestFriend('${bVo.memberIdx}',this)">친구추가</div>
							</c:if>
						</div>
					</div>
					<div>
						<span class = "date">${fn:substring(bVo.writeDate,0,16)}</span>
						<span class = "viewNum">조회 ${bVo.viewNum}</span>
					</div>
				</div>
				<div class = "option">
					<img src = "${ctp}/icon/option.png" class = "optionIcon" onclick = "optionModalShow(this)" />
					<div class = "optionModal">
						<c:if test="${sIdx==bVo.memberIdx}">
							<div onclick = "location.href='boardUpdate?idx=${bVo.idx}'">수정</div>
						</c:if>
						<c:if test="${sLevel==77 || sIdx==bVo.memberIdx}">
							<div onclick = "location.href='boardDelete?idx=${bVo.idx}'">삭제</div>
						</c:if>
						<div onclick = "report('${bVo.idx}','${bVo.memberIdx}','board')">신고</div>
					</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "content">
				${bVo.content}
			</div>
			<div class = "goodBadinfo">
				<div>
					<img src = "${ctp}/icon/liked.png" class = "recommend ${recommend==1?'selected':''}" onclick = "cancelRecommend('${bVo.idx}')" />
					<img src = "${ctp}/icon/like.png" class = "recommend ${recommend!=1?'selected':''}" onclick = "setGood(${bVo.idx})" />
					<span>추천</span>
					<span>${bVo.good}</span>
				</div>
				<div>
					<img src = "${ctp}/icon/disliked.png" class = "recommend ${recommend==2?'selected':''}" onclick = "cancelRecommend('${bVo.idx}')" />
					<img src = "${ctp}/icon/dislike.png" class = "recommend ${recommend!=2?'selected':''}" onclick = "setBad('${bVo.idx}')" />
					<span>비추천</span>
					<span>${bVo.bad}</span>
				</div>
				<div>
					<img src = "${ctp}/icon/comment.png" />
					<span>댓글</span><span>${fn:length(replyVos)}</span>
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
			<div class = "line"></div>
			
			<c:forEach var = "vo" items = "${replyVos}" varStatus = "st">
				<c:if test="${vo.replyIdx==0}">
					<div class = "replyGroup">
						<div class = "replyBox motherReply">
							<div class = "profile">
								<img src = "${ctp}/profile/${vo.profile}" />
							</div>
							<div class = "replContent">
								<div class = "row1 option">
									<span class = "nickNameText"  onclick = "memberOptionModalShow(this)">${vo.nickName}</span>
									<span>${fn:substring(vo.writeDate,0,16)}</span>
									<img src = "${ctp}/icon/option.png" class = "optionIcon" onclick = "optionModalShow(this)" />
									<div class = "optionModal">
										<c:if test="${sIdx==vo.memberIdx}">
											<div onclick = "updateReply(this,'${vo.nickName}','${vo.idx}','${bVo.idx}')">수정</div>
										</c:if>
										<c:if test="${sLevel==77 || sIdx==vo.memberIdx || sIdx==bVo.memberIdx}">
											<div onclick = "deleteReply(this,'${vo.idx}','${bVo.idx}')">삭제</div>
										</c:if>
										<div onclick = "report('${vo.idx}','${vo.memberIdx}','boardReply')">신고</div>
									</div>
									<div class = "memberOptionModal">
										<div class = "item" onclick = "location.href='${ctp}/member/memberInfo?idx=${vo.memberIdx}'">회원정보</div>
										<c:if test="${sIdx!=vo.memberIdx}">
											<div class = "item" onclick = "requestFriend('${vo.memberIdx}',this)">친구추가</div>
										</c:if>
									</div>
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
											<div class = "row1 option">
												<span class = "nickNameText" onclick = "memberOptionModalShow(this)">${reVo.nickName}</span>
												<span>${fn:substring(reVo.writeDate,0,16)}</span>
												<img src = "${ctp}/icon/option.png" class = "optionIcon" onclick = "optionModalShow(this)" />
												<div class = "optionModal">
													<c:if test="${sIdx==reVo.memberIdx}">
														<div onclick = "updateRereply(this,'${reVo.nickName}','${reVo.idx}','${bVo.idx}')">수정</div>
													</c:if>
													<c:if test="${sLevel==77 || sIdx==vo.memberIdx || sIdx==bVo.memberIdx}">
														<div onclick = "deleteReply(this,'${reVo.idx}','${bVo.idx}')">삭제</div>
													</c:if>
													<div onclick = "report('${reVo.idx}','${reVo.memberIdx}','boardReply')">신고</div>
												</div>
												<div class = "memberOptionModal">
													<div class = "item" onclick = "location.href='${ctp}/member/memberInfo?idx=${reVo.memberIdx}'">회원정보</div>
													<c:if test="${sIdx!=vo.memberIdx}">
														<div class = "item" onclick = "requestFriend('${reVo.memberIdx}',this)">친구추가</div>
													</c:if>
												</div>
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
	
	<div class = "reportModalContainer">
		<form class = "reportModal" action = "report" method = "post" name = "reportModal" id = "reportModal">
			<div class = "title">
				<img src = "${ctp}/icon/alert.png" />
				<span>신고하기</span>
			</div>
			<div class = "content">
				<select class=  "comboBox" name = "part">
					<option>욕설/비방</option>
					<option>성희롱</option>
					<option>기타</option>
				</select>
				<textarea rows="7" placeholder = "상세 사유를 입력해주세요" name = "content" id = "reportContent"></textarea>
			</div>
			<div class = "btnBox">
				<div class = "btn" onclick = "submitReport()">제출</div>
			</div>
			<input type = "hidden" name = "reportType" id = "reportType" />
			<input type = "hidden" name = "reportIdx" id = "reportIdx" />
			<input type = "hidden" name = "memberIdx" id = "memberIdx" />
			<input type = "hidden" name = "reporter" value = "${sIdx}" />
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>