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

    /** 수강 등록 고유번호 (Auto Increment PK) */
    private int enrollment_id;

    /** 회원 번호 (FK → user.user_num) */
    private int user_num;

    /** 강의 번호 (FK → lecture.lecture_num) */
    private int lecture_num;

    /** 결제 번호 (FK → payment.payment_id) — 어떤 결제건으로 등록되었는지 추적용 */
    private int payment_id;

    /** 수강 등록 일시 (MySQL NOW() 자동 입력) */
    private Timestamp enrolled_at;

    /** [조회 전용] 강의명 (lecture 테이블 JOIN 시 표시용) */
    private String lecture_title;

    /** [조회 전용] 강의 카테고리 (예: "예체능", "IT", "언어") */
    private String category;

    /** [조회 전용] 결제 상태 (payment.status JOIN 시 표시용) */
    private String payment_status;

    /** [조회 전용] 강의 썸네일 이미지 경로 (lecture.thumbnail JOIN 시 표시용) */
    private String lecture_thumbnail;

    /** [조회 전용] 강사명 (lecture.teacher_name JOIN 시 표시용) */
    private String teacher_name;
}
