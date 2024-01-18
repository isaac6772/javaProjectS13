package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.service.NewsService;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.News;

@RequestMapping("/news")
@Controller
public class NewsController {
	
	@Autowired
	NewsService newsService;
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String newsGet(Model model, HttpSession session, String keyword) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO mVo = memberService.memberMidCheck(mid);
		
		if(keyword == null) {
			if(mVo==null) keyword = "정치";
			else {
				if(mVo.getKeyword()==null) keyword = "정치";
				else keyword = mVo.getKeyword().split("/")[0];
			}
		}
		List<News> nVos = newsService.keywordNews(keyword, 20);
		
		model.addAttribute("nVos",nVos);
		model.addAttribute("mVo",mVo);
		return "news/news";
	}
}
