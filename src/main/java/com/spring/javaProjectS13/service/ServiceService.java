package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

public interface ServiceService {

	public int serviceInput(List<MultipartFile> fileList, ServiceVO vo);

	public List<ServiceVO> serviceList(PageVO vo);

	public ServiceVO serviceContent(int idx);

	public int serviceReply(List<MultipartFile> fileList, ServiceVO vo);

	public int deleteService(int idx, HttpSession session);
	
}
