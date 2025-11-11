package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureVO {
	
	private int lecture_num;
    private String lecture_title;
    private int lecture_price;
    private String category_detail;
    private int readcount;
    private String img_url;

}
