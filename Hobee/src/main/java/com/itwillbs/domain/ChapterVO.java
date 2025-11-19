package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChapterVO {
	
	  private int chapter_num;      // 고유넘버
	  private int lecture_num;      // lecture 테이블 fk
	  private int chapter_order;    // 순서
	  private String chapter_title; // 제목
	

}
