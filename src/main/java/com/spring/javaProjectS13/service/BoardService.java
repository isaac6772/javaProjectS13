package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;

public interface BoardService {

	public int boardInput(BoardVO vo, HttpSession sesion, HttpServletRequest request);

	public List<BoardVO> boardList(PageVO pageVO);

	public List<BoardVO> informList();

}
