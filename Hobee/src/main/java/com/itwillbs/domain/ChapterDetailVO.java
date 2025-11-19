package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChapterDetailVO {
	
    private int detail_num;      // 고유넘버  --- 자동으로 올라가야함
    private int chapter_num;     // chapter 테이블 fk  --- chaoterVO 고유넘버
    private int detail_order;    // 순서   
    private String detail_title; // 제목
    private String detail_time;  // 강의시간

}
