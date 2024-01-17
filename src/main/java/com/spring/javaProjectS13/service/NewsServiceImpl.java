package com.spring.javaProjectS13.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.dao.NewsDAO;
import com.spring.javaProjectS13.vo.News;
import com.spring.javaProjectS13.vo.NewsResponse;

@Service
public class NewsServiceImpl implements NewsService {
	
	@Autowired
	NewsDAO newsDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	RestTemplate restTemplate;
	@Autowired
	ObjectMapper objectMapper;

	@Override
	public List<News> keywordNews(String keyword) {
		int start = 1;
		String clientId = "7erLyg8itVAhwffeUQXr";
	    String clientSecret = "dg3CN4LESE";

	    String apiURL = "https://openapi.naver.com/v1/search/news.json?query="+keyword+"&display=13";

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("X-Naver-Client-Id", clientId);
	    headers.add("X-Naver-Client-Secret", clientSecret);

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    ResponseEntity<String> response = restTemplate.exchange(apiURL + "&start="+start, HttpMethod.GET, entity, String.class);
		
	    NewsResponse newsResponse = null;
	    
	    // 네이버 뉴스만 10개 뽑기
	    
    	ArrayList<News> newsList = new ArrayList<News>();
	    int cnt = 0;
	    
	    try {
	    	newsResponse = objectMapper.readValue(response.getBody(), NewsResponse.class);
			while(true) {
				for(News news : newsResponse.getItems()) {
					if(news.getLink().contains("//n.news.naver.com/")) {
						cnt++;
						newsList.add(news);
						if(cnt>=13) break;
					}
				}
				if(cnt<13) {
					start += 13;
					response = restTemplate.exchange(apiURL + "&start="+start, HttpMethod.GET, entity, String.class);
					newsResponse = objectMapper.readValue(response.getBody(), NewsResponse.class);
				}
				else break;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		    
		// 뽑은 뉴스의 링크를 기반으로 크롤링해서 newsVO에 넣어주기
		try {
			for(News news : newsList) {
				Document document = Jsoup.connect(news.getLink()).get();
				//String content = document.select("article").first().text();
				String fileName = "";
				
				Elements images = document.select("article img");
				if(images.size() != 0) {
					for(Element image : images) {
						fileName += image.attr("data-src") + ",";
					}
					fileName = fileName.substring(0,fileName.length()-1);
				}
				//news.setContent(content);
				news.setFileName(fileName);
				news.setTitle(news.getTitle().replaceAll("<[^>]+>", ""));
				
				// 날짜 차이 계산하기
				SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z",Locale.ENGLISH);
				Date date = sdf.parse(news.getPubDate());
				long diff = (new Date().getTime() - date.getTime())/1000;
				String timeDiff;
				if((diff/60)<1) timeDiff = diff%60 + "초";
				else if(diff/(60*60)<1) timeDiff = (diff/60) + "분";
				else if(diff/(60*60*24)<1) timeDiff = (diff/60*60) + "시간";
				else timeDiff = (diff/(60*60*24)) + "일";
				news.setTimeDiff(timeDiff);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return newsList;
	}
	
}
