package com.spring.javaProjectS13.service;

import java.util.List;

import com.spring.javaProjectS13.vo.News;

public interface NewsService {

	public List<News> keywordNews(String keyword, int length);

}
