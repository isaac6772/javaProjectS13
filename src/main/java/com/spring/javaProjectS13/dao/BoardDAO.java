package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.RecommendVO;
import com.spring.javaProjectS13.vo.ReplyVO;
import com.spring.javaProjectS13.vo.ReportVO;
import com.spring.javaProjectS13.vo.ViewNumVO;

public interface BoardDAO {

	public int boardInput(@Param("vo") BoardVO vo);

	public List<BoardVO> boardList(@Param("vo") PageVO vo);

	public int totRecCnt(@Param("vo") PageVO vo);

	public List<BoardVO> informList();

	public BoardVO boardContent(@Param("idx") int idx);

	public List<ReplyVO> contentReply(@Param("idx") int idx);

	public int inputReply(@Param("vo") ReplyVO vo);

	public int boardUpdate(@Param("vo") BoardVO vo);

	public int boardDelete(@Param("idx") int idx);

	public ReplyVO getReply(@Param("idx") int idx);

	public int deleteReply(@Param("idx") int idx);

	public int updateReply(@Param("vo") ReplyVO vo);

	public ViewNumVO getViewNum(@Param("idx") int idx, @Param("memberIdx") int memberIdx);

	public void setViewNum(@Param("boardIdx") int boardIdx, @Param("memberIdx") int memberIdx);

	public void ViewNumPlus(@Param("idx") int boardIdx);

	public void updateViewNum(@Param("idx") int idx);

	public RecommendVO getRecommend(@Param("boardIdx") int idx, @Param("memberIdx") int memberIdx);

	public int cancelRecommend(@Param("idx") int idx, @Param("memberIdx") int memberIdx);

	public int updateRecommend(@Param("idx") int idx, @Param("flag") int flag);

	public int setRecommend(@Param("idx") int idx, @Param("memberIdx") int memberIdx, @Param("flag") int flag);

	public int boardRecommendUpdate(@Param("idx") int idx, @Param("field") String field, @Param("flag") int flag);

	public void replyAlarm(@Param("memberIdx") int memberIdx, @Param("memberIdxWho") int memberIdxWho, @Param("idx") int idx);

	public int reportConfirm(@Param("reportType") String reportType, @Param("reportIdx") int reportIdx, @Param("reporter") int reporter);

	public int report(@Param("vo") ReportVO vo);

	public void deleteBoardReply(@Param("idx") int idx);

}
