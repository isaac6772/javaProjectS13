package com.spring.javaProjectS13.service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.spring.javaProjectS13.vo.MemberVO;

public interface MemberService {
	public boolean mailSend(String email, String title, String content) throws MessagingException;

	public MemberVO memberMidCheck(String mid);

	public MemberVO memberNickCheck(String nickName);

	public int memberJoin(MemberVO vo);

	public int memberLogin(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response, Model model);

	public void memberLogout(HttpSession session);

	public MemberVO memberUpdate(HttpSession session);

	public int nickNameUpdate(String nickName, String mid);

	public int memnberNameUpdate(String name, String mid);

	public int emailUpdate(String email, String mid);
}
