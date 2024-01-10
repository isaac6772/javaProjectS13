package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.service.LevelCalculator;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.MemberVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	LevelCalculator levelCalculator;
	
	@RequestMapping(value = {"/","/home"}, method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		int maxExp = 0;
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.memberMidCheck(mid);
		List<MemberVO> friendList = null;
		
		// 로그인 되어있을때
		if(vo!=null) {
			// 멤버 박스에 들어갈 경험치 계산
			maxExp = levelCalculator.calcMaxExp(vo.getLevel());
			
			// 홈화면에 띄우는 친구 목록 불러오기
			friendList = memberDAO.friendList(vo.getIdx());
		}
		
		model.addAttribute("friendList",friendList);
		model.addAttribute("vo",vo);
		model.addAttribute("maxExp",maxExp);
		
		return "home/home";
	}
	
}
