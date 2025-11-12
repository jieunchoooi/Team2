package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.sql.Timestamp;

/**
 * PointHistoryVO (v2)
 * ------------------------------------
 * 📌 DB 테이블: point_history
 *  - 포인트 적립 및 사용 내역을 저장
 *  - 결제 내역과 연결(payment_id)
 *
 * ⚙️ 추가 필드 (조회용)
 *  - merchant_uid : 결제 테이블의 주문번호
 *  - payment_amount : 결제 금액
 *  → 실제 point_history 테이블에는 존재하지 않음!
 *  → JOIN 조회 시만 매핑됨 (NULL 가능)
 */

@Getter
@Setter
@ToString
public class PointHistoryVO {

    /** 🔹 기본 컬럼 (point_history 테이블) */
    private int point_id;             // PK
    private int user_num;             // 회원 번호 (FK)
    private Integer payment_id;       // 결제 ID (nullable)
    private int point_change;         // 포인트 증감값 (+/-)
    private String type;              // 포인트 타입 (SAVE / USE)
    private String description;       // 적립/사용 설명
    private Timestamp created_at;     // 생성일시

    /** 🔸 조회 전용 필드 (LEFT JOIN payment용) */
    private String merchant_uid;      // 주문번호 (payment.merchant_uid)
    private Integer payment_amount;   // 결제금액 (payment.amount)

    // ⚠️ 주의:
    // 위 두 필드는 DB point_history 테이블에는 존재하지 않음.
    // 단지 포인트 내역 + 결제내역을 함께 조회할 때만 사용됨.
}
