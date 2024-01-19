package com.spring.javaProjectS13.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaProjectS13.vo.Keyword;
import com.spring.javaProjectS13.vo.News;

public interface NewsService {

	public List<News> keywordNews(String keyword, int offset, int length, boolean flag);

	public String keywordList(int time, int limit);

	public ArrayList<Keyword> keywordListString(int time, int limit);

}
