package com.spring.javaProjectS13.service;

public class test {
	public static void main(String[] args) {
		String str = "<p><img src=\"/javaProjectS13/data/ckeditor/6c428cb4-42d_coffee.jpg\" style=\"height:3000px; width:2400px\" /></p>";
		System.out.println(str.replace("src=\"/javaProjectS13/data/ckeditor/", "src=\"/javaProjectS13/board/"));
	}
}
