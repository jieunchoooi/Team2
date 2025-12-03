package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureVO {
	
	private int user_num;
	private int lecture_num;
    private String lecture_title;
    private String lecture_author;    //강사명 
    private int lecture_price;
    private String category_detail;
    private String lecture_img;
    private String lecture_detail;
    private String lecture_tag;
    private String created_at; // 강의 생성 날짜
    private String status; // 승인, 반려, 승인대기 여부
    
    
    //북마크
    private boolean bookmark;
    
    // 추가 필드 (통계 정보)
 	private double avg_score;         // 평균 별점
 	private int review_count;         // 리뷰 개수
 	private int student_count;        // 수강생 수
 	private String total_time;        // 총 강의 시간 (HH:mm 형식)
    
}

