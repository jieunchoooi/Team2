package com.itwillbs.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminPaymentDetailDTO {
	private Integer rowKey;

	 // ────────────── 🔵 결제 기본 정보 (공통) ──────────────
    private PaymentVO payment;    // 결제 정보
    private UserVO user;          // 결제한 유저 정보

    // ────────────── 🔵 결제건별 보기 전용 필드 ──────────────
    private Integer lectureCount; // 해당 결제에 포함된 강의 수 (payment 탭용)

    // ────────────── 🔵 강의별 보기 전용 필드 ──────────────
    private PaymentDetailVO detail;   // 단일 결제 상세 행 (payment_detail)
    private LectureVO lecture;        // detail에 대응하는 강의 정보

    // ────────────── 🔵 상세 페이지 전용 (결제 상세 전체) ──────────────
    private List<PaymentDetailVO> detailList;   // 결제건 상세 리스트
    private List<LectureVO> lectureList;        // 상세에 대응하는 강의 정보 리스트
    
  

}
