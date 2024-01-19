package com.spring.javaProjectS13.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.service.NewsService;
import com.spring.javaProjectS13.vo.Keyword;
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
	public String newsGet(Model model, HttpSession session, String keyword, boolean flag) {
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO mVo = memberService.memberMidCheck(mid);
		
		// 인기키워드 30개 중에서 랜덤으로 하나를 선택해서 뉴스리스트 출력
		ArrayList<Keyword> keywords = newsService.keywordListString(7,30);
		int randomNum = (int)(Math.random()*keywords.size());
		if(keyword == null) {
			if(mVo==null) keyword = keywords.get(randomNum).getText();
			else {
				if(mVo.getKeyword()==null) keyword = keywords.get(randomNum).getText();
				else keyword = mVo.getKeyword().split("/")[0];
			}
		}
		
		model.addAttribute("flag",flag);
		model.addAttribute("keywords",keywords);
		model.addAttribute("keyword",keyword);
		model.addAttribute("mVo",mVo);
		return "news/news";
	}
	
	// 비동기적으로 뉴스데이터 가져오기
	@RequestMapping(value = "/newsList", method = RequestMethod.GET)
	public String newsList(String keyword, int startLocation, Model model, boolean flag) {
		List<News> nVos = new ArrayList<News>();
		
		nVos = newsService.keywordNews(keyword, startLocation, 20, flag);
		startLocation = Integer.parseInt(nVos.get(nVos.size()-1).getTitle());
		nVos.remove(nVos.size()-1);
		
		model.addAttribute("startLocation",startLocation);
		model.addAttribute("nVos",nVos);
		return "news/news";
	}
}
