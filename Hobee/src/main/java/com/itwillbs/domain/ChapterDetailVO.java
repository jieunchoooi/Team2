package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChapterDetailVO {
	
    private int detail_Num;
    private int chapter_Num;
    private int detail_order;
    private String detail_title;
    private String detail_time;
    private String detail_url;

}
