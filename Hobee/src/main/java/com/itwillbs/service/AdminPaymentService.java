package com.itwillbs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminPaymentCriteria;
import com.itwillbs.domain.AdminPaymentDetailDTO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.mapper.AdminPaymentMapper;

@Service
public class AdminPaymentService {

    private final AdminPaymentMapper adminPaymentMapper;

    public AdminPaymentService(AdminPaymentMapper adminPaymentMapper) {
        this.adminPaymentMapper = adminPaymentMapper;
    }

    // ==========================================
    // 🔵 결제건별 리스트 조회
    // ==========================================
    public List<AdminPaymentDetailDTO> getPaymentList(
            AdminPaymentCriteria adminPaymentCriteria,
            PageVO pageVO) {
    	
    	System.out.println("getPaymentList() : "+adminPaymentMapper.selectPaymentList(adminPaymentCriteria, pageVO));
    	System.out.println("페이먼트 리스트 배열 사이즈"+adminPaymentMapper.selectPaymentList(adminPaymentCriteria, pageVO).size());
        return adminPaymentMapper.selectPaymentList(adminPaymentCriteria, pageVO);
    }
    
    public int getPaymentCount(AdminPaymentCriteria adminPaymentCriteria) {
    	System.out.println("getPaymentCount() : "+adminPaymentMapper.selectPaymentCount(adminPaymentCriteria));
        return adminPaymentMapper.selectPaymentCount(adminPaymentCriteria);
    }

    // ==========================================
    // 🔵 강의별 리스트 조회
    // ==========================================
    public List<AdminPaymentDetailDTO> getLecturePaymentList(
            AdminPaymentCriteria adminPaymentCriteria,
            PageVO pageVO) {

        return adminPaymentMapper.selectLecturePaymentList(adminPaymentCriteria, pageVO);
    }

    public int getLecturePaymentCount(AdminPaymentCriteria adminPaymentCriteria) {
        return adminPaymentMapper.selectLecturePaymentCount(adminPaymentCriteria);
    }
    
    

    /** 총 매출 금액 (payment_detail 기반) */
    public int getTotalRevenue() {
        return adminPaymentMapper.getTotalRevenue();
    }

    /** 총 환불 금액 (payment_detail 기반) */
    public int getTotalRefund() {
        return adminPaymentMapper.getTotalRefund();
    }

    /** 판매된 강의 개수 */
    public int getTotalLectureSold() {
        return adminPaymentMapper.getTotalLectureSold();
    }

    /** 환불된 강의 개수 */
    public int getTotalLectureRefunded() {
        return adminPaymentMapper.getTotalLectureRefunded();
    }
}
