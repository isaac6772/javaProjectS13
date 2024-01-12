package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private int memberIdx;
	private String nickName;
	private String title;
	private String content;
	private String contentText;
	private String part;
	private int viewNum;
	private int good;
	private int bad;
	private String writeDate;
}
