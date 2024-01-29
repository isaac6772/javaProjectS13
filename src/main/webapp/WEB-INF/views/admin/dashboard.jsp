<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dashboard.jsp</title>
<link rel = "stylesheet" type = "text/css" href = "${ctp}/css/admin/dashboard.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	'use strict';
	let boardData = JSON.parse('${boardData}');
	let joinData = JSON.parse('${joinData}');
	let keywordData = JSON.parse('${keywordData}');
</script>
<script src = "${ctp}/js/admin/dashboard.js"></script>
</head>
<body>
	<div class = "dashboardContainer">
		
		<div class = "title">
			<span>대시보드</span>
		</div>
		
		<div class = "row row1">
			<div class = "box box1">
				<div class = "part">
					<span>총 게시물 수</span>
				</div>
				<div class = "cnt">
					<span>${boardCnt}</span>
				</div>
				<img src = "${ctp}/icon/document2.png" class = "icon" />
			</div>
			<div class = "box box2">
				<div class = "part">
					<span>총 댓글 수</span>
				</div>
				<div class = "cnt">
					<span>${replyCnt}</span>
				</div>
				<img src = "${ctp}/icon/reply.png" class = "icon" />
			</div>
			<div class = "box box3">
				<div class = "part">
					<span>총 회원 수</span>
				</div>
				<div class = "cnt">
					<span>${memberCnt}</span>
				</div>
				<img src = "${ctp}/icon/people.png" class = "icon" />
			</div>
			<div class = "box box4">
				<div class = "part">
					<span>총 방문 수</span>
				</div>
				<div class = "cnt">
					<span>${visitCnt}</span>
				</div>
				<img src = "${ctp}/icon/chart.png" class = "icon" />
			</div>
		</div>
		
		<div class = "row row2">
			<div class = "box box1">
				<div class = "title">
					<span>게시판 글작성 통계</span>
				</div>
				<div id="chart_div" style="width: 750px; height: 350px;"></div>
			</div>
			<div class = "box box2">
				<div class = "title">
					<span>신규가입 통계</span>
				</div>
				<div id="curve_chart" style="width: 750px; height: 350px"></div>
			</div>
		</div>
		
		<div class = "row row3">
			<div class = "box box1">
				<div class = "title">
					<span>검색어 통계(최근30일)</span>
				</div>
				<div id="donutchart" style="width: 400px; height: 250px;"></div>
			</div>
			<div class = "box box2">
			
			</div>
		</div>
		
	</div>
</body>
</html>