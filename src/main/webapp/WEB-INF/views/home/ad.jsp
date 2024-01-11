<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<div class = "adBox">
	<div class = "adImgBox" id = "adImgBox">
		<c:forEach var = "vo" items = "${adVos}" varStatus = "st">
			<div class = "item"><img src = "${ctp}/service/${vo.fileName}" width = "100%" height = "100%" /></div>
		</c:forEach>
		<div class = "item"><img src = "${ctp}/service/${adVos[0].fileName}" width = "100%" height = "100%" /></div>
	</div>
</div>