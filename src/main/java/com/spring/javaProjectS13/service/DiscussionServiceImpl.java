package com.spring.javaProjectS13.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaProjectS13.dao.DiscussionDAO;
import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.vo.ChatVO;
import com.spring.javaProjectS13.vo.DiscussionVO;
import com.spring.javaProjectS13.vo.MemberVO;

@Service
public class DiscussionServiceImpl implements DiscussionService {
	@Autowired
	DiscussionDAO discussionDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	ObjectMapper objectMapper;

	@Override
	public List<DiscussionVO> discussionList(int memberIdx) {
		// 리스트를 가져올때 신청시간이 지났는지 여부를 체크해서 DB업데이트
		discussionDAO.updateDiscussionState();
		
		List<DiscussionVO> vos = discussionDAO.discussionList();
		for(DiscussionVO vo : vos) {
			String participants = "";
			for(String str : vo.getParticipant().split("/")) {			// 현재 접속자가 예약했는지 여부를 체크, idx를 nickName으로 변환
				if(str.equals(memberIdx + "")) {
					vo.setReservationOk(true);
				}
				participants += memberDAO.memberIdxSearch(Integer.parseInt(str)).getNickName() + "/";
			}
			participants = participants.substring(0,participants.length()-1);
			vo.setParticipant(participants);
			vo.setNickName(memberDAO.memberIdxSearch(vo.getMemberIdx()).getNickName());
		}
		return vos;
	}

	@Override
	public int makeDiscussion(MultipartFile file, DiscussionVO vo, HttpSession session) {
		if(vo.getHeadCount()<3) return 0;
		
		int res = 0;
		int memberIdx = (int)session.getAttribute("sIdx");
		String fileName = file.getOriginalFilename();
		fileName = UUID.randomUUID().toString().substring(0,12) + "_" + fileName;
		String realPath = session.getServletContext().getRealPath("/resources/data/board/discussion/");
		
		try {
			FileOutputStream fos = new FileOutputStream(realPath + fileName);
			fos.write(file.getBytes());
			vo.setMemberIdx(memberIdx);
			vo.setFileName(fileName);
			res = discussionDAO.makeDiscussion(vo);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int reservation(int idx, HttpSession session) {
		int memberIdx = (int)session.getAttribute("sIdx");
		int res = discussionDAO.reservationTimeCheck(idx);
		
		if(res!=0) discussionDAO.addParticipant(idx ,memberIdx);
		
		return res;
	}

	@Override
	public int enterDiscussion(int idx) {
		// 입장가능한 토론인지 검사해서, 종료된 토론이면 종료페이지로 아니면 정상페이지로
		return discussionDAO.enterTimeCheck(idx);
	}

	@Override
	public DiscussionVO discussion(int idx) {
		return discussionDAO.discussion(idx);
	}

	@Override
	public String participantCheck(DiscussionVO vo, HttpSession session) {
		String userIdx = (int)session.getAttribute("sIdx") + "";
		String[] participants = vo.getParticipant().split("/");
		
		int sw = 0;
		for(String participant : participants) {
			if(participant.equals(userIdx)) {
				sw = 1;
				break;
			}
		}
		
		if(sw==0) return "관전자";
		else return "참가자";
	}

	@Override
	public void saveChat(int memberIdx, int discussionIdx, String text) {
		discussionDAO.saveChat(memberIdx,discussionIdx,text);
	}

	@Override
	public List<ChatVO> chatList(int idx) {
		List<ChatVO> vos = discussionDAO.chatList(idx);
		
		for(ChatVO vo : vos) {
			String profile = memberDAO.memberIdxSearch(vo.getMemberIdx()).getProfile();		// 채팅한 각 사람의 프로필 사진 등록
			vo.setProfile(profile);
		}
		
		return vos;
	}

}
