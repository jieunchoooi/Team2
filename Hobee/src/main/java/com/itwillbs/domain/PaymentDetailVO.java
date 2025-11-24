package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;



/**
 * PaymentDetailVO
 * -------------------------------------
 * 결제 1건(payment_id)에 포함된 개별 강의 결제 상세 정보를 나타내는 VO 클래스
 * - payment_detail 테이블과 1:1 매핑
 * - 강의별 가격, 할인 후 금액, 포인트 사용/적립 내역 저장
 * - 환불/부분 환불 처리를 위해 필수
 */








@Getter
@Setter
@ToString
public class PaymentDetailVO {

    // 상세 번호 (PK, AI)
    private int detail_id;

    // 결제 번호 (FK → payment.payment_id)
    private int payment_id;

    // 강의 번호 (FK → lecture.lecture_num)
    private int lecture_num;

    // 강의 원가
    private int original_price;

    // 할인 적용 후 실제 결제 금액
    private int sale_price;

    // 해당 강의에 배정된 사용 포인트
    private int used_points;

    // 해당 강의에서 적립된 포인트
    private int saved_points;

    // 결제 상태 (paid / cancelled / refunded 등)
    private String status;

    // 생성 시간
    private Timestamp created_at;

    // ================================
    // 🔹 JOIN용 필드 (조회 전용)
    //    lecture 테이블과 JOIN해서 조회할 때만 사용
    // ================================

    // 강의명 (lecture.lecture_title)
    private String lecture_title;

    // 강사명 (lecture.lecture_author)
    private String lecture_author;

    // 썸네일 이미지 파일명 (lecture.lecture_img)
    private String lecture_img;

    // 강의 가격 (lecture.lecture_price)
    private int lecture_price;
}
