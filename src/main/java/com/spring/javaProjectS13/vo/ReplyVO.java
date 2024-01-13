package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int idx;
	private int memberIdx;
	private String nickName;
	private String boardType;
	private int boardIdx;
	private String content;
	private String writeDate;
	private int replyIdx;
	
	private String profile;		// 댓글 단 사람의 프로필
}
