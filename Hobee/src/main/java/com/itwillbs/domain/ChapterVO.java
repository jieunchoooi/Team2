package com.itwillbs.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChapterVO {
	
	  private int chapter_num;      // 고유넘버 
	  private int lecture_num;      // lecture 테이블 fk
	  private int chapter_order;    // 순서 --- 자동으로 숫자 올라가야함
	  private String chapter_title; // 제목
	  
	  private List<ChapterDetailVO> detailList;

}
