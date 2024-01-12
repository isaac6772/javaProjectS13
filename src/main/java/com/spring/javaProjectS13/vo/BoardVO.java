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
	
	private int imgCheck;
	private int dateDiff;
	private int level;	// 게시물 작성자의 레벨
}
