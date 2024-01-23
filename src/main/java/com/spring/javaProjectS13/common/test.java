package com.spring.javaProjectS13.common;

public class test {
	public static void main(String[] args) {
		String query = "idx=7&memberIdx=21";
    	int discussionIdx = Integer.parseInt(query.substring(query.indexOf("=") + 1,query.indexOf("&")));	// discussion테이블의 idx이자 방을 구분하는 key값
    	int memberIdx = Integer.parseInt(query.substring(query.lastIndexOf("=") + 1));
	}
}
