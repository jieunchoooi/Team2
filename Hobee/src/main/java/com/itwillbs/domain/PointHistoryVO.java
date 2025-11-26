package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.sql.Timestamp;

/**
 * PointHistoryVO (Final)
 * ------------------------------------
 * 📌 DB 테이블: point_history
 *  - 포인트 적립 및 사용 내역 저장
 *  - 결제(payment) / 강의(payment_detail) / lecture와 JOIN 가능
 */

@Getter
@Setter
@ToString
public class PointHistoryVO {
	 /** 포인트 내역 고유번호 (PK, AUTO_INCREMENT) */
    private int history_id;

    /** 회원 번호 (FK → user.user_num) */
    private int user_num;

    /** 결제 상세 번호 (FK → payment_detail.detail_id) */
    private int detail_id;

    /** 포인트 변화량 (+적립 / -사용 / -회수 등) */
    private int point_change;

    /** 포인트 변화 타입 (SAVE / USE / REFUND_SAVE / REFUND_USE 등) */
    private String type;

    /** 포인트 변화 사유 설명 (예: "결제 적립", "부분 환불 포인트 회수") */
    private String description;

    /** 포인트 변화 발생 시각 */
    private Timestamp created_at;

    // ================================
    // 🔹 JOIN 전용 필드 (조회 전용)
    //    - UI에서 편하게 쓰려고 추가
    //    - DB 컬럼 X, XML에서만 매핑
    // ================================
    /** ============================
     *  🔹 payment JOIN 필드
     * ============================ */
    private String merchant_uid;     // 주문번호
    private Integer payment_amount;  // 결제 금액
    private Timestamp payment_created_at; // 결제 생성일

    /** ============================
     *  🔹 payment_detail JOIN 필드 (강의 단위)
     * ============================ */
    private Integer lecture_num;     // 강의 번호
    private Integer original_price;  // 원가
    private Integer sale_price;      // 할인 적용 금액
    private Integer used_points;     // 강의별 사용 포인트
    private Integer saved_points;    // 강의별 적립 포인트
    private String detail_status;    // paid / refunded 등

    /** ============================
     *  🔹 lecture JOIN 필드
     * ============================ */
    private String lecture_title;    // 강의명
    private String lecture_author;   // 강사명
    private String lecture_img;      // 이미지
    private Integer lecture_price;   // 강의 가격

}
