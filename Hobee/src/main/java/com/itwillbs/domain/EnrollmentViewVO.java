package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EnrollmentViewVO {

    // enrollment 테이블
    private int enrollment_id;
    private int user_num;
    private int lecture_num;
    private int payment_id;
    private String enrolled_at;

    // lecture 테이블 JOIN
    private String lecture_title;
    private String lecture_author;
    private int lecture_price;
    private String category_detail;
    private String lecture_img;
    private String lecture_detail;   // ⭐ 추가된 필드 (간략 설명)

    // 리뷰 여부 (미구현 → 기본 false)
    private boolean review_written = false;
}
