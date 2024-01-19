package com.spring.javaProjectS13.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.Keyword;

public interface NewsDAO {

	public void keywordInput(@Param("keyword") String keyword);

	public ArrayList<Keyword> keywordList(@Param("time") int time, @Param("limit") int limit);

}
