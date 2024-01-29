package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class ReportVO {
	private int idx;
	private String reportType;
	private int reportIdx;
	private int memberIdx;
	private String part;
	private String content;
	private String reportDate;
	private int reporter;
	private String checkField;
	
	private String nickName;		// 신고당한 회원 닉네임
	private String reporterNickName;		// 신고자 닉네임
}
