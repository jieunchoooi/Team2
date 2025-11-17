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

    /** 특정 회원의 결제 목록 조회 */
    List<PaymentVO> getPaymentList(int user_num);

    /** 특정 결제 상세 조회 */
    PaymentVO getPayment(int payment_id);

    /** 결제 상태 → cancelled 변경 */
    void updateStatusCancelled(int payment_id);

    /** 환불 처리 후 포인트 복구 (사용 포인트 다시 지급) */
    void restoreUsedPoints(int payment_id);

    /** 환불 처리 후 적립 포인트 회수 */
    void removeSavedPoints(int payment_id);

    /** 해당 결제로 등록된 강의 제목들 가져오기 (GROUP_CONCAT) */
    String getLectureTitlesByPayment(int payment_id);
    /** 🔹 결제 단건 조회 (created_at, user_num 확인용) */
    public PaymentVO getPaymentById(int payment_id);

    /** 🔹 결제 상태 → 'cancelled' (환불 처리) */
    public int updatePaymentStatusRefund(int payment_id);
    
    //테스트용
    void insertPaymentForTest();
}
