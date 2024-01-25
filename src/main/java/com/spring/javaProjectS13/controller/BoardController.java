package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS13.service.BoardService;
import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReplyVO;

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
	public String boardContentGet(int idx, PageVO pageVO, Model model, HttpSession session) {
		int memberIdx = session.getAttribute("sIdx") == null ? 0 : (int) session.getAttribute("sIdx");
		BoardVO bVo = boardService.boardContent(idx, memberIdx);
		List<ReplyVO> replyVos = boardService.contentReply(idx);
		int recommend = boardService.getRecommend(idx, memberIdx);
		
		model.addAttribute("recommend",recommend);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("replyVos",replyVos);
		model.addAttribute("bVo",bVo);
		return "board/boardContent";
	}
	
	@RequestMapping(value = "/inputReply", method = RequestMethod.POST)
	public String inputReplyPost(ReplyVO vo, HttpSession session) {
		int res = boardService.inputReply(vo, session);
		
		if(res==1) return "redirect:/message/board/inputReplyOk?idx=" + vo.getBoardIdx();
		else return "redirect:/message/board/inputReplyNo?idx=" + vo.getBoardIdx();
	}
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model) {
		BoardVO vo = boardService.boardContent(idx);
		model.addAttribute("vo",vo);
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo, HttpSession session, HttpServletRequest request) {
		int res = boardService.boardUpdate(vo, session, request);
		
		if(res==1) return "redirect:/message/board/boardUpdateOk?idx=" + vo.getIdx();
		else return "redirect:/message/board/boardUpdateNo?idx=" + vo.getIdx();
	}
	
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx, HttpSession session) {
		int res = boardService.boardDelete(idx, session);
		
		if(res==1) return "redirect:/message/board/boardDeleteOk";
		else return "redirect:/message/board/boardDeleteNo?idx=" + idx;
	}
	
	@RequestMapping(value = "/deleteReply", method = RequestMethod.GET)
	public String deleteReplyGet(int idx, int boardIdx, HttpSession session) {
		int res = boardService.deleteReply(idx, boardIdx, session);
		
		if(res==1) return "redirect:/message/board/deleteReplyOk?idx=" + boardIdx;
		else return "redirect:/message/board/deleteReplyNo?idx=" + boardIdx;
	}
	
	@RequestMapping(value = "/updateReply", method = RequestMethod.POST)
	public String updateReplyPost(ReplyVO vo, HttpSession session) {
		int res = boardService.updateReply(vo, session);
		
		if(res==1) return "redirect:/message/board/updateReplyOk?idx=" + vo.getBoardIdx();
		else return "redirect:/message/board/updateReplyNo?idx=" + vo.getBoardIdx();
	}
	
	@ResponseBody
	@RequestMapping(value = "/cancelRecommend", method = RequestMethod.POST)
	public String cancelRecommendPost(int idx, HttpSession session) {
		int res = boardService.cancelRecommend(idx, session);
		
		return res + "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setGood", method = RequestMethod.POST)
	public String setGoodPost(int idx, HttpSession session) {
		int res = boardService.setGood(idx, session);
		
		return res + "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setBad", method = RequestMethod.POST)
	public String setBadPost(int idx, HttpSession session) {
		int res = boardService.setBad(idx, session);
		
		return res + "";
	}
}
