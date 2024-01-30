package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.service.DiscussionService;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.vo.ChatVO;
import com.spring.javaProjectS13.vo.DiscussionVO;
import com.spring.javaProjectS13.vo.MemberVO;

@Controller
@RequestMapping("/discussion")
public class DiscussionController {
	@Autowired
	DiscussionService discussionService;
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/discussionList", method = RequestMethod.GET)
	public String discussionListGet(Model model, HttpSession session) {
		int memberIdx = session.getAttribute("sIdx") == null ? 0 : (int)session.getAttribute("sIdx");
		List<DiscussionVO> dVos = discussionService.discussionList(memberIdx);
		
		model.addAttribute("dVos",dVos);
		return "discussion/discussionList";
	}
	
	@RequestMapping(value = "/makeDiscussion", method = RequestMethod.POST)
	public String makeDiscussionPost(MultipartFile file, DiscussionVO vo, HttpSession session) {
		int res = discussionService.makeDiscussion(file,vo,session);
		
		if(res==1) return "redirect:/message/discussion/makeDiscussionOk";
		else if(res==-1) return "redirect:/message/discussion/makeDiscussionNoTime";
		else return "redirect:/message/discussion/makeDiscussionNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reservation", method = RequestMethod.POST)
	public String reservationPost(int idx, HttpSession session) {
		int res = discussionService.reservation(idx, session);
		
		return res + "";
	}
	
	@RequestMapping(value = "/enterDiscussion", method = RequestMethod.GET)
	public String enterDiscussionGet(Model model, int idx) {
		int res = discussionService.enterDiscussion(idx);
		
		if(res==1) return "redirect:/discussion/discussionChat?idx=" + idx;
		else return "redirect:/message/discussion/enterDiscussionNo";
	}

	@RequestMapping(value = "/discussionChat", method = RequestMethod.GET)
	public String discussionChatGet(Model model, int idx, HttpSession session) {
		DiscussionVO dVo = discussionService.discussion(idx);
		model.addAttribute("dVo",dVo);
		return "discussion/discussionChat";
	}
	
	@RequestMapping(value = "/discussionRecord", method = RequestMethod.GET)
	public String discussionRecordGet(Model model, int idx) {
		List<ChatVO> cVos = discussionService.chatList(idx);
		DiscussionVO dVo = discussionService.discussion(idx);
		
		model.addAttribute("dVo",dVo);
		model.addAttribute("cVos",cVos);
		return "discussion/discussionRecord";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cancelReservation", method = RequestMethod.POST)
	public String cancelReservationPost(int idx, HttpSession session) {
		int res = discussionService.cancelReservation(idx, session);
		
		return res + "";
	}
}
