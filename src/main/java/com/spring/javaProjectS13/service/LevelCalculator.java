package com.spring.javaProjectS13.service;

import org.springframework.stereotype.Service;

@Service
public class LevelCalculator {
	private int maxExp;

	public int calcMaxExp(int level) {
		if(level==1) maxExp = 500;
		else if(level==2) maxExp = 1000;
		else if(level==3) maxExp = 2000;
		else if(level==4) maxExp = 5000;
		else if(level==5) maxExp = 10000;
		else maxExp = 0;
		
		return maxExp;
	}

}
