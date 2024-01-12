package com.spring.javaProjectS13.vo;

import lombok.Data;

@Data
public class PageVO {
	
	private int pag = 1;
	private int pageSize = 10;
	private int level = -1;
	private String fromDate = "";
	private String toDate = "";
	private String searchType = "mid";
	private String searchString = "";
	private String part = "전체";
	private String scope = "전체글";
	
	private int startIndexNo;
	private int totPage;
	private int totRecCnt;
	private int curBlock;
	private int blockSize = 10;
	private int scrStartNo;
}
