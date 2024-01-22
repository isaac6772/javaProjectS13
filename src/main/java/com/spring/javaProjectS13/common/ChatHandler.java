package com.spring.javaProjectS13.common;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	// 웹소켓 서버측에 텍스트 메시지가 접수되면 호출되는 메소드
    @Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String payloadMessage = (String) message.getPayload();
        System.out.println("서버에 도착한 메시지:"+payloadMessage);
        //session.sendMessage(new TextMessage("ECHO : " + payloadMessage));
        
        for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage("user :" + message.getPayload()));
		}
	}

	// 웹소켓 서버에 클라이언트가 접속하면 호출되는 메소드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	sessionList.add(session);
    	
        System.out.println("클라이언트 접속됨 : " + session.getId());
    }

    // 클라이언트가 접속을 종료하면 호출되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println("클라이언트 접속해제");
    }

    // 메시지 전송시나 접속해제시 오류가 발생할 때 호출되는 메소드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("전송오류 발생");
	}
}