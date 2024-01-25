package com.spring.javaProjectS13.controller;

import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.AlarmVO;
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
		
		if(res==1) return "redirect:/message/member/memberJoinOk";
		else return "redirect:/message/member/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = {"/memberJoin/mailCodeSend","/mailCodeSend"}, method = RequestMethod.POST)
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
	@RequestMapping(value = {"/memberJoin/mailCodeCheck","/mailCodeCheck"}, method = RequestMethod.POST)
	public String mailCodeCheckPost(String mailCode, HttpSession session) {
		String code = session.getAttribute("mailCode")==null ? "" : (String)session.getAttribute("mailCode");
		String res = "0";
		
		if(code.equals("")) res = "0";
		else if(code.equals(mailCode)) res = "1";
		else res = "2";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberJoin/memberMidCheck", method = RequestMethod.POST)
	public String memberMidCheckPost(String mid) {
		String res = "0";
		
		MemberVO vo = memberService.memberMidCheck(mid);
		if(vo == null) res = "1";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = {"/memberJoin/memberNickCheck","/memberNickCheck"}, method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		String res = "0";
		
		MemberVO vo = memberService.memberNickCheck(nickName);
		if(vo == null) res = "1";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = {"/memberJoin/memberEmailCheck","/memberEmailCheck"}, method = RequestMethod.POST)
	public String memberEmailCheckPost(String email) {
		String res = "0";
		
		MemberVO vo = memberService.memberEmailCheck(email);
		if(vo == null) res = "1";
		
		return res;
	}
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(String mid, String pwd, String idSave, HttpSession session, HttpServletResponse response) {
		int res = memberService.memberLogin(mid, pwd, idSave, session, response);
		
		if(res==1) return "redirect:/message/member/memberLoginOk";
		else return "redirect:/message/member/memberLoginNo";
	}
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		memberService.memberLogout(session);
		
		return "redirect:/message/member/memberLogoutOk";
	}
	
	@RequestMapping(value = "/memberIdPwdFind", method = RequestMethod.GET)
	public String memberIdPwdFindGet() {
		return "member/memberIdPwdFind";
	}
	
	@RequestMapping(value = "/myPageIframe", method = RequestMethod.GET)
	public String myPageGet() {
		return "member/myPageIframe";
	}
	
	@RequestMapping(value = "/myPage1", method = RequestMethod.GET)
	public String myPage1Get() {
		return "member/myPage1";
	}
	
	@RequestMapping(value = "/myPage2", method = RequestMethod.GET)
	public String myPage2Get() {
		return "member/myPage2";
	}
	
	@RequestMapping(value = "/myPage3", method = RequestMethod.GET)
	public String myPage3Get(Model model, HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO mVo = memberService.memberMidCheck(mid);
		
		model.addAttribute("mVo",mVo);
		return "member/myPage3";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(HttpSession session, Model model) {
		MemberVO vo = memberService.memberUpdate(session);
		
		model.addAttribute("vo",vo);
		
		return "member/memberUpdate";
	}
	
	@RequestMapping(value = "/nickNameUpdate", method = RequestMethod.GET)
	public String nickNameUpdateGet(String nickName, HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		int res = memberService.nickNameUpdate(nickName, mid);
		
		if(res==1) return "redirect:/message/member/nickNameUpdateOk";
		else return "redirect:/message/member/nickNameUpdateNo";
	}
	
	@RequestMapping(value = "/memnberNameUpdate", method = RequestMethod.GET)
	public String memnberNameUpdateGet(String name, HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		int res = memberService.memnberNameUpdate(name, mid);
		
		if(res==1) return "redirect:/message/member/memnberNameUpdateOk";
		else return "redirect:/message/member/memnberNameUpdateOk";
	}
	
	@RequestMapping(value = "/emailUpdate", method = RequestMethod.GET)
	public String emailUpdateGet(String email, HttpSession session) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		int res = memberService.emailUpdate(email, mid);
		
		if(res==1) return "redirect:/message/member/emailUpdateOk";
		else return "redirect:/message/member/emailUpdateNo";
	}
	
	@RequestMapping(value = "/memberPwdChange", method = RequestMethod.GET)
	public String memberPwdChangeGet() {
		return "member/memberPwdChange";
	}
	
	@RequestMapping(value = "/memberPwdChange", method = RequestMethod.POST)
	public String memberPwdChangePost(HttpSession session, String pwd, String newPwd) {
		int res = memberService.memberPwdChange(session, pwd, newPwd);
		
		if(res==1) return "redirect:/message/member/memberPwdChangeOk";
		else return "redirect:/message/member/memberPwdChangeNo";
	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDeleteGet() {
		return "member/memberDelete";
	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePost(HttpSession session, String why) {
		int res = memberService.memberDelete(session, why);
		
		if(res==1) return "redirect:/message/member/memberDeleteOk";
		else return "redirect:/message/member/memberDeleteNo";
	}
	
	// 프로필 사진 변경
	@RequestMapping(value = "/profileChange", method = RequestMethod.POST)
	public String profileChangeGet(MultipartFile file, HttpSession session) {
		int res = memberService.profileChange(file, session);
		
		if(res==1) return "redirect:/message/member/profileChangeOk";
		else return "redirect:/message/member/profileChangeNo";
	}
	
	// 기본 프로필 사진으로 변경
	@RequestMapping(value = "/basicProfileChange", method = RequestMethod.GET)
	public String basicProfileChangeGet(HttpSession session) {
		memberService.basicProfileChange(session);
		
		return "member/myPageIframe";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdFind", method = RequestMethod.POST)
	public String memberIdFindPost(String name, String email) {
		String mid = memberService.memberIdFind(name, email);
		
		return mid;
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberPwdFind", method = RequestMethod.POST)
	public String memberPwdFindPost(String mid, String email, HttpSession session) {
		String res = memberService.memberPwdFind(mid, email, session);
		
		return res;
	}
	
	@RequestMapping(value = "/memberPwdReset", method = RequestMethod.POST)
	public String memberPwdResetPost(String pwd, String email) {
		int res = memberService.memberPwdReset(pwd, email);
		
		if(res==1) return "redirect:/message/member/memberPwdResetOk";
		else return "redirect:/message/member/memberPwdResetNo";
	}
	
	// 키워드 추가
	@ResponseBody
	@RequestMapping(value = "/inputKeyword", method = RequestMethod.POST)
	public String inputKeywordPost(String keyword, HttpSession session) {
		int res = memberService.inputKeyword(keyword, session);
		return res + ""; 
	}
	// 키워드 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteKeyword", method = RequestMethod.POST)
	public void deleteKeywordPost(String keyword, HttpSession session) {
		memberService.deleteKeyword(keyword, session);
	}
	
	// 알람 리스트 비동기로 불러오기
	@RequestMapping(value = "/alarmList", method = RequestMethod.GET)
	public String alarmListGet(Model model, HttpSession session) {
		List<AlarmVO> aVos = memberService.alarmList((int)session.getAttribute("sIdx"));
		
		model.addAttribute("aVos",aVos);
		return "include/userInfo";
	}
	
	// 알람 읽음 처리
	@ResponseBody
	@RequestMapping(value = "/alarmRead", method = RequestMethod.GET)
	public void alarmReadGet(HttpSession session) {
		memberService.alarmRead((int)session.getAttribute("sIdx"));
	}
}
