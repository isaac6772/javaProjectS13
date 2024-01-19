package com.spring.javaProjectS13.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.DiscussionService;

@Controller
@RequestMapping("/discussion")
public class DiscussionController {
	@Autowired
	DiscussionService discussionService;
	
	@RequestMapping(value = "/discussionList", method = RequestMethod.GET)
	public String discussionListGet() {
		return "discussion/discussionList";
	}
}
