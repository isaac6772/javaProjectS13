<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>news.jsp</title>
</head>
<body>
	<div class = "newsBox">
		
		<div class = "keyword">
			<c:if test="${empty mVo.keyword}">
				<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=정치'">정치</div>
				<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=경제'">경제</div>
				<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=사회'">사회</div>
				<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=세계'">세계</div>
				<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=연예'">연예</div>
				<span class = "line"></span>
			</c:if>
			<c:if test="${!empty mVo.keyword}">
				<c:forEach var = "item" items = "${fn:split(mVo.keyword,'/')}">
					<div class = "item ${keyword==item?'selected':''}" onclick = "location.href='home?keyword=${item}'">${item}</div>
				</c:forEach>
				<span class = "line"></span>
			</c:if>
		</div>
		
		<div id = "loadLayer">
			<div class = "newsList" id = "newsList">
				<c:if test="${empty nVos}">
					<img src = "${ctp}/util/loading2.gif" id = "loadingImg" />
				</c:if>
				<div class = "imgNewsBox">
					<c:forEach var = "i" begin = "0" end = "2">
						<div class = "imgNews" onclick = "newsModalShow(this)">
							<c:if test="${empty nVos[i].fileName}">
								<img src = "${ctp}/util/noImage.jpg" width = "100%" height = "200px" />
							</c:if>
							<c:if test="${!empty nVos[i].fileName}">
								<img src = "${nVos[i].fileName}" width = "100%" height = "200px" />
							</c:if>
							<c:if test="${nVos[i].title != '0'}">
								<div class = "title"><span>${nVos[i].title}</span></div>
							</c:if>
							<c:if test="${nVos[i].title == '0'}">
								<div class = "noResult">검색결과가 없습니다.</div>
							</c:if>
							<div class = "articleContent" style = "display : none">
								${nVos[i].article}
								<br>
								원본링크 : <a href = "${nVos[i].link}" target ="_blank">${nVos[i].link}</a>
							</div>
						</div>	
					</c:forEach>
				</div>
				<div class = "textNews">
					<div class = "left">
						<c:forEach var = "i" begin = "3" end = "7">
							<div class = "article">
								<div class = "text1" onclick = "newsModalShow(this)">
									<span>${nVos[i].title}</span>
									<div class = "articleContent" style = "display : none">
										${nVos[i].article}
										<br>
										원본링크 : <a href = "${nVos[i].link}" target ="_blank">${nVos[i].link}</a>
									</div>
								</div>
								<div class = "text2">
									<c:if test="${!empty nVos[i].timeDiff}">[${nVos[i].timeDiff}전]</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class = "right">
						<c:forEach var = "i" begin = "8" end = "12">
							<div class = "article">
								<div class = "text1" onclick = "newsModalShow(this)">
									<span>${nVos[i].title}</span>
									<div class = "articleContent" style = "display : none">
										${nVos[i].article}
										<br>
										원본링크 : <a href = "${nVos[i].link}" target ="_blank">${nVos[i].link}</a>
									</div>
								</div>
								<div class = "text2">
									<c:if test="${!empty nVos[i].timeDiff}">[${nVos[i].timeDiff}전]</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>	<!-- newsList -->
		</div>	<!-- loadLayer -->
		
	</div>	<!-- newsBox -->
	
	<div class = "newsModalContainer" id = "newsModal">
		<div class = "newsContent">
			<div id = "newsModalContent"></div>
		</div>
	</div>
</body>
</html>