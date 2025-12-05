package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.AdminPaymentCriteria;
import com.itwillbs.domain.AdminPaymentDetailDTO;
import com.itwillbs.domain.PageVO;

@Mapper
public interface AdminPaymentMapper {

    // ================================
    // 🔵 결제건별 조회
    // ================================
    public List<AdminPaymentDetailDTO> selectPaymentList(
            @Param("criteria") AdminPaymentCriteria criteria,
            @Param("pageVO") PageVO pageVO);

    public int selectPaymentCount(@Param("criteria") AdminPaymentCriteria criteria);


    // ================================
    // 🔵 강의별 조회
    // ================================
    public List<AdminPaymentDetailDTO> selectLecturePaymentList(
            @Param("criteria") AdminPaymentCriteria criteria,
            @Param("pageVO") PageVO pageVO);

    public int selectLecturePaymentCount(@Param("criteria") AdminPaymentCriteria criteria);
    
    
    /** 총 매출 (original_price SUM) */
    int getTotalRevenue();

    /** 총 환불 금액 (original_price SUM refunded) */
    int getTotalRefund();

    /** 판매된 강의 수 */
    int getTotalLectureSold();

    /** 환불된 강의 수 */
    int getTotalLectureRefunded();
}
