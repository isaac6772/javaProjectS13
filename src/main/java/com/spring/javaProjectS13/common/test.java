package com.spring.javaProjectS13.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class test {
	public static void main(String[] args) {
		String str = "Wed, 17 Jan 2024 15:12:00 +0900";
		SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z",Locale.ENGLISH);
		Date date = null;
		try {
			date = sdf.parse(str);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		long res = new Date().getTime() - date.getTime();
		System.out.println(res/1000);
	}
}
