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
	
	private int login;	// 로그인 정보를 저장하는 추가된 vo필드
	private int Participant;	// 토론채팅창에서 참가자인지 관전자인지를 판별하는 필드
	private int alarmCnt;		// 이 회원에게서 온 읽지 않은 채팅 메시지의 개수
}
