<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "ctp" value = "${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>discussionChat.jsp</title>
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<form>
        <div>
            <form action="">
			   	<input type="text" id="message" name="message">
        		<input type="button" value="Send" onclick="send_message()"><br>
			</form>
		</div>
		<div id="outputDiv"></div>
	</form>
	
</body>
<script>
	function send_message() {
		websocket = new WebSocket("ws://localhost/chat");
		websocket.onopen = function(evt) {
	        onOpen(evt)
	    };
	    websocket.onmessage = function(evt) {
	        onMessage(evt)
	    };
	    websocket.onerror = function(evt) {
	        onError(evt)
	    };
	}
	
	// WebSocket 연결
	function onOpen(evt) {
	    writeToScreen("WebSocket 연결!");
	    doSend($("#message").val());
	}
	
	// 메시지 수신
	function onMessage(evt) {
	    writeToScreen("메시지 수신 : " + evt.data);
	}
	
	// 에러 발생
	function onError(evt) {
	    writeToScreen("에러 : " + evt.data);
	}
	
	function doSend(message) {
	    writeToScreen("메시지 송신 : " + message);
	    websocket.send(message);
	}
	
	function writeToScreen(message) {
	    $("#outputDiv").append("<p>" + message + "</p>");
	}
</script>
</html>