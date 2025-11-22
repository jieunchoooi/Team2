package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PageVO {
	private int pageSize;
	private String pageNum;
	private int currentPage;
	
	private int startRow;
	private int endRow;
	// ---------------------
	private int count;
	private int pageBlock;
	private int startPage;
	private int endPage;
	private int pageCount;
	private String search;
	private String searchList;
}
