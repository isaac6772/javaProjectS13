<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<c:if test="${empty sMid}">
	<form class = "loginBox" name = "loginForm" method = "post" action = "${ctp}/member/memberLogin">
		<div class = "title">
			<span>로그인</span>
			<img src = "${ctp}/icon/login.png" width = 19px height = 19px />
		</div>
		<div class = "line"></div>
		<input type = "text" name = "mid" id = "mid" value = "${cookie.cMid.value}" placeholder = "아이디" />
		<input type = "password" name = "pwd" id = "pwd" placeholder = "비밀번호" />
		<div class = "idSaveBox">
			<div class = "loginToggleBox ${(!empty cookie.cMid.value)? 'checked' : ''}">
				<input type = "hidden" name = "idSave" id = "idSave" ${(!empty cookie.cMid.value)? 'value="y"' : 'value="n"'}/>
				<div class = "toggleBtn"></div>
			</div>
			<div class = "text">&nbsp;&nbsp;아이디 저장</div>
		</div>
		<div id = "login">
			<span>로그인</span>
		</div>
		<div class = "joinFind">
			<span><a href = "${ctp}/member/memberJoin">회원가입</a></span> | <span><a href = "${ctp}/member/memberIdPwdFind">아이디/비밀번호 찾기</a></span>
		</div>
		<div class = "line"></div>
	</form>
</c:if>
<c:if test="${!empty sMid}">
	<div class = "memberBox">
		<div class = "row1">
			<span>프로필</span>
			<img src = "${ctp}/icon/profile.png" width = 15px height = 17px />
		</div>
		<div class = "line"></div>
		<div class = "row2">
			<div class = "profile">
				<img src = "${ctp}/profile/${sProfile}" />
			</div>
			<div class = "info">
				<div class = "row1">
					<div>${sNickName}</div>
					<div class = "col2" id = "myPage1"><i class="fa-solid fa-gear" style="color: #bdc4d1;"></i></div>
				</div>
				<div class = "row2">
					<c:if test="${mVo.level==77}">관리자계정</c:if>
					<c:if test="${mVo.level!=77}">
						<span class = "text1">레벨 : ${mVo.level}</span>
						<span class = "text2">(${mVo.exp} / ${maxExp})</span>
					</c:if>
				</div>
			</div>
		</div>
		<c:if test="${mVo.level!=77}">
			<div class = "row3">
				<div class = "progressContainer">
					<div class = "progressBar"></div>
				</div>
			</div>
		</c:if>
		<div class = "row4">
			<div>
				<!-- <span>알림</span> -->
			</div>
			<div>
				<c:if test="${mVo.level==77}">
					<span class = "text1" id = "adminPage">관리자페이지</span>
				</c:if>
			</div>
		</div>
		<div class = "line"></div>
		<div class = "row5">
			<div class = "col1">
				<span><i class="fa-solid fa-coins" style="color: #eacc0b;"></i> point</span>
				<span class = "text2">${mVo.point}</span>
			</div>
			<div class = "col2">
				<span class = "text1" id = "myPage2">마이페이지</span>
			</div>
		</div>
		<div class = "row6">
			<div class = "logout" id = "logout">
				<i class="fa-solid fa-power-off" style="color: #edeff3;"></i>
				<span>로그아웃</span>
			</div>
		</div>
	</div>
</c:if>