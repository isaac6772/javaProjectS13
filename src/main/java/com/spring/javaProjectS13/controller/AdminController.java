package com.spring.javaProjectS13.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboardGet() {
		return "admin/dashboard";
	}
	
	@RequestMapping(value = "/memberManager", method = RequestMethod.GET)
	public String memberManagerGet() {
		return "admin/memberManager";
	}
}
