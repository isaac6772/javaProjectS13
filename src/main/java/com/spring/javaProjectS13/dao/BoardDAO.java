package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;

public interface BoardDAO {

	public int boardInput(@Param("vo") BoardVO vo);

	public List<BoardVO> boardList(@Param("vo") PageVO vo);

	public int totRecCnt(@Param("vo") PageVO vo);

	public List<BoardVO> informList();

}
