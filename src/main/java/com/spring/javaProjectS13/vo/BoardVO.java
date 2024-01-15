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
	private String profile;	// 게시물 작성자의 프로필사진
	private int replyCnt;	// 해당 게시물의 댓글 수
	private int nextIdx;	// 다음 게시물의 idx
	private int prevIdx;	// 이전 게시물의 idx
}
