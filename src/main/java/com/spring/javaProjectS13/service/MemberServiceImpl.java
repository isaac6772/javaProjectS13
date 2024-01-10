package com.spring.javaProjectS13.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.PageVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	JavaMailSender mailSender;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	LevelCalculator levelCalculator;

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
	
	@Transactional
	@Override
	public int memberLogin(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response) {
		MemberVO vo = memberDAO.memberMidCheck(mid);
		if(vo != null && vo.getLevel()!= 0 &&passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sMid", mid);
			session.setAttribute("sIdx", vo.getIdx());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sProfile", vo.getProfile());
			session.setAttribute("sEmail", vo.getEmail());
			session.setAttribute("sLevel", vo.getLevel()); 
			
			// 아이디 저장 정보 쿠키저장
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setPath("/");
			if(idSave.equals("y")) {
				cookie.setMaxAge(60*60*24*7);
			}
			else cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			// 방문횟수와 포인트, 경험치 증가시키기(마지막방문일자와 오늘날짜가 다를시)
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(new Date());
			
			if(!vo.getLastDate().substring(0,10).equals(today)) {
				int maxExp = levelCalculator.calcMaxExp(vo.getLevel());
				// 로그인시 출석 포인트 증가로 인해 레벨업을 했을때와 그렇지 않을때(maxExp==0은 관리자나 만랩이나 비회원이므로 제외)
				if(maxExp<=vo.getExp()+1 && maxExp!=0) memberDAO.memberVisitPointExpUpdate(vo.getIdx(),"levelUp");
				else memberDAO.memberVisitPointExpUpdate(vo.getIdx(),"");
			}
			// 마지막 방문시간 업데이트
			memberDAO.memberLastDateUpdate(vo.getIdx());
			
			// 로그인 테이블에 행추가
			memberDAO.memberLoginOk(vo.getIdx());
			
			return 1;
		}
		else return 0;
	}

	@Override
	public void memberLogout(HttpSession session) {
//		session.removeAttribute("sMid");
//		session.removeAttribute("sProfile");
		session.invalidate();
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
	
	// 이메일 중복 확인
	@Override
	public MemberVO memberEmailCheck(String email) {
		return memberDAO.memberEmailCheck(email);
	}
	
	// 회원 비밀번호 변경하기
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
	
	// 회원탈퇴처리
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
	
	// 프로필 사진 변경
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
				}
				res = 1;
				session.setAttribute("sProfile", profile);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	// 기본 프로필 사진으로 변경하기
	@Override
	public void basicProfileChange(HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberDAO.memberMidCheck(mid);
		String realPath = session.getServletContext().getRealPath("/resources/profile/");
		
		if(!vo.getProfile().equals("noImage.jpg")) {
			new File(realPath + vo.getProfile()).delete();
			memberDAO.profileChange(mid, "noImage.jpg");
			session.setAttribute("sProfile", "noImage.jpg");
		}
	}

	@Override
	public int memberUpdate(MemberVO vo) {
		String regMid = "^[a-zA-Z0-9]{4,15}$";
		String regNickName = "^[\\w가-힣]{2,7}$";
		String regName = "^[가-힣]{1,20}$";
		String regEmail = "^[\\w]+@[\\w]+[.][\\w]+$";
		String regLevel = "^[0-6]$";
		String regPoint = "^[\\d]+$";
		
		String mid = vo.getMid();
		String nickName = vo.getNickName();
		String name = vo.getName();
		String email = vo.getEmail();
		String level = vo.getLevel() + "";
		String point = vo.getPoint() + "";
		int idx = vo.getIdx();
		
		String originalMid = memberDAO.memberIdxSearch(idx).getMid();
		String originalNickName = memberDAO.memberIdxSearch(idx).getNickName();
		String originalEmail = memberDAO.memberIdxSearch(idx).getEmail();
		
		int res = 0;
		
		if(!mid.matches(regMid)) res = 2;
		else if(!originalMid.equals(mid) && memberDAO.memberMidCheck(mid)!=null) res = 3;
		else if(!nickName.matches(regNickName)) res = 4;
		else if(!originalNickName.equals(nickName) && memberDAO.memberNickCheck(nickName)!=null) res = 5;
		else if(!name.matches(regName)) res = 6;
		else if(!email.matches(regEmail)) res = 7;
		else if(!originalEmail.equals(email) && memberDAO.memberEmailCheck(email)!=null) res = 8;
		else if(!level.matches(regLevel)) res = 9;
		else if(!point.matches(regPoint)) res = 10;
		else res = memberDAO.memberUpdate(vo);
		
		return res;
	}

	@Override
	public List<MemberVO> memberList(PageVO vo) {
		
		vo.setStartIndexNo(vo.getPageSize() * (vo.getPag() - 1));
		vo.setTotRecCnt(memberDAO.memberTotRecCnt(vo));
		vo.setTotPage(vo.getTotRecCnt()%vo.getPageSize()==0 ? vo.getTotRecCnt()/vo.getPageSize() : vo.getTotRecCnt()/vo.getPageSize()+1);
		vo.setCurBlock((vo.getPag() - 1)/10);
		vo.setScrStartNo(vo.getTotRecCnt()-vo.getStartIndexNo());
		
		List<MemberVO> vos = memberDAO.memberList(vo);
		
		return vos;
	}

	@Override
	public int selectedMemberDelete(String memberIdxArray) {
		int res = memberDAO.selectedMemberDelete(memberIdxArray);
		
		return res;
	}
}
