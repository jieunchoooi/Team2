package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.PaymentVO;

@Mapper
public interface PaymentMapper {

    // 결제 등록
    int insertPayment(PaymentVO paymentVO);

    // imp_uid 중복 체크 (선택적)
    int checkImpUidExists(String imp_uid);
}
