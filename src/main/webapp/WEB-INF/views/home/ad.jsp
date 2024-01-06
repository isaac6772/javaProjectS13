<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<div class = "adBox">
	<div class = "adImgBox" id = "adImgBox">
		<div class = "item"><img src = "${ctp}/ad/ad1.jpg" width = "100%" height = "100%" /></div>
		<div class = "item"><img src = "${ctp}/ad/ad2.jpg" width = "100%" height = "100%" /></div>
		<div class = "item"><img src = "${ctp}/ad/ad3.jpg" width = "100%" height = "100%" /></div>
		<div class = "item"><img src = "${ctp}/ad/ad1.jpg" width = "100%" height = "100%" /></div>
	</div>
</div>