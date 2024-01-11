package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.vo.AdVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

public interface ServiceService {

	public int serviceInput(List<MultipartFile> fileList, ServiceVO vo);

	public List<ServiceVO> serviceList(PageVO vo);

	public ServiceVO serviceContent(int idx, HttpSession session);

	public int serviceReply(List<MultipartFile> fileList, ServiceVO vo);

	public int deleteService(int idx, HttpSession session);

	public List<ServiceVO> availableAdList();

	public int adServiceDelete(String idx);

	public List<AdVO> adList();

	public int inputAd(String[] fileName, int[] serviceIdx);

}
