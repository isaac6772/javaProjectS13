package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.KeywordVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReportVO;

public interface AdminDAO {

	public int totRecCnt(@Param("vo") PageVO vo);

	public List<ReportVO> reportList(@Param("vo") PageVO vo);

	public int selectedBoardDelete(String boardIdxArray);

	public int selectedReportDelete(String reportIdxArray);

	public void reportContentDeleteAlarm(@Param("reporter") int reporter, @Param("memberIdx") int memberIdx, @Param("idxWho") int idxWho);

	public void reportCheckChange(@Param("idx") int idx);

	public int serviceCnt(@Param("date") String date);

	public int boardCnt(@Param("date") String date);

	public int discussionCnt(@Param("date") String date);

	public int joinData(@Param("date") String date);

	public List<KeywordVO> keywordData();

	public int boardAllCnt();

	public int getReplyCnt();

	public int getMemberCnt();

	public int getVisitCnt();
	
}
