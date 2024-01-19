package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class DiscussionVO {
	private int idx;
	private int memberIdx;
	private String subject;
	private String part;
	private String createdDate;
	private String discussionDate;
	private String participant;
	private String content;
	private String state;
}
