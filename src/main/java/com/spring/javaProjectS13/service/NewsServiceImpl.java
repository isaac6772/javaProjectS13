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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.dao.NewsDAO;
import com.spring.javaProjectS13.vo.Keyword;
import com.spring.javaProjectS13.vo.KeywordVO;
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
	public List<News> keywordNews(String keyword, int offset, int length, boolean flag) {
		int start = offset;
		
		String clientId = "7erLyg8itVAhwffeUQXr";
	    String clientSecret = "dg3CN4LESE";

	    String apiURL = "https://openapi.naver.com/v1/search/news.json?query="+keyword+"&display=100";

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("X-Naver-Client-Id", clientId);
	    headers.add("X-Naver-Client-Secret", clientSecret);

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    
	    ResponseEntity<String> response = restTemplate.exchange(apiURL + "&start="+start, HttpMethod.GET, entity, String.class);
		
	    NewsResponse newsResponse = null;
	    
    	ArrayList<News> newsList = new ArrayList<News>();
	    int cnt = 0;	// 뷰에 쀼려줄 실 데이터의 수
	    int repeatNum = 0;		// api의 응답으로 받아온 데이터의 수
	    
	    try {
	    	newsResponse = objectMapper.readValue(response.getBody(), NewsResponse.class);
			while(true) {
				for(News news : newsResponse.getItems()) {
					repeatNum++;
					if(news.getLink().contains("//n.news.naver.com/")) {
						cnt++;
						newsList.add(news);
						if(cnt>=length) break;
					}
				}
				if(cnt<length) {
					start += 100;
					if(start>=1000) break;		// 무한정 검색하지 않도록 처리했음
					response = restTemplate.exchange(apiURL + "&start="+start, HttpMethod.GET, entity, String.class);
					newsResponse = objectMapper.readValue(response.getBody(), NewsResponse.class);
				}
				else break;
			}
			
			// 뽑은 뉴스의 링크를 기반으로 크롤링해서 newsVO에 넣어주기
			for(News news : newsList) {
				Document document = Jsoup.connect(news.getLink()).get();
				
				if(document.select("article").first() != null) {
					String article = document.select("article").html();
					String fileName = "";
					
					Elements images = document.select("article img");
					if(images.size() != 0) {
						fileName = images.first().attr("data-src");
					}
					article = article.replace("data-src=\"", "src=\"");
					news.setArticle(article);
					news.setFileName(fileName);
					news.setTitle(news.getTitle().replaceAll("<[^>]+>", ""));
				}
				else {
					String article = document.select("#articeBody").first().html();
					String fileName = "";
					
					Elements images = document.select("#articeBody img");
					if(images.size() != 0) {
						fileName = images.first().attr("src");
					}
					news.setArticle(article);
					news.setFileName(fileName);
					news.setTitle(news.getTitle().replaceAll("<[^>]+>", ""));
				}
				
				
				
				// 날짜 차이 계산하기
				SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z",Locale.ENGLISH);
				Date date = sdf.parse(news.getPubDate());
				long diff = (new Date().getTime() - date.getTime())/1000;
				String timeDiff;
				if((diff/60)<1) timeDiff = diff%60 + "초";
				else if(diff/(60*60)<1) timeDiff = (diff/60) + "분";
				else if(diff/(60*60*24)<1) timeDiff = (diff/(60*60)) + "시간";
				else timeDiff = (diff/(60*60*24)) + "일";
				news.setTimeDiff(timeDiff);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
	    // 키워드 테이블 업데이트(검색바에서 검색을 했을 경우에만)
	    if(flag) newsDAO.keywordInput(keyword);
	    
	    // news 임시 객체를 생성해서 api 검색의 결과가 아무것도 없을시(repeatNum==0),
	    // 다음 startLocation=0 으로 설정해서 프론트쪽에서 stratLocation을 0으로 반환받았을시 더이상 검색결과가 없다는 창을 띄우도록 처리
	    News temp = new News();
	    if(repeatNum==0) temp.setTitle("0");
	    else temp.setTitle(repeatNum + offset + ""); 
	    newsList.add(temp);
		return newsList;
	}

	@Override
	public String keywordList(int time, int limit) {
		ArrayList<Keyword> keywords = newsDAO.keywordList(time, limit);
		String wordCloud = "";
		
		try {
			wordCloud = objectMapper.writeValueAsString(keywords);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return wordCloud;
	}

	@Override
	public ArrayList<Keyword> keywordListString(int time, int limit) {
		ArrayList<Keyword> keywords = newsDAO.keywordList(20, limit);
		return keywords;
	}
	
}
