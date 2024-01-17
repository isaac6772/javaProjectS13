package com.spring.javaProjectS13.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javaProjectS13.service.NewsService;

@RequestMapping("/news")
@Controller
public class NewsController {
	
	@Autowired
	NewsService newsService;
}
