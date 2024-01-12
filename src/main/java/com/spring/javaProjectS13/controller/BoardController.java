package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS13.service.BoardService;
import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model, PageVO pageVO) {
		List<BoardVO> vos = boardService.boardList(pageVO);
		List<BoardVO> iVos = boardService.informList();		// 공지사항 리스트만 따로 불러오게 처리
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		model.addAttribute("iVos",iVos);
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo, HttpSession session, HttpServletRequest request) {
		int res = boardService.boardInput(vo, session, request);
		
		if(res==1) return "redirect:/message/board/boardInputOk";
		else return "redirect:/message/board/boardInputNo";
	}
	
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, Model model) {
		BoardVO vo = boardService.boardContent(idx);
		
		model.addAttribute("vo",vo);
		return "board/boardContent";
	}
}
