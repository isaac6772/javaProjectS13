package com.spring.javaProjectS13.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

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
		String regEmail = "^[\\w]+@[\\w]+[.][\\w]+$";
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
	public int memberLogin(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response) {
		MemberVO vo = memberDAO.memberMidCheck(mid);
		if(vo != null && vo.getLevel()!= 0 &&passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sProfile", vo.getProfile());
			session.setAttribute("sEmail", vo.getEmail());
			
			// 아이디 저장 정보 쿠키저장
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setPath("/");
			if(idSave.equals("y")) {
				cookie.setMaxAge(60*60*24*7);
			}
			else cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			// 방문횟수와 포인트, 경험치 증가시키기(출석포인트는 1포인트)
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(new Date());
			
			if(!vo.getLastDate().substring(0,10).equals(today)) {
				memberDAO.memberVisitUpdate(vo.getIdx());
			}
			// 마지막 방문시간 업데이트
			memberDAO.memberLastDateUpdate(vo.getIdx());
			
			return 1;
		}
		else return 0;
	}

	@Override
	public void memberLogout(HttpSession session) {
		session.removeAttribute("sMid");
		session.removeAttribute("sProfile");
	}

	@Override
	public MemberVO memberUpdate(HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberDAO.memberMidCheck(mid);
		return vo;
	}

	@Override
	public int nickNameUpdate(String nickName, String mid) {
		return memberDAO.nickNameUpdate(nickName, mid);
	}

	@Override
	public int memnberNameUpdate(String name, String mid) {
		return memberDAO.memnberNameUpdate(name, mid);
	}

	@Override
	public int emailUpdate(String email, String mid) {
		return memberDAO.emailUpdate(email, mid);
	}

	@Override
	public MemberVO memberEmailCheck(String email) {
		return memberDAO.memberEmailCheck(email);
	}

	@Override
	public int memberPwdChange(HttpSession session, String oldPwd, String pwd) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberDAO.memberMidCheck(mid);
		if(passwordEncoder.matches(oldPwd, vo.getPwd())) {
			pwd = passwordEncoder.encode(pwd);
			int res = memberDAO.memberPwdChange(mid,pwd);
			session.invalidate();
			return res;
		}
		else return 0;
	}

	@Override
	public int memberDelete(HttpSession session, String why) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		int res = memberDAO.memberDelete(mid,why);
		if(res==1) {
			session.invalidate();
			return 1;
		}
		else return 0;
	}

	@Override
	public int profileChange(MultipartFile file, HttpSession session) {
		int res = 0;
		
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		String fileName = file.getOriginalFilename();
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		String profile = UUID.randomUUID().toString().substring(0,12) + "_" + fileName;
		String realPath = session.getServletContext().getRealPath("/resources/profile/");
		MemberVO vo = memberDAO.memberMidCheck(mid);
		
		int maxSize = 1024 * 1024 * 10;
		if(file.getSize() > maxSize || (!ext.equals("jpg")&&!ext.equals("png"))) return res;
		
		try {
			FileOutputStream fos = new FileOutputStream(realPath + profile);
			if(file.getBytes().length != -1) {
				fos.write(file.getBytes());
				int res2 = memberDAO.profileChange(mid,profile);
				// db에서 프로필 수정 후 기존 프로필 사진 서버에서 삭제시키기
				if(res2==1 && !vo.getProfile().equals("noImage.jpg")) {
					new File(realPath + vo.getProfile()).delete();
					session.setAttribute("sProfile", profile);
				}
				res = 1;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
}
