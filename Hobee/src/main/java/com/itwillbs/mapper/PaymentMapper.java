package com.itwillbs.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.PaymentVO;

@Mapper
public interface PaymentMapper {

    // 결제 내역 저장
    void insertPayment(PaymentVO paymentVO);

    // imp_uid 중복 여부 확인
    int checkDuplicateImpUid(String impUid);

    // 회원 누적 결제 금액 조회 (등급 조정용)
    int getUserTotalPayment(int userNum);

    // 특정 회원의 결제 내역 조회 (마이페이지용)
    List<PaymentVO> getPaymentsByUser(int userNum);
}
