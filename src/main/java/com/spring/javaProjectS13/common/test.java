package com.spring.javaProjectS13.common;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class test {
	public static void main(String[] args) {
		String date = "2024-01-10 11:01:00";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime parseDate = LocalDateTime.parse(date,formatter);
		LocalDateTime now = LocalDateTime.now();
		now = now.minusMinutes(60);
		
		if(parseDate.isBefore(now)) System.out.println("date는 이전날짜");
	}
}
