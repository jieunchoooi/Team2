package com.itwillbs.domain;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * ✅ EnrollmentViewVO (조회 전용)
 * - enrollment + lecture JOIN 결과용
 * - 실제 DB 컬럼 기반으로 오류 없이 동작
 */
@Getter
@Setter
@ToString
public class EnrollmentViewVO {
    
    /** enrollment 테이블 */
    private int enrollment_id;
    private int user_num;
    private int lecture_num;
    private int payment_id;
    private Timestamp enrolled_at;

    /** lecture 테이블 */
    private String lecture_title;
    private String lecture_author;
    private int lecture_price;
    private String category_detail;
    private String lecture_img;
}
