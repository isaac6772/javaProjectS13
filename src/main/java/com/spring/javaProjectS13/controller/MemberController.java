package com.spring.javaProjectS13.controller;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet(HttpSession session) {
		if(session.getAttribute("mailCode")!=null) session.removeAttribute("mailCode");    // 페이지 로드시 저장되있는 메일코드 초기화
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		int res = memberService.memberJoin(vo);
		System.out.println(res);
		
		if(res==1) return "redirect:/message/member/memberJoinOk";
		else return "redirect:/message/member/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCodeSend", method = RequestMethod.POST)
	public String mailCodeSendPost(String email, HttpSession session) throws MessagingException {
		String mailCode = UUID.randomUUID().toString().substring(0,8);
		String title = "회원가입을 위한 인증코드입니다";
		
		if(memberService.mailSend(email, title, mailCode)) {
			session.setAttribute("mailCode", mailCode);
			return "1";
		}
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCodeCheck", method = RequestMethod.POST)
	public String mailCodeCheckPost(String mailCode, HttpSession session) {
		String code = session.getAttribute("mailCode")==null ? "" : (String)session.getAttribute("mailCode");
		String res = "0";
		
		if(code.equals("")) res = "0";
		else if(code.equals(mailCode)) res = "1";
		else res = "2";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberMidCheck", method = RequestMethod.POST)
	public String memberMidCheckPost(String mid) {
		String res = "0";
		
		MemberVO vo = memberService.memberMidCheck(mid);
		if(vo == null) res = "1";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		String res = "0";
		
		MemberVO vo = memberService.memberNickCheck(nickName);
		if(vo == null) res = "1";
		
		return res;
	}
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(String mid, String pwd, String idSave, HttpSession session, 
			HttpServletResponse response, Model model) {
		int res = memberService.memberLogin(mid, pwd, idSave, session, response, model);
		
		if(res==1) return "redirect:/message/member/memberLoginOk";
		else return "redirect:/message/member/memberLoginNo";
	}
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		memberService.memberLogout(session);
		
		return "redirect:/message/member/memberLogoutOk";
	}
	
	@RequestMapping(value = "/myPageIframe", method = RequestMethod.GET)
	public String myPageGet(String flag) {
		
		return "member/myPageIframe";
	}
	
	@RequestMapping(value = "/myPage1", method = RequestMethod.GET)
	public String myPage1Get() {
		return "member/myPage1";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet() {
		return "member/memberUpdate";
	}
}
