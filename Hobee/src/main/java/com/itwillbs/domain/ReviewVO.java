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
	private double review_score; // 리뷰 점수 (별 0~5개)
	private String review_content; // 리뷰내용
	
	//조회용 추가필드
	private String user_name;
	private int review_count; // 개인이 갖고있는 리뷰갯수
	private double avg_score; // 개인의 리뷰 평균점수
	private String lecture_title; // 강의 이름

}
