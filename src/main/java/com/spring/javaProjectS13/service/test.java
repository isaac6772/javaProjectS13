package com.spring.javaProjectS13.service;

public class test {
	public static void main(String[] args) {
		String str = "<h1><strong>글자연습<img alt=\"\" src=\"/javaProjectS/data/board/231219163246_1.jpg\" style=\"height:573px; width:800px\" /></strong></h1><h1><strong>연습입니다.</strong></h1>";
		String reg = "<[^>]+>";
		System.out.println(str.replaceAll(reg, ""));
	}
}
