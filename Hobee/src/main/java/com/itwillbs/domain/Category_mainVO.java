package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Category_mainVO {

	private int category_main_num;
	private String category_main_name;
    private int category_main_order;  // 순서 필드
	
}
