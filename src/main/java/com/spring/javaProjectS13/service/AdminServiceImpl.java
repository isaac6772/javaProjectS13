package com.spring.javaProjectS13.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaProjectS13.dao.AdminDAO;
import com.spring.javaProjectS13.dao.BoardDAO;
import com.spring.javaProjectS13.vo.KeywordVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ReportVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;
	@Autowired
	BoardDAO boardDAO;
	@Autowired
	ObjectMapper objectMapper;

	@Override
	public List<ReportVO> reportList(PageVO vo) {
		vo.setStartIndexNo(vo.getPageSize() * (vo.getPag() - 1));
		vo.setTotRecCnt(adminDAO.totRecCnt(vo));
		vo.setTotPage(vo.getTotRecCnt()%vo.getPageSize()==0 ? vo.getTotRecCnt()/vo.getPageSize() : vo.getTotRecCnt()/vo.getPageSize()+1);
		vo.setCurBlock((vo.getPag() - 1)/10);
		vo.setScrStartNo(vo.getTotRecCnt()-vo.getStartIndexNo());
		
		return adminDAO.reportList(vo);
	}

	@Override
	public int selectedBoardDelete(String boardIdxArray) {
		return adminDAO.selectedBoardDelete(boardIdxArray);
	}

	@Override
	public int selectedReportDelete(String reportIdxArray) {
		return adminDAO.selectedReportDelete(reportIdxArray);
	}

	@Override
	public int reportContentDelete(String reportType, int reportIdx, int reporter, int memberIdx, int idx, int idxWho) {
		int res = 0;
		
		if(reportType.equals("board")) {
			res = boardDAO.boardDelete(reportIdx);
		}
		else if(reportType.equals("boardReply")) {
			res = boardDAO.deleteReply(reportIdx);
		}
		
		if(res!=0) {
			adminDAO.reportContentDeleteAlarm(reporter,memberIdx,idxWho);
			adminDAO.reportCheckChange(idx);
		}
		
		return res;
	}

	@Override
	public String getBoardData() {
		Object[] dataArray = new Object[6];
		dataArray[0] = new String[] {"달","고객문의","게시판","토론"};
		LocalDate today = LocalDate.now();
		
		for(int i=1; i<=5; i++) {
			String date = today.minusDays(6-i).toString().substring(0,10);
			int serviceCnt = adminDAO.serviceCnt(date);
			int boardCnt = adminDAO.boardCnt(date);
			int discussionCnt = adminDAO.discussionCnt(date);
			date = date.substring(5).replace("-", "월") + "일";
			dataArray[i] = new Object[] {date,serviceCnt,boardCnt,discussionCnt};
		}
		
		String data = null;
		
		try {
			data = objectMapper.writeValueAsString(dataArray);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return data;
	}

	@Override
	public String getJoinData() {
		Object[] dataArray = new Object[6];
		dataArray[0] = new String[] {"일","가입자 수"};
		LocalDate today = LocalDate.now();
		
		for(int i=1; i<=5; i++) {
			String date = today.minusDays(6-i).toString().substring(0,10);
			int joinData = adminDAO.joinData(date);
			date = date.substring(5).replace("-", "월") + "일";
			dataArray[i] = new Object[] {date,joinData};
		}
		
		String data = null;
		
		try {
			data = objectMapper.writeValueAsString(dataArray);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return data;
	}

	@Override
	public String getkeywordData() {
		Object[] dataArray = new Object[6];
		dataArray[0] = new String[] {"검색어","검색횟수"};
		List<KeywordVO> vos = adminDAO.keywordData();
		
		for(int i=1; i<=5; i++) {
			if(vos.get(i-1) != null) {
				dataArray[i] = new Object[] {vos.get(i-1).getKeyword(),vos.get(i-1).getCnt()};
			}
		}
		
		String data = null;
		
		try {
			data = objectMapper.writeValueAsString(dataArray);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return data;
	}

	@Override
	public int getBoardCnt() {
		return adminDAO.boardAllCnt();
	}

	@Override
	public int getReplyCnt() {
		return adminDAO.getReplyCnt();
	}

	@Override
	public int getMemberCnt() {
		return adminDAO.getMemberCnt();
	}

	@Override
	public int getVisitCnt() {
		return adminDAO.getVisitCnt();
	}
}
