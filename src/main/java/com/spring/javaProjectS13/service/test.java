package com.spring.javaProjectS13.service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class test {
	public static void main(String[] args) {
		BCryptPasswordEncoder en = new BCryptPasswordEncoder();
		System.out.println(en.encode("1234"));
	}
}
