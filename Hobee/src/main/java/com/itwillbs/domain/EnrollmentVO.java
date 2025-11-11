package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EnrollmentVO {
    
    private int enrollment_id;   // PK (auto_increment)
    private int user_num;        // FK → users.user_num
    private int lecture_num;     // FK → lecture.lecture_num
    private int payment_id;      // FK → payment.payment_id (✅ 추가됨)
    
    private String created_at;   // 등록일시
}
