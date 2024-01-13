package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReplyVO;

public interface BoardDAO {

	public int boardInput(@Param("vo") BoardVO vo);

	public List<BoardVO> boardList(@Param("vo") PageVO vo);

	public int totRecCnt(@Param("vo") PageVO vo);

	public List<BoardVO> informList();

	public BoardVO boardContent(@Param("idx") int idx);

	public List<ReplyVO> contentReply(@Param("idx") int idx);

	public int inputReply(@Param("vo") ReplyVO vo);

	public int boardUpdate(@Param("vo") BoardVO vo);

}
