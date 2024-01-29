package com.spring.javaProjectS13.service;

import java.util.List;

import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReportVO;

public interface AdminService {

	public List<ReportVO> reportList(PageVO pageVO);

	public int selectedBoardDelete(String boardIdxArray);

	public int selectedReportDelete(String reportIdxArray);

	public int reportContentDelete(String reportType, int reportIdx, int reporter, int memberIdx, int idxWho, int idxWho2);

	public String getBoardData();

	public String getJoinData();

	public String getkeywordData();

	public int getBoardCnt();

	public int getReplyCnt();

	public int getMemberCnt();

	public int getVisitCnt();
}
