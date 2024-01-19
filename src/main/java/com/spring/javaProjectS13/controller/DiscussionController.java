package com.spring.javaProjectS13.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.DiscussionService;
import com.spring.javaProjectS13.vo.DiscussionVO;

@Controller
@RequestMapping("/discussion")
public class DiscussionController {
	@Autowired
	DiscussionService discussionService;
	
	@RequestMapping(value = "/discussionList", method = RequestMethod.GET)
	public String discussionListGet(Model model) {
		List<DiscussionVO> dVos = discussionService.discussionList();
		
		model.addAttribute("dVos",dVos);
		return "discussion/discussionList";
	}
}
