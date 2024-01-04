<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberLeave.jsp</title>
	<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/member/memberDelete.css" />
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		'use strict';
		let contextPath = '${ctp}';
	</script>
	<script>
		'use strict';
		
		function showWriteForm(e) {
			if(e.value=='직접쓰기') {
				$('#detailWhy').show();
			}
			else $('#detailWhy').hide();
		}
		
		function memberLeave() {
			if($('#leaveCheck').prop('checked')==false) {
				alert("회원탈퇴동의에 체크해주세요");
				return false;
			}
			
			if($('#whyDelete').val()=='직접쓰기') {
				if($('#detailWhy').val().trim()=='') {
					alert("탈퇴사유를 입력해주세요");
					return false;
				}
				$('#why').val($('#detailWhy').val().trim());
			}
			else $('#why').val($('#whyDelete').val());
			
			memberDeleteForm.submit();
		}
	</script>
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
				<div class = "text">
					<a href = "${ctp}/member/myPage1">계정관리</a>
				</div>
				<div class = "text symbol">></div>
				<div class = "text">회원 탈퇴</div>
			</div>
			<div class = "myInfo">
				<div class = "col1 col">
					<img src = "${ctp}/profile/${sProfile}" />
				</div>
				<div class = "col2 col">
					<span class = "text1">${sNickName}</span>
					<span class = "text2">▼</span>
				</div>
				<div class = "col3 col"><img src = "${ctp}/icon/bell.png" width = 24px height = 22px/></div>
				<div class = "col4 col"><img src = "${ctp}/icon/message.png" width = 25px height = 20px/></div>
				<div class = "col5 col"><img src = "${ctp}/icon/menu.png" width = 20px /></div>
			</div>
		</div>
		<div class = "submenu1">
			<div class = "row1 row">
				<div class = "col1">
					<img src = "${ctp}/icon/info.png" width = 22px />
					<span class = "text1">개인정보</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberUpdate'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row2 row">
				<div class = "col1">
					<img src = "${ctp}/icon/password.png" width = 22px />
					<span class = "text1">비밀번호</span>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "location.href='memberPwdChange'">수정</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "row3 row">
				<div class = "col1">
					<img src = "${ctp}/icon/leave.png" width = 23px />
					<span class = "text1">회원탈퇴</span>
				</div>
				<div class = "col2">
					<div class = "btn">탈퇴</div>
				</div>
			</div>
		</div>
		<form id = "memberDeleteForm" name = "memberDeleteForm" method = "post">
		 	<div class = "content">
		 		<div class = "title">
		 			<span>회원탈퇴</span>
		 			<div><i class="fa-solid fa-xmark close" id = "closeMemberDelete" style="color: #94989e;"></i></div>
		 		</div>
		 		<div class = "info">
		 			<span style = "color : red;">
		 				회원탈퇴시 회원정보가 모두 삭제됩니다.<br/>
		 				(단, 아래 항목은 표기된 법률에 따라 특정 기간 동안 보관됩니다.)<br/>
		 			</span>
		 			<span style = "font-size: 0.8em">
		 				1. 계약 또는 청약철회 등에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간:5년<br/>
		 				2. 대금결제 및 재화 등의 공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간:5년<br/>
		 				3. 전자금융 거래에 관한 기록 보존 이유 : 전자금융거래법 보존 기간 / 5년<br/>
		 				4. 소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 보존 기간 / 3년<br/>
		 				5. 신용정보의 수집/처리 및 이용 등에 관한 기록 보존 이유 : 신용정보의 이용 및 보호에 관한 법률 보존기간 / 3년
		 			</span>
	 			</div>
	 			<div style = "font-weight: bolder">탈퇴사유</div>
		 		<div>
		 			<select class = "selectBox" id = "whyDelete" onchange = showWriteForm(this)>
		 				<option>아이디변경 / 재가입 목적</option>
		 				<option>서비스 불만족</option>
		 				<option>더이상 이용하지 않음</option>
		 				<option>직접쓰기</option>
		 			</select>
	 			</div>
	 			<textarea id = "detailWhy" rows = 5></textarea>
	 			<div class = "check">
	 				<input type = "checkbox" id = "leaveCheck" /> 해당 내용을 모두 확인했으며, 회원탈퇴에 동의합니다.
	 			</div>
	 			<div class = "delete">
	 				<input type = "button" onclick = "memberLeave()" value = "회원탈퇴" />
	 			</div>
	 			<input type = "hidden" name = "why" id = "why" />
		 	</div>
		</form>
	</div>
</body>
</html>