<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adManager.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/adManager.css" />
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	'use strict';
	let contextPath = "${ctp}";
</script>
<script src = "${ctp}/js/admin/adManager.js"></script>
</head>
<body>
	
	<div class = "adManagerContainer">
		
		<div class = "flexBox">
			
			<div class = "box1">
				<div class = "imgFrame" id = "frame1">
				
				</div>
			</div>
			
			<div class = "box2">
				<div class = "col1">
					<div class = "row1">
						<span>선택가능한 광고</span>
					</div>
					<div class = "row2 adList" id = "adList1">
						<c:forEach var = "vo" items = "${vos}" varStatus = "st">
							<div class = "title">
								<input type = "checkbox" class = "availableAd" onchange = "imgGroupCheck(this)" />
								<span class= "text1">${vo.title}</span>
								<img src = "${ctp}/icon/arrowB.png" onclick = "imgGroupShow(this)" />
								<input type = "hidden" value = "${vo.idx}" />
							</div>
							<div class = "imgGroup">
								<c:forEach var = "image" items = "${vo.images}" varStatus = "st2">
									<div class = "imgName" onclick = "selectBox(this)">
										<img src = "${ctp}/icon/imgArrow.png" />
										<input type = "checkbox" />
										<span class = "name">${image}</span>
										<input type = "hidden" value = "${vo.idx}" />
									</div>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
					<div class = "row3">
						<div class = "relative">
							<input type = "checkbox" onchange = "checkAll(1)" id = "check1" /><span>전체선택</span>
						</div>
						<div class = "btn" onclick = "deleteAd()">선택삭제</div>
					</div>
				</div>
				<div class = "col2">
					<div class = "btn" onclick = "moveImg()">
						<span class = "text1">선택</span>
						<span class = "text2">▶</span>
					</div>
				</div>
				<div class = "col3">
					<div class = "row1">
						<span>게시중인 광고</span>
						<img src = "${ctp}/icon/arrowB.png" onclick = "moveDown()" />
						<img src = "${ctp}/icon/arrowT.png" onclick = "moveUp()" />
					</div>
					<form name = "adSubmitForm" method = "post" class = "row2" id = "adList2">
						<c:forEach var = "vo" items = "${aVos}" varStatus = "st">
							<div class = 'box' onclick = "selectBox2(this)">
								<input type='checkbox' class = 'postingAd' />${vo.fileName}
								<input type = "hidden" name = "fileName" class = "fileName" value = "${vo.fileName}" />
								<input type = "hidden" name = "serviceIdx" value = "${vo.serviceIdx}" />
							</div>
						</c:forEach>
					</form>
					<div class = "row3">
						<div class = "relative">
							<input type = "checkbox" onchange = "checkAll(2)" id = "check2" /><span>전체선택</span>
						</div>
						<div class = "btn" onclick = "deletePosting()">선택삭제</div>
					</div>
				</div>
			</div>
			
			<div class = "box3">
				<div class = "imgFrame" id = "frame2">
				
				</div>
			</div>
			
		</div>
		
		<div class = "line"></div>
		
		<div class = "btnBox">
			<div class = "btn" onclick = "saveAd()">저장</div>
		</div>
		
	</div>
	
</body>
</html>