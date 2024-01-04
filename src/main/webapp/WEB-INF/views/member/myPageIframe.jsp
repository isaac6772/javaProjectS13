<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/myPageIframe.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		
		function myPage(e) {
			if(e.getAttribute('href')=='myPage1') {
				$('#myPage1').css('font-weight','bolder');
				$('#myPage2').css('font-weight','normal');
				$('#myPage3').css('font-weight','normal');
			}
			else if(e.getAttribute('href')=='myPage2') {
				$('#myPage1').css('font-weight','normal');
				$('#myPage2').css('font-weight','bolder');
				$('#myPage3').css('font-weight','normal');
			}
			else if(e.getAttribute('href')=='myPage3') {
				$('#myPage1').css('font-weight','normal');
				$('#myPage2').css('font-weight','normal');
				$('#myPage3').css('font-weight','bolder');
			}
		}
		
		// 추후 확장성을 고려한 코드 설계(다른 페이지 경로에서 마이페이지의 특정 페이지로 들어오는 경우)
		$(function() {
			let myPage = document.getElementById("myPage").src;
			let strSrc = myPage.substring(myPage.lastIndexOf('/')+1);
			if(strSrc=='myPage1'||strSrc=='memberUpdate') $('#myPage1').css('font-weight','bolder');
			else if(strSrc=='myPage2') $('#myPage2').css('font-weight','bolder');
			else if(strSrc=='myPage3') $('#myPage3').css('font-weight','bolder');
		});
	</script>
</head>
<body>
	<div class = "myPageContainer">
		<div class = "leftSide">
			<div class = "logo">
				<a href = "${ctp}/home">
					<span class = "text1">TALK HUB</span>
				</a>
			</div>
			<div class = "profile">
				<div class = "imgBox">
					<img src = "${ctp}/profile/${sProfile}" />
				</div>
				<div class = "userInfo">
					<div class = "text1">${sNickName}</div>
					<div class = "text2">${sEmail}</div>
				</div>
			</div>
			<div class = "mainMenu">
				<div>
					<a href = "myPage1" onclick = "myPage(this)" target = "rightSide" id = "myPage1">계정관리</a>
				</div>
				<div>
					<a href = "myPage2" onclick = "myPage(this)" target = "rightSide" id = "myPage2">친구관리</a>
				</div>
				<div>
					<a href = "myPage3" onclick = "myPage(this)" target = "rightSide" id = "myPage3">뉴스관리</a>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "footer">
				<div class = "item1">
					<a href = "${ctp}/member/memberLogout">로그아웃</a>
				</div>
				<div class = "item2">|</div>
				<div class = "item3">
					<a href = "#">고객센터</a>
				</div>
			</div>
			<div class = "footerLogo">
				<a href = "${ctp}/home">
					<span class = "text1">TALK HUB</span>
				</a>
			</div>
		</div>
		<div class = "rightSide">
			<iframe src = "${param.myPage}" name = "rightSide" id = "myPage"></iframe>
		</div>
	</div>
</body>
</html>