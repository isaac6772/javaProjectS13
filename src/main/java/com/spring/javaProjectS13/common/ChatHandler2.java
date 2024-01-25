package com.spring.javaProjectS13.common;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.javaProjectS13.service.MemberService;

public class ChatHandler2 extends TextWebSocketHandler {
	
	@Autowired
	MemberService memberService;
	
	private static final Map<String, Map<WebSocketSession, String>> sessionRoom = new ConcurrentHashMap<>();
	private static final Map<String, String> roomInfo = new ConcurrentHashMap<>();
	private static final Map<String, Integer> userInfo = new ConcurrentHashMap<>();
	
    @Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String roomNumber = roomInfo.get(session.getId());		// 메시지를 발송할 방(room)의 번호
    	int memberIdx = userInfo.get(session.getId());		// 메시지 발신 대상자(나)의 idx
    	int sw = 0;		// 메세지를 읽었는지 안읽었는지를 판별하는 스위치(채팅 메시지가 갔을때 현재 소켓서버에 접속중이었다면(채팅창이 켜져있었다면) 읽은 상태로 판별)
    	
    	for(WebSocketSession user : sessionRoom.get(roomNumber).keySet()) {		//  상대방에게 보내는 메세지
    		if(user!=session) {
    			String msg = memberIdx + "/" + message.getPayload();
    			user.sendMessage(new TextMessage(msg));
    			sw = 1;
    			break;
    		}
    	}
    	
    	String msg = memberIdx + "/" + message.getPayload();
    	session.sendMessage(new TextMessage(msg));	// 나에게 보내는 메세지
    	
    	if(sw==0) {
    		int otherIdx = 0;
    		for(String str : roomNumber.split("/")) {
    			if(memberIdx != Integer.parseInt(str)) otherIdx = Integer.parseInt(str);
    		}
    		memberService.inputAlarm(otherIdx,memberIdx,"chat",roomNumber);	// 읽지 않았으면 알람 발생
    	}
    	memberService.saveChat(memberIdx, roomNumber, message.getPayload());
	}

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String query = session.getUri().getQuery();
    	int myIdx = Integer.parseInt(query.substring(query.indexOf("=",1)+1,query.indexOf("&")));
    	int friendIdx = Integer.parseInt(query.substring(query.lastIndexOf("=")+1));
    	
    	String roomNumber = Math.min(myIdx, friendIdx) + "/" + Math.max(myIdx, friendIdx);		//  	2/3 이런식으로 방번호 생성
    	
    	if(sessionRoom.get(roomNumber)!=null) {
    		sessionRoom.get(roomNumber).put(session, session.getId());
    	}
    	else {
    		Map<WebSocketSession, String> myMap = new HashMap<WebSocketSession, String>();
    		myMap.put(session, session.getId());
    		sessionRoom.put(roomNumber, myMap);
    	}
    	
    	roomInfo.put(session.getId(), roomNumber);
    	userInfo.put(session.getId(), myIdx);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomNumber = roomInfo.get(session.getId());
        roomInfo.remove(session.getId());
        userInfo.remove(session.getId());
        sessionRoom.get(roomNumber).remove(session);
        
        if(sessionRoom.get(roomNumber).size()==0) sessionRoom.remove(roomNumber);
    }

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("전송오류 발생");
	}
}