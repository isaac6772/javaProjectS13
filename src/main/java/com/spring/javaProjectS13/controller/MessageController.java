package com.spring.javaProjectS13.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@RequestMapping(value = "/member/{msgFlag}", method = RequestMethod.GET)
	public String memberMessage(Model model, @PathVariable String msgFlag) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg","회원가입을 축하드립니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg","회원가입에 실패하였습니다.");
			model.addAttribute("url","member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg","");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg","아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("msg","로그아웃 되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("nickNameUpdateOk")) {
			model.addAttribute("msg","닉네임이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("nickNameUpdateNo")) {
			model.addAttribute("msg","닉네임 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("memnberNameUpdateOk")) {
			model.addAttribute("msg","이름이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("memnberNameUpdateNo")) {
			model.addAttribute("msg","이름 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("emailUpdateOk")) {
			model.addAttribute("msg","메일이 변경되었습니다.");
			model.addAttribute("url","member/memberUpdate");
		}
		else if(msgFlag.equals("emailUpdateNo")) {
			model.addAttribute("msg","메일 변경에 실패하였습니다.");
			model.addAttribute("url","member/memberUpdate");
		}
		else if(msgFlag.equals("memberPwdChangeOk")) {
			model.addAttribute("msg","비밀번호가 변경되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberPwdChangeNo")) {
			model.addAttribute("msg","비밀번호가 틀렸습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberPwdChange");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg","회원탈퇴가 성공적으로 처리되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg","회원탈퇴에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberDelete");
		}
		else if(msgFlag.equals("profileChangeOk")) {
			model.addAttribute("msg","프로필 사진이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=myPage1");
		}
		else if(msgFlag.equals("profileChangeNo")) {
			model.addAttribute("msg","프로필 사진 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=myPage1");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/interceptor/{interceptorFlag}")
	public String loginNo(Model model, @PathVariable String interceptorFlag) {
		if(interceptorFlag.equals("loginNo")) {
			model.addAttribute("msg","로그인 후 이용바랍니다.");
			model.addAttribute("url","home");
		}
		else if(interceptorFlag.equals("adminNo")) {
			model.addAttribute("msg","관리자 계정만 접근가능합니다.");
			model.addAttribute("url","home");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/admin/{adminFlag}")
	public String adminMessage(Model model, @PathVariable String adminFlag, String msgFlag) {
		if(adminFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg","회원정보가 수정되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("memberUpdateNo")) {
			String msg = "";
			if(msgFlag.equals("2")) msg = "아이디가 형식에 맞지않습니다.";
			else if(msgFlag.equals("3")) msg = "중복된 아이디가 존재합니다.";
			else if(msgFlag.equals("4")) msg = "닉네임이 형식에 맞지 않습니다";
			else if(msgFlag.equals("5")) msg = "중복된 닉네임이 존재합니다.";
			else if(msgFlag.equals("6")) msg = "이름이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("7")) msg = "이메일이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("8")) msg = "중복된 이메일이 존재합니다.";
			else if(msgFlag.equals("9")) msg = "레벨이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("10")) msg = "포인트가 형식에 맞지 않습니다.";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("selectedMemberDeleteOk")) {
			model.addAttribute("msg","선택한 회원이 삭제되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("selectedMemberDeleteNo")) {
			model.addAttribute("msg","회원을 삭제하는 동안 오류가 발생했습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		
		return "include/message";
	}
}
