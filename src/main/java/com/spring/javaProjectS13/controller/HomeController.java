package com.spring.javaProjectS13.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.MemberVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = {"/","/home"}, method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		int maxExp = 0;
		int level = 0;
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.memberMidCheck(mid);
		if(vo!=null) level = vo.getLevel();
		if(level==1) maxExp = 500;
		else if(level==2) maxExp = 1000;
		else if(level==3) maxExp = 2000;
		else if(level==4) maxExp = 5000;
		else if(level==5) maxExp = 10000;
		
		model.addAttribute("vo",vo);
		model.addAttribute("maxExp",maxExp);
		
		return "home";
	}
	
}
