package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class AlarmVO {
	private int idx;
	private int memberIdx;
	private int memberIdxWho;
	private String alarmType;
	private String alarmTypeIdx;
	private String alarmDate;
	private String readCheck;
	
	private String nickName;	// 알람 발생자의 닉네임
	private String timeDiff;
}
