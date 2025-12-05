package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.PaymentDetailVO;

public interface PaymentDetailMapper {
    void insert(PaymentDetailVO paymentDetailVO);

    List<PaymentDetailVO> getDetailsByPaymentId(int paymentId);
    
    PaymentDetailVO getDetailById(int detailId);

    void updateDetailStatusRefund(int detailId);

    int countPaidDetails(int paymentId);
    
    // 🔥 부분 환불용 — 특정 payment_id + lecture_num 조합 디테일 1건 조회
    PaymentDetailVO getDetailByPaymentAndLecture(
            @Param("payment_id") int paymentId,
            @Param("lecture_num") int lectureNum);
    //부분환불용 디테일 카운팅
    int countTotalDetails(@Param("paymentId") int paymentId);

}
