package com.itwillbs.domain;

import java.util.List;

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
    private List<CategoryVO> subCategories; // 세부 카테고리 리스트
	
}
