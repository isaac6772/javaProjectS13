package com.spring.javaProjectS13.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.dao.ServiceDAO;
import com.spring.javaProjectS13.vo.AdVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

@Service
public class ServiceServiceImpl implements ServiceService {
	@Autowired
	ServiceDAO serviceDAO;
	
	@Override
	public int serviceInput(List<MultipartFile> fileList, ServiceVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/service/");
		int res = 0;
		String fileName = "";
		
		try {
			if(!fileList.get(0).getOriginalFilename().equals("")) {
				for(MultipartFile file : fileList) {
					String fName = file.getOriginalFilename();
					String ext = fName.substring(fName.lastIndexOf(".")+1);
					fName = UUID.randomUUID().toString().substring(0,12) + "_" + fName;
					
					if(!ext.equals("jpg")&&!ext.equals("png")&&!ext.equals("gif")) return res;
					if(file.getSize() > 1024 * 1024 * 10) return res;
					
					FileOutputStream fos = new FileOutputStream(realPath + fName);
					byte[] data = file.getBytes();
					fos.write(data);
					fos.close();
					
					fileName += fName + "/";
				}
			}
			// 파일을 모두 정상업로드 시 DB에 등록
			if(!fileList.get(0).getOriginalFilename().equals("")) {
				vo.setFileName(fileName);
			}
			res = serviceDAO.serviceInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ServiceVO> serviceList(PageVO vo) {
		if(vo.getSearchType().equals("mid")) vo.setSearchType("all");
		vo.setTotRecCnt(serviceDAO.totRecCnt(vo));
		vo.setStartIndexNo((vo.getPag()-1)*vo.getPageSize());
		vo.setTotPage(vo.getTotRecCnt()%vo.getPageSize()==0?vo.getTotRecCnt()/vo.getPageSize():vo.getTotRecCnt()/vo.getPageSize()+1);
		vo.setCurBlock((vo.getPag()-1)/vo.getBlockSize());
		vo.setScrStartNo(vo.getTotRecCnt()-vo.getStartIndexNo());
		
		List<ServiceVO> vos = serviceDAO.serviceList(vo);
		
		return vos;
	}

	@Override
	public ServiceVO serviceContent(int idx, HttpSession session) {
		ServiceVO vo = serviceDAO.serviceContent(idx);
		
		int myIdx = session.getAttribute("sIdx")==null ? 0 : (int)session.getAttribute("sIdx");
		int level = session.getAttribute("sLevel")==null? 0 : (int)session.getAttribute("sLevel");
		if(vo.getOpen().equals("비공개") && vo.getMemberIdx()!=myIdx && level!=77) {
			return null;
		}
		
		return vo;
	}

	@Override
	public int serviceReply(List<MultipartFile> fileList, ServiceVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/service/");
		int res = 0;
		String fileName = "";
		
		try {
			if(!fileList.get(0).getOriginalFilename().equals("")) {
				for(MultipartFile file : fileList) {
					String fName = file.getOriginalFilename();
					String ext = fName.substring(fName.lastIndexOf(".")+1);
					fName = UUID.randomUUID().toString().substring(0,12) + "_" + fName;
					
					if(!ext.equals("jpg")&&!ext.equals("png")&&!ext.equals("gif")) return res;
					if(file.getSize() > 1024 * 1024 * 10) return res;
					
					FileOutputStream fos = new FileOutputStream(realPath + fName);
					byte[] data = file.getBytes();
					fos.write(data);
					fos.close();
					
					fileName += fName + "/";
				}
			}
			// 파일을 모두 정상업로드 시 DB에 등록
			if(!fileList.get(0).getOriginalFilename().equals("")) {
				vo.setFileName(fileName);
			}
			res = serviceDAO.serviceReply(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteService(int idx, HttpSession session) {
		// 현재 접속중인 회원의 idx와 게시물작성자의 idx가 일치하는 경우 혹은 관리자일 경우에만 삭제처리(일종의 유효성 처리)
		String realPath = session.getServletContext().getRealPath("/resources/data/board/service/");
		int memberIdx = session.getAttribute("sIdx")==null ? 0 : (int)session.getAttribute("sIdx");
		int level = session.getAttribute("sLevel")==null? 0 : (int)session.getAttribute("sLevel");
		ServiceVO vo = serviceDAO.serviceContent(idx);
		int serviceMemberIdx = vo.getMemberIdx();
		
		if(memberIdx!=serviceMemberIdx && level!=77) return 0;
		
		int res = serviceDAO.deleteService(idx);
		// DB에서 정상삭제후 서버에서 삭제처리
		if(res!=0 && vo.getFileName()!=null) {
			for(String fileName : vo.getFileName().split("/")) {
				new File(realPath + fileName).delete();
			}
		}
		
		// 게시물에 답글이 있을 경우 답글도 삭제처리해준다.
		if(vo.getReply()!=0) {
			serviceDAO.deleteService(vo.getReply());
		}
		
		return res;
	}

	@Override
	public List<ServiceVO> availableAdList() {
		List<ServiceVO> vos = serviceDAO.availableAdList();
		
		// 이미지를 vo의 images필드에 저장(배열로 저장시켜서 jsp에서 쉽게 쓰기위함)
		for(ServiceVO vo : vos) {
			vo.setImages(vo.getFileName().split("/"));
		}
		
		return vos;
	}

	@Override
	public int adServiceDelete(String idx) {
		return serviceDAO.adServiceDelete(idx);
	}

	@Override
	public List<AdVO> adList() {
		return serviceDAO.adList();
	}

	@Override
	public int inputAd(String[] fileName, int[] serviceIdx) {
		// DB에서 전체 삭제후 광고리스트 입력처리
		serviceDAO.deleteAdAll();
		int cnt = 0;
		int res = 0;
		
		if(fileName!=null ) {
			for(String file : fileName) {
				if(cnt==0) res = serviceDAO.inputAd(file, serviceIdx[cnt]);
				else res *= serviceDAO.inputAd(file, serviceIdx[cnt]);
			}
			return res;
		}
		else return 1;
	}


}
