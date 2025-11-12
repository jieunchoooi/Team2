package com.itwillbs.domain;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * EnrollmentVO
 * -----------------------------
 * 회원의 수강등록 정보를 나타내는 VO 클래스
 * - 결제 1건(payment_id)에 여러 개의 수강등록(enrollment)이 연결될 수 있음 (1:N)
 * - 강의 정보(lecture), 결제 정보(payment), 회원 정보(user)를 함께 JOIN해서 사용 가능
 */
@Getter
@Setter
@ToString
public class EnrollmentVO {
    private int enrollment_id;
    private int user_num;
    private int lecture_num;
    private int payment_id;
    private Timestamp enrolled_at;
}
