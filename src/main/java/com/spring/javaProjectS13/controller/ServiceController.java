package com.spring.javaProjectS13.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.service.ServiceService;

@Controller
@RequestMapping("/service")
public class ServiceController {
	@Autowired
	ServiceService serviceService;
	
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public String serviceListGet() {
		return "service/serviceList"; 
	}
	
	@RequestMapping(value = "/serviceInput", method = RequestMethod.GET)
	public String serviceInputGet() {
		return "service/serviceInput"; 
	}
	
	@RequestMapping(value = "/serviceInput", method = RequestMethod.POST)
	public String serviceInputPost(MultipartFile file) {
		serviceService.serviceInput(file);
		
		return "service/serviceInput"; 
	}
}
