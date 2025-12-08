package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.PaymentVO;

@Mapper
public interface PaymentMapper {

    /** ----------------------------------------------
     * 🔹 결제 저장
     * ---------------------------------------------- */
    void insertPayment(PaymentVO paymentVO);

    /** ----------------------------------------------
     * 🔹 imp_uid 중복 결제 여부 확인
     * ---------------------------------------------- */
    int checkDuplicateImpUid(String impUid);

    /** ----------------------------------------------
     * 🔹 회원 누적 결제금액 조회 (등급 산정용)
     * ---------------------------------------------- */
    int getUserTotalPayment(int userNum);

    /** ----------------------------------------------
     * 🔹 특정 회원의 결제 목록 조회
     * ---------------------------------------------- */
    List<PaymentVO> getPaymentList(int userNum);

    /** ----------------------------------------------
     * 🔹 결제 상세 조회
     * ---------------------------------------------- */
    PaymentVO getPayment(int paymentId);

    /** ----------------------------------------------
     * 🔹 환불 처리 시 상태 → refunded 로 변경
     * ---------------------------------------------- */
    int updatePaymentStatusRefund(int paymentId);

    /** ----------------------------------------------
     * 🔹 단건 조회 (환불 처리용 created_at, user_num 포함)
     * ---------------------------------------------- */
    PaymentVO getPaymentById(int paymentId);

    /** ----------------------------------------------
     * 🔹 (선택) 결제 테스트용
     * ---------------------------------------------- */
    void insertPaymentForTest();
    //부분환불상태로 바꾸는 쿼리
    void updatePaymentStatusPartial(@Param("paymentId") int paymentId);

    // 강의 구매이력 세션에 저장
	List<Integer> getPurchasedLectures(int user_num);

  
}
