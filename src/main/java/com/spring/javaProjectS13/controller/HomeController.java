package com.spring.javaProjectS13.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.service.BoardService;
import com.spring.javaProjectS13.service.LevelCalculator;
import com.spring.javaProjectS13.service.MemberService;
import com.spring.javaProjectS13.service.NewsService;
import com.spring.javaProjectS13.service.ServiceService;
import com.spring.javaProjectS13.vo.AdVO;
import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.Keyword;
import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.News;
import com.spring.javaProjectS13.vo.PageVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	ServiceService serviceService;
	@Autowired
	BoardService boardService;
	@Autowired
	NewsService newsService;
	@Autowired
	LevelCalculator levelCalculator;
	
	@RequestMapping(value = {"/","/home"}, method = RequestMethod.GET)
	public String home(Model model, HttpSession session, PageVO pageVO, String keyword,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part
			) {
		
		int maxExp = 0;
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO mVo = memberService.memberMidCheck(mid);
		List<MemberVO> friendList = null;
		
		// 로그인 되어있을때
		if(mVo!=null) {
			// 멤버 박스에 들어갈 경험치 계산
			maxExp = levelCalculator.calcMaxExp(mVo.getLevel());
			
			// 홈화면에 띄우는 친구 목록 불러오기
			friendList = memberService.friendList(mVo.getIdx());
			model.addAttribute("friendList",friendList);
		}
		
		// 광고리스트 불러오기
		List<AdVO> adVos = serviceService.adList();
		
		// 게시판(추천글) 불러오기
		pageVO.setPageSize(30);
		pageVO.setPart("전체");
		pageVO.setScope("추천글");
		List<BoardVO> b1Vos = boardService.boardList(pageVO);
		
		// 게시판(최신글) 불러오기
		pageVO.setPageSize(10);
		pageVO.setScope("전체글");
		pageVO.setPart(part);
		List<BoardVO> b2Vos = boardService.boardList(pageVO);
		
		// 홈페이지 접속시 무슨 키워드로 뉴스를 검색할지 처리
		if(keyword == null) {
			if(mVo==null) keyword = "정치";
			else {
				if(mVo.getKeyword()==null) keyword = "정치";
				else keyword = mVo.getKeyword().split("/")[0];
			}
		}
		
		// 워드클라우드 데이터 불러오기
		String wordCloud = newsService.keywordList(20, 0);
		
		model.addAttribute("wordCloud",wordCloud);
		model.addAttribute("keyword",keyword);
		model.addAttribute("part",part);
		model.addAttribute("b1Vos",b1Vos);
		model.addAttribute("b2Vos",b2Vos);
		model.addAttribute("adVos",adVos);
		model.addAttribute("mVo",mVo);
		model.addAttribute("maxExp",maxExp);
		
		return "home/home";
	}
	
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public void imageUploadPost(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String fileName = upload.getOriginalFilename();
		fileName = UUID.randomUUID().toString().substring(0,12) + "_" + fileName;
		
		FileOutputStream fos = new FileOutputStream(realPath + fileName);
		fos.write(upload.getBytes());
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + fileName;
		out.println("{\"originalFilename\":\"" + fileName + "\",\"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
		
		out.close();
		fos.close();
	}
	
	// 최근게시물 부분load하는 컨트롤러
	@RequestMapping(value = "/recentBoard", method = RequestMethod.GET)
	public String recentBoardGet(Model model, PageVO pageVO, @RequestParam(name = "part", defaultValue = "전체", required = false) String part) {
		pageVO.setPageSize(10);
		pageVO.setScope("전체글");
		pageVO.setPart(part);
		List<BoardVO> b2Vos = boardService.boardList(pageVO);
		model.addAttribute("b2Vos",b2Vos);
		return "home/home";
	}
	
	// 뉴스 부분load하는 컨트롤러
	@RequestMapping(value = "/keywordNews", method = RequestMethod.GET)
	public String keywordNewsGet(Model model, String keyword) {
		List<News> nVos = newsService.keywordNews(keyword, 1, 13, false);
		model.addAttribute("nVos",nVos);
		return "home/home";
	}
	
}
