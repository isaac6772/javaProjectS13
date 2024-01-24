package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.vo.ChatVO;
import com.spring.javaProjectS13.vo.DiscussionVO;

public interface DiscussionService {

	public List<DiscussionVO> discussionList(int memberIdx);

	public int makeDiscussion(MultipartFile file, DiscussionVO vo, HttpSession session);

	public int reservation(int idx, HttpSession session);

	public int enterDiscussion(int idx);

	public DiscussionVO discussion(int idx);

	public String participantCheck(DiscussionVO dVo, HttpSession session);

	public void saveChat(int memberIdx, int discussionIdx, String text);

	public List<ChatVO> chatList(int idx);

	public int cancelReservation(int idx, HttpSession session);

}
