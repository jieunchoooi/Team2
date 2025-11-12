package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GradeVO {

    private int grade_id;             // PK
    private String grade_name;        // 등급명 (예: Bronze, Silver, Gold)
    private int min_payment;          // 최소 누적 결제금액
    private int max_payment;          // 최대 누적 결제금액
    private double discount_rate;     // 할인율 (%)
    private double reward_rate;       // 적립률 (%)
    private Timestamp created_at;     // 생성일시
    private Timestamp updated_at;     // 수정일시

    // ✅ 임시 기본 생성자 (등급 테이블 비어 있을 때 기본값 설정)
    public GradeVO() {
        this.grade_name = "기본등급";
        this.discount_rate = 5.0;
        this.reward_rate = 5.0;
    }
}
