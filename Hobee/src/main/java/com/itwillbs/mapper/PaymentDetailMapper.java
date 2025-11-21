package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.PaymentDetailVO;

public interface PaymentDetailMapper {
    void insert(PaymentDetailVO paymentDetailVO);

    List<PaymentDetailVO> getDetailsByPaymentId(int paymentId);
}
