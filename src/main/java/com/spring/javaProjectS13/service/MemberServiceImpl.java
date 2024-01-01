package com.spring.javaProjectS13.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	JavaMailSender mailSender;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public boolean mailSend(String email, String title, String content) throws MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		mailSender.send(message);
		return true;
	}

	@Override
	public MemberVO memberMidCheck(String mid) {
		return memberDAO.memberMidCheck(mid);
	}

	@Override
	public MemberVO memberNickCheck(String nickName) {
		return memberDAO.memberNickCheck(nickName);
	}

	@Override
	public int memberJoin(MemberVO vo) {
		String regMid = "^[a-zA-Z0-9]{4,15}$";
		String regPwd = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_\\-+=\\|\\]\\[}{;:/?.>,<\"'])[\\w\"'`~!@#$%^&*()_\\-+=\\|\\]\\[}{;:/?.>,<]{4,15}$";
		String regNickName = "^[\\w가-힣]{2,7}$";
		String regName = "^[가-힣]{1,20}$";
		String regEmail = "^[\\w]+@[\\w]+.[\\w]+$";
		// backend 정규식 유효성 검사, 닉네임, 아이디 중복체크
		
		if(!vo.getMid().matches(regMid) || !vo.getPwd().matches(regPwd) || !vo.getNickName().matches(regNickName)
				|| !vo.getName().matches(regName) || !vo.getEmail().matches(regEmail)
				|| memberDAO.memberMidCheck(vo.getMid())!=null || memberDAO.memberNickCheck(vo.getNickName())!=null) return 0;
		// backend 유효성체크가 끝난후
		else {
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));
			return memberDAO.memberJoin(vo);
		}
	}

	@Override
	public int memberLogin(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response, Model model) {
		MemberVO vo = memberDAO.memberMidCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sProfile", vo.getProfile());
			
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setPath("/");
			if(idSave.equals("y")) {
				cookie.setMaxAge(60*60*24*7);
				System.out.println("쿠키 : " + cookie.getValue());
			}
			else cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			return 1;
		}
		else return 0;
	}

	@Override
	public void memberLogout(HttpSession session) {
		session.removeAttribute("sMid");
		session.removeAttribute("sProfile");
	}
}
