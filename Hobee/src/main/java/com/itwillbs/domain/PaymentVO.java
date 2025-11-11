package com.itwillbs.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
public class PaymentVO {
    private int payment_id;
    private int user_num;
    private int lecture_num;
    private String imp_uid;
    private String merchant_uid;
    private int amount;         // 최종 결제금액 (포인트 할인 반영 후)
    private int used_points;    // 사용한 포인트
    private int saved_points;   // 적립된 포인트
    private String status;
    private String created_at;
}