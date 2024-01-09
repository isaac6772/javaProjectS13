package com.spring.javaProjectS13.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/service")
public class ServiceController {
	
	@RequestMapping("/serviceList")
	public String serviceListGet() {
		return "service/serviceList"; 
	}
	
	@RequestMapping("/serviceInput")
	public String serviceInputGet() {
		return "service/serviceInput"; 
	}
}
