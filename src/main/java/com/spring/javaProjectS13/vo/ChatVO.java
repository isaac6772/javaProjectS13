package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class ChatVO {
	private int idx;
	private int memberIdx;
	private int receiver;
	private String chatType;
	private int discussionIdx;
	private String message;
	private String msgDate;
	
	private String profile;		// chatting한 사람들의 프로필
	private String nickName;
}
