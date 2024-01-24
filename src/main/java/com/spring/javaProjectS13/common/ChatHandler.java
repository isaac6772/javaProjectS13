package com.spring.javaProjectS13.common;

import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.spring.javaProjectS13.service.DiscussionService;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.MemberVO;

public class ChatHandler extends TextWebSocketHandler {
	
	@Autowired
	MemberService memberService;
	@Autowired
	DiscussionService discussionService;
	@Autowired
	DynamicScheduler dynamicScheduler;
	@Autowired
	ObjectMapper objectMapper;
	
	private static final Map<Integer, Map<WebSocketSession, Integer>> sessionRoom = new ConcurrentHashMap<>();	// 채팅방을 discussion테이블의 idx로 나눠서 관리한다.
	private static final Map<String, Integer> roomInfo = new ConcurrentHashMap<>();	// 누가 어떤 방에 들어갔는지를 저장하기 위한 map(접속이 끊겼을때 대비)
	
    @Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String payLoadMessage = message.getPayload();
        Map<String, String> tempMap = objectMapper.readValue(payLoadMessage, Map.class);
        int discussionIdx = Integer.parseInt(tempMap.get("discussionIdx"));
        MemberVO mVo = memberService.memberIdxSearch(Integer.parseInt(tempMap.get("memberIdx")));
        
        JsonNode jsonNode = objectMapper.readTree(payLoadMessage);
		((ObjectNode)jsonNode).put("nickName", mVo.getNickName());
		((ObjectNode)jsonNode).put("profile", mVo.getProfile());	
		payLoadMessage = objectMapper.writeValueAsString(jsonNode);
        
        for(WebSocketSession user : sessionRoom.get(discussionIdx).keySet()) {
        	user.sendMessage(new TextMessage(payLoadMessage));
        }
        discussionService.saveChat(mVo.getIdx(),discussionIdx,tempMap.get("data"));		// 메시지 전송후 db에 저장
	}

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String query = session.getUri().getQuery();
    	
    	// 토론채팅에 관한 처리
    	if(query.indexOf("=") != -1) {		// 쿼리에 '='가 있다는건 토론채팅에 관한 것이란 뜻
    		int discussionIdx = Integer.parseInt(query.substring(query.indexOf("=") + 1,query.indexOf("&")));	// discussion테이블의 idx이자 방을 구분하는 key값
    		int memberIdx = Integer.parseInt(query.substring(query.lastIndexOf("=") + 1));
    		String mVo = memberService.memberIdxSearchJson(memberIdx, discussionIdx);
    		
    		if(sessionRoom.containsKey(discussionIdx)) {	// 방이 존재하면 존재하는 방의 map에 해당 session추가
    			for(WebSocketSession users : sessionRoom.get(discussionIdx).keySet()) {		// 나를 제외한 해당하는 방에 속한 모든 유저에게 나의 정보를 보낸다.
    				users.sendMessage(new TextMessage(mVo));
    			}
    			
    			sessionRoom.get(discussionIdx).put(session, memberIdx);
    			roomInfo.put(session.getId(), discussionIdx);	// xx는 xx방에 들어갔음을 저장
    			
    			Iterator<Integer> iterator = sessionRoom.get(discussionIdx).values().iterator();	// 해당 방의 모든 멤버에 접근
    			
    			String memberList = memberService.memberListIterator(iterator, discussionIdx);
    			
    			session.sendMessage(new TextMessage(memberList));		// 나에게 해당 방의 접속한 회원 정보를 보냄
    		}
    		else {
    			sessionRoom.put(discussionIdx, new ConcurrentHashMap<>());	// 방이 존재하지 않으면 discussionIdx로 구별되는 방을 만들고 map에 추가
    			sessionRoom.get(discussionIdx).put(session, memberIdx);
    			roomInfo.put(session.getId(), discussionIdx);
    			
    			session.sendMessage(new TextMessage(mVo));		// 나에게 나의 정보를 보냄
    		}
    		
    		dynamicScheduler.scheduleTask(memberIdx, discussionIdx, session);	// 시간을 계산해서 사용자에게 반복적으로 뿌려줌
    	}
    	// 일반 1:1 채팅에 관한 처리
    	else {
    		
    	}
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        int discussionIdx = roomInfo.get(session.getId());		// 접속이 끊어진 사용자의 방번호를 구한다.
        int memberIdx = sessionRoom.get(discussionIdx).get(session);	// 제거할 멤버의 idx
        
        sessionRoom.get(discussionIdx).remove(session);			// map에서 그 방번호로 찾아가서 해당 session을 제거한다.
        if(sessionRoom.get(discussionIdx).size()==0) sessionRoom.remove(discussionIdx);		// 세션삭제후 방이 비어있다면 방을 삭제처리
        else {
        	for(WebSocketSession users : sessionRoom.get(discussionIdx).keySet()) {		// 방에 남아있는 유저들에게 삭제된 세션을 리스트에서 없애도록 메시지보냄
        		String jsonMessage = "{\"idx\":\""+memberIdx+"\",\"msgType\":\"remove\"}";
        		users.sendMessage(new TextMessage(jsonMessage));						
        	}
        }
        dynamicScheduler.cancelScheduledTask(memberIdx);
    }

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("전송오류 발생");
	}
}