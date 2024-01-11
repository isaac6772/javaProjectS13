package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class ServiceVO {
	private int idx;
	private int refIdx;
	private int memberIdx;
	private String nickName;
	private String title;
	private String part;
	private String content;
	private String fileName;
	private String writeDate;
	private String open;
	
	// 응답여부를 체크하는 필드
	private int reply;
	// 날짜 차이를 계산하는 필드
	private int dateDiff;
	// 이미지 파일을 각각 관리하기 위한 필드
	private String[] images;
}
