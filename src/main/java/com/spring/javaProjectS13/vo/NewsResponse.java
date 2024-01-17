package com.spring.javaProjectS13.vo;

import java.util.List;

import lombok.Data;

@Data
public class NewsResponse {
	private String lastBuildDate;
	private int total;
	private int start;
	private int display;
	private List<News> items;
}
