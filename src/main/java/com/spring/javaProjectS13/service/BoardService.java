package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReplyVO;

public interface BoardService {

	public int boardInput(BoardVO vo, HttpSession sesion, HttpServletRequest request);

	public List<BoardVO> boardList(PageVO pageVO);

	public List<BoardVO> informList();

	public BoardVO boardContent(int idx, int memberIdx);

	public List<ReplyVO> contentReply(int idx);

	public int inputReply(ReplyVO vo, HttpSession session);

	public int boardUpdate(BoardVO vo, HttpSession session, HttpServletRequest request);

	public int boardDelete(int idx, HttpSession session);

	public int deleteReply(int idx, int boardIdx, HttpSession session);

	public int updateReply(ReplyVO vo, HttpSession session);

	public BoardVO boardContent(int idx);

	public int getRecommend(int idx, int memberIdx);

	public int cancelRecommend(int idx, HttpSession session);

	public int setGood(int idx, HttpSession session);

	public int setBad(int idx, HttpSession session);

}
