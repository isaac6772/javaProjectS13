<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/home/userInfo.css" />
<script>
	'use strict';
	
	let memberIdx = '${sIdx}';
</script>
<script src = "${ctp}/js/home/userInfo.js"></script>
<div class = "userInfo">
	<c:if test="${!empty sMid}">
	
		<div class = "box">
			<img src = "${ctp}/icon/alarm.png" onclick = "alarmFormShow()" />
			
			<div class = "alarmTotal" id = "alarmTotal"></div>
			
			<div class = "alarmForm optionForm">
				<div class = "arrow"></div>
				
				<div class = "alarmLoadLayer" id = "alarmLoadLayer">
					<c:if test="${fn:length(aVos)!=0}">
						<c:forEach var = "alarm" items = "${aVos}" varStatus = "st">
						
							<c:if test="${alarm.alarmType=='boardReply'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" onclick = "window.top.location.href='${ctp}/board/boardContent?idx=${alarm.alarmTypeIdx}'">
										<span>${alarm.nickName}</span>
										<span>님이</span>
										<span>내 글</span><span>에 댓글을 남기셨습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
						
							<c:if test="${alarm.alarmType=='boardReReply'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" onclick = "window.top.location.href='${ctp}/board/boardContent?idx=${alarm.alarmTypeIdx}'">
										<span>${alarm.nickName}</span>
										<span>님이</span>
										<span>내 댓글</span><span>에 답글을 남기셨습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
							 
							<c:if test="${alarm.alarmType=='friendRequest'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" onclick = "window.top.location.href='${ctp}/member/myPageIframe?myPage=myPage2&pag=1'">
										<span>${alarm.nickName}</span>
										<span>님이 친구요청을 보내셨습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
							 
							<c:if test="${alarm.alarmType=='reportContentDeleteDone'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" style = "cursor : text;">
										<span>신고하신 글이 접수되어 삭제처리되었습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
							 
							<c:if test="${alarm.alarmType=='reportContentDelete'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" style = "cursor : text;">
										<span>회원님의 게시글이 신고접수되어 삭제되었습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
							 
							<c:if test="${alarm.alarmType=='serviceReply'}">
								<div class = "alarm ${alarm.readCheck == '안읽음' ? 'noRead' : ''}">
									<div class = "alarmText" onclick = "location.href='${ctp}/service/serviceContent?idx=${alarm.alarmTypeIdx}'">
										<span>고객센터에 문의하신 글에 관리자가 답변을 작성하였습니다.</span>
									</div>
									<div class = "timeDiff">
										<span>${alarm.timeDiff} 전</span>
									</div>
									<div class = "imgBox" onclick = "deleteAlarm('${alarm.idx}')">
										<img src = "${ctp}/icon/delete.png" />
									</div>
								</div>
							</c:if>
							
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(aVos)==0}">
						<div class = "alarm"><span>알람이 없습니다</span></div>
					</c:if>
				</div>
				
			</div>
			
		</div>
		
		<div class = "box">
			<img src = "${ctp}/icon/chat2.png" onclick = "chattingFormShow()" />
			
			<div class = "chatAlarmTotal alarmTotal" id = "chatAlarmTotal"></div>
			
			<div class = "chattingForm optionForm">
				<div class = "arrow"></div>
				
				<div class = "title">
					<div class = "empty"></div>
					<div class = "friendNickName chatGroup">
						<span id = "friendNickName"></span>
					</div>
					<div class = "return chatGroup">
						<img src = "${ctp}/icon/return.png" onclick = "returnFriendList()" />
					</div>
				</div>
				
				<div class = "friendList listGroup">
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
							<c:if test="${vo.alarmCnt!=0}">
								<div class = "chatAlarm">
									<div class = "chatAlarmCnt" onclick = "privateChat('${vo.idx}','${sIdx}','${vo.nickName}')">${vo.alarmCnt}</div>
								</div>
							</c:if>
							<c:if test="${vo.alarmCnt==0}">
								<div class = "chat">
									<img src = "${ctp}/icon/chat3.png" onclick = "privateChat('${vo.idx}','${sIdx}','${vo.nickName}')" />
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class = "privateChat">
					<div id = "chatLoadLayer">
						<div class = "chatRecord" id = "chatRecord">
							<c:forEach var = "vo" items = "${cVos}" varStatus = "st">
								<c:if test="${vo.memberIdx==sIdx}">
									<div class = "me"><div class = "chat">${vo.message}</div></div>
								</c:if>
								<c:if test="${vo.memberIdx!=sIdx}">
									<div class = "you"><div class = "chat">${vo.message}</div></div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class = "typing">
						<textarea rows = "1" maxlength = "300" id = "chatInput"></textarea>
					</div>
				</div>
				
			</div>		<!-- chattingForm -->
		</div>
		
		<div class = "box" onclick = "settingFormShow()">
			<img src = "${ctp}/icon/setting.png" />
			<div class = "settingForm optionForm">
				<div class = "arrow"></div>
				<div class = "item" onclick = "location.href='${ctp}/member/myPageIframe?myPage=myPage1'">내정보</div>
				<div class = "item" onclick = "location.href='${ctp}/member/memberLogout'">로그아웃</div>
			</div>
		</div>
		
	</c:if>
</div>