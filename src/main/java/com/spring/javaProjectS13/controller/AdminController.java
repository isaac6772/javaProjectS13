package com.spring.javaProjectS13.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.BoardService;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.service.ServiceService;
import com.spring.javaProjectS13.vo.AdVO;
import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	BoardService boardService;
	@Autowired
	ServiceService serviceService;
	
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
	public String adManagerGet(Model model) {
		List<ServiceVO> vos = serviceService.availableAdList();
		List<AdVO> aVos = serviceService.adList();
		
		model.addAttribute("aVos",aVos);
		model.addAttribute("vos",vos);
		return "admin/adManager";
	}
	
	// 게시할 광고 리스트 저장하기
	@RequestMapping(value = "/adManager", method = RequestMethod.POST)
	public String adManagerPost(String[] fileName, int[] serviceIdx) {
		int res = serviceService.inputAd(fileName, serviceIdx);
		
		if(res!=0) return "redirect:/message/admin/adInputOk";
		else return "redirect:/message/admin/adInputNo";
	}
	
	// 관리자화면에서 광고문의 게시글을 삭제할때(다중 삭제 가능)
	@RequestMapping(value = "/adServiceDelete", method = RequestMethod.GET)
	public String adServiceDeleteGet(String idx) {
		int res = serviceService.adServiceDelete(idx);
		
		if(res!=0) return "redirect:/message/admin/adServiceDeleteOk";
		else return "redirect:/message/admin/adServiceDeleteNo";
	}
	
	@RequestMapping(value = "/boardManager", method = RequestMethod.GET)
	public String boardManagerGet(Model model, PageVO pageVO) {
		List<BoardVO> bVos = boardService.boardList(pageVO);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("bVos",bVos);
		return "admin/boardManager";
	}
	
	@RequestMapping(value = "/reportManager", method = RequestMethod.GET)
	public String reportManagerGet(Model model) {
		return "admin/reportManager";
	}
}
