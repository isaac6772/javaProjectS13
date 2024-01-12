package com.spring.javaProjectS13.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS13.dao.BoardDAO;
import com.spring.javaProjectS13.vo.BoardVO;
import com.spring.javaProjectS13.vo.PageVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public int boardInput(BoardVO vo, HttpSession session, HttpServletRequest request) {
		String ckPath = session.getServletContext().getRealPath("/resources/data/ckeditor/");
		String realPath = session.getServletContext().getRealPath("/resources/data/board/board/");
		
		// ckeditor 폴더에 있는 파일 중에 실제 저장할 파일을 골라서 board폴더에 저장시키기
		String content = vo.getContent();
		ArrayList<String> files = new ArrayList<String>();
		while(true) {
			if(content.indexOf("<img src=\"/") != -1) {
				content = content.substring(content.indexOf("<img src=\"/")+40);
				String img = content.substring(0,content.indexOf("\""));
				files.add(img);
			}
			else break;
		}
		
		try {
			for(String file : files) {
				FileInputStream fis = new FileInputStream(ckPath + file);
				FileOutputStream fos = new FileOutputStream(realPath + file);
				
				byte[] data = new byte[2048]; 
				int cnt = 0;
				while((cnt = fis.read(data)) != -1) {
					fos.write(data,0,cnt);
				}
				
				fos.flush();
				fos.close();
				fis.close();
				
				// ckeditor에 있는 파일은 삭제시킨다.
				new File(ckPath + file).delete();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// vo에 저장된 경로명바꾸기(ckeditor -> board)
		String contextPath = request.getContextPath();
		vo.getContent().replace("<img src=\"/"+contextPath+"/data/ckeditor/", "<img src=\"/javaProjectS13/board/");
		
		// 태그를 제외한 문자 저장하기
		String reg = "<[^>]+>";
		vo.setContentText(vo.getContent().replaceAll(reg, "").replaceAll("&nbsp;", ""));
		int res = boardDAO.boardInput(vo);
		
		return res;
	}

	@Override
	public List<BoardVO> boardList(PageVO vo) {
		if(vo.getSearchType().equals("mid")) vo.setSearchType("all");
		
		vo.setStartIndexNo(vo.getPageSize() * (vo.getPag() - 1));
		vo.setTotRecCnt(boardDAO.totRecCnt(vo));
		vo.setTotPage(vo.getTotRecCnt()%vo.getPageSize()==0 ? vo.getTotRecCnt()/vo.getPageSize() : vo.getTotRecCnt()/vo.getPageSize()+1);
		vo.setCurBlock((vo.getPag() - 1)/10);
		vo.setScrStartNo(vo.getTotRecCnt()-vo.getStartIndexNo());
		
		return boardDAO.boardList(vo);
	}

	@Override
	public List<BoardVO> informList() {
		return boardDAO.informList();
	}
}
