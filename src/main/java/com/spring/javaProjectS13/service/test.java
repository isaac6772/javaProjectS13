package com.spring.javaProjectS13.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class test {
	public static void main(String[] args) {
		ArrayList<String> vos = new ArrayList<String>();
		vos.add("가");
		vos.add("나");
		vos.add("다");
		
		System.out.println("'다'라는 글자가 있나요? : " + vos.contains("다"));
	}
}
