package com.itwillbs.domain;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * PaymentVO
 * -----------------------------
 * 결제 1건(포트원 imp_uid 기준)을 표현하는 VO 클래스
 * - 한 번의 결제에 여러 강의(enrollment)가 연결될 수 있음 (1:N)
 * - imp_uid는 PortOne(아임포트) 결제 고유 식별자 (전역 유일)
 * - merchant_uid는 상점 내부 결제 식별자 (가맹점 생성)
 */
@Getter
@Setter
@ToString
public class PaymentVO {

    /** 결제 PK (Auto Increment) */
    private int payment_id;

    /** 결제한 회원 번호 (FK → user.user_num) */
    private int user_num;

    /** 최종 결제 금액 (할인 및 포인트 적용 후 실제 결제 금액) */
    private int amount;

    /** 결제 시 사용된 포인트 (0이면 미사용) */
    private int used_points;

    /** 결제 후 적립된 포인트 (할인 전 기준으로 계산됨) */
    private int saved_points;

    /** 결제 상태 (예: "paid", "cancelled", "refunded") */
    private String status;

    /** 포트원 결제 고유번호 (예: imp_123456789) — UNIQUE 제약 */
    private String imp_uid;

    /** 상점 고유 결제번호 (예: M202511121230) — timestamp 기반 유니크 */
    private String merchant_uid;

    /** 결제 생성 일시 (MySQL NOW() 기반 자동 입력) */
    private Timestamp created_at;

    /** [조회 전용] 여러 강의 제목 표시용 (ex. "수채화 기초, 캘리그래피 입문") */
    private String lectureTitles;

    /** [조회 전용] 회원 이름, 이메일 표시용 (JOIN 시 활용) */
    private String user_name;
    private String user_email;
}
