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
	public String memberJoinOk(Model model, @PathVariable String msgFlag) {
		
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
		
		return "include/message";
	}
}
