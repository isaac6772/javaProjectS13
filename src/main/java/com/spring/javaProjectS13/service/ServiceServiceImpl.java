package com.spring.javaProjectS13.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ServiceServiceImpl implements ServiceService {

	@Override
	public void serviceInput(MultipartFile file) {
		int res = 0;
		
		// 먼저 service 테이블 만들고 vo 만들고 작업하자..
	}

}
