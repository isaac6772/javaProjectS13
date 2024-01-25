package com.spring.javaProjectS13.service;

import java.util.Iterator;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.vo.AlarmVO;
import com.spring.javaProjectS13.vo.ChatVO;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.PageVO;

public interface MemberService {
	public boolean mailSend(String email, String title, String content) throws MessagingException;

	public MemberVO memberMidCheck(String mid);

	public MemberVO memberNickCheck(String nickName);

	public int memberJoin(MemberVO vo);

	public int memberLogin(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response);

	public void memberLogout(HttpSession session);

	public MemberVO memberUpdate(HttpSession session);

	public int nickNameUpdate(String nickName, String mid);

	public int memnberNameUpdate(String name, String mid);

	public int emailUpdate(String email, String mid);

	public MemberVO memberEmailCheck(String email);

	public int memberPwdChange(HttpSession session, String oldPwd, String pwd);

	public int memberDelete(HttpSession session, String why);

	public int profileChange(MultipartFile file, HttpSession session);

	public void basicProfileChange(HttpSession session);

	public int memberUpdate(MemberVO vo);

	public List<MemberVO> memberList(PageVO vo);

	public int selectedMemberDelete(String memberIdxArray);

	public String memberIdFind(String name, String email);

	public String memberPwdFind(String mid, String email, HttpSession session);

	public int memberPwdReset(String pwd, String email);

	public List<MemberVO> friendList(int idx);

	public int inputKeyword(String keyword, HttpSession session);

	public void deleteKeyword(String keyword, HttpSession session);

	public MemberVO memberIdxSearch(int idx);

	public String memberIdxSearchJson(int memberIdx, int discussionIdx);

	public String memberListIterator(Iterator<Integer> iterator, int discussionIdx);

	public void saveChat(int memberIdx, String roomNumber, String payload);

	public List<ChatVO> chatList(String roomNumber);

	public void inputAlarm(int memberIdx, int memberIdxWho, String string, String roomNumber);

	public void readAlarm(String roomNumber, int memberIdx);

	public List<AlarmVO> alarmList(int idx);

	public void alarmRead(int attribute);

}
