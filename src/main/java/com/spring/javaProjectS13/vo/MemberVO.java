package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String email;
	private String gender;
	private int level;
	private int visitCnt;
	private String keyword;
	private int point;
	private int exp;
	private String joinDate;
	private String lastDate;
	private String profile;
	private String userInfo;
	private String introduce;
	
	// 로그인 정보를 저장하는 추가된 vo필드
	private int login;
}
