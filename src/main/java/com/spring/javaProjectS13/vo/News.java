package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class News {
	// api에서 받을 기본 데이터
	private String title;
	private String originallink;
	private String link;
	private String description;
	private String pubDate;
	
	// 추가로 크롤링을 통해 저장할 필드
	private String fileName;
	private String content;
	private String timeDiff;
}
