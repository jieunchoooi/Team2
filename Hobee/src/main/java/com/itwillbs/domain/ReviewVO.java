package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewVO {
	
	private int review_num; //고유넘버
	private int lecture_num; // lecture 테이블 fk
	private String user_id; // user 테이블 fk
	private double review_score; // 수강평 점수 (별 0~5개)
	private String review_content; // 수강평
	
	//조회용 추가필드
	private String user_name;
	private int review_count; // 개인이 갖고있는 수강평갯수
	private double avg_score; // 개인의 수강평 평균점수

}
