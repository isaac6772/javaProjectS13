package com.spring.javaProjectS13.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboardGet() {
		return "admin/dashboard";
	}
	
	@RequestMapping(value = "/memberManager", method = RequestMethod.GET)
	public String memberManagerGet(Model model, PageVO pageVO) {
		List<MemberVO> vos = memberService.memberList(pageVO);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		
		return "admin/memberManager";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(MemberVO vo) {
		int res = memberService.memberUpdate(vo);
		
		if(res==1) return "redirect:/message/admin/memberUpdateOk";
		else return "redirect:/message/admin/memberUpdateNo?msgFlag=" + res;
	}
	
	@RequestMapping(value = "/selectedMemberDelete", method = RequestMethod.GET)
	public String selectedMemberDeleteGet(String memberIdxArray) {
		int res = memberService.selectedMemberDelete(memberIdxArray);
		
		if(res!=0) return "redirect:/message/admin/selectedMemberDeleteOk";
		else return "redirect:/message/admin/selectedMemberDeleteNo";
	}
	
	@RequestMapping(value = "/adManager", method = RequestMethod.GET)
	public String adManagerGet() {
		return "admin/adManager";
	}
}
