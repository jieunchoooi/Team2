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

    /** ============================
     *  🔹 point_history 기본 컬럼
     * ============================ */
    private int point_history_id;    // PK
    private int user_num;            // 회원 번호 (FK)
    private Integer payment_id;      // 결제 ID (nullable)
    private int point_change;        // 포인트 증감값 (+ / -)
    private String type;             // save / use / restore / remove
    private String description;      // 설명
    private Timestamp created_at;    // 생성일시

    /** ============================
     *  🔹 payment JOIN 필드
     * ============================ */
    private String merchant_uid;     // 주문번호
    private Integer payment_amount;  // 결제 금액
    private Timestamp payment_created_at; // 결제 생성일

    /** ============================
     *  🔹 payment_detail JOIN 필드 (강의 단위)
     * ============================ */
    private Integer detail_id;       // payment_detail PK
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
