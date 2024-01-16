<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>board.jsp</title>
</head>
<body>
	<div class = "boardBox">
	
		<div class = "hot">
			<div class = "title">
				<div class = "icon"><img src = "${ctp}/icon/recommend.png" /></div>
				<div class = "text">추천글</div>
				<div class = "pag">
					<span id = "hotPag">1</span>
					<span>/</span>
					<span>3</span>
				</div>
				<div class = "page">
					<div class = "btn btn1" onclick = "prevBoard()">&lt;</div>
					<div class = "btn btn2" onclick = "nextBoard()">&gt;</div>
				</div>
			</div>
			<div class = "line"></div>
			<div class = "slideBox">
				<c:forEach var = "i" begin = "0" end = "2">
					<div class = "boardList">
						<c:forEach var = "j" begin = "${i*10}" end = "${i*10+9}" varStatus = "st">
							<div class = "board">
								<div class = "subject">
									<img src = "${ctp}/icon/goodBoard.png" />
									<span class = "text1" onclick = "location.href='board/boardContent?idx=${b1Vos[j].idx}'">${b1Vos[j].title}</span>
									<c:if test="${b1Vos[j].replyCnt!=0}">
										<span class = "replyCnt">[${b1Vos[j].replyCnt}]</span>
									</c:if>
								</div>
								<div class = "part">${b1Vos[j].part}</div>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class = "recent" id = "recentBoard">
			<div id = "boardLoad">
				<div class = "title">
					<div class = "icon"><img src = "${ctp}/icon/newBoard.png" /></div>
					<div class = "text">최신글</div>
					<div class = "part">
						<div class = "${part=='전체'?'selected':''}" onclick = "partChange('전체')">전체</div>
						<div class = "${part=='일상'?'selected':''}"  onclick = "partChange('일상')">일상</div>
						<div class = "${part=='스포츠'?'selected':''}"  onclick = "partChange('스포츠')">스포츠</div>
						<div class = "${part=='연예'?'selected':''}"  onclick = "partChange('연예')">연예</div>
					</div>
				</div>
				<div class = "line"></div>
				<div class = "boardList">
					<c:forEach var = "vo" items = "${b2Vos}" varStatus = "st">
						<div class = "board">
							<div class = "subject">
								<span class = "text1" onclick = "location.href='board/boardContent?idx=${vo.idx}'">${vo.title}</span>
								<img src = "${ctp}/icon/new.png" />
								<c:if test="${vo.replyCnt!=0}">
									<span class = "replyCnt">[${vo.replyCnt}]</span>
								</c:if>
							</div>
							<div class = "part">${vo.part}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>