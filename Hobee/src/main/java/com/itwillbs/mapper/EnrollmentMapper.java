package com.itwillbs.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.EnrollmentViewVO;

/**
 * EnrollmentMapper (v2)
 * -----------------------------
 * - 결제 기반 수강 등록
 * - 중복 등록 방지
 * - 회원 / 강의 / 결제 기준 조회
 */
@Mapper
public interface EnrollmentMapper {

    /** 수강 등록 */
    int insertEnrollment(EnrollmentVO enrollVO);

    /** ✅ 회원의 수강 내역 조회 */
    List<EnrollmentViewVO> getEnrollmentsByUser(@Param("user_num") int user_num);

    /** 강의별 수강자 목록 (관리자용) */
    List<EnrollmentVO> getEnrollmentsByLecture(@Param("lecture_num") int lecture_num);

    /** 결제별 수강 목록 (결제 상세용) */
    List<EnrollmentVO> getEnrollmentsByPayment(@Param("payment_id") int payment_id);

    /** 중복 등록 방지 */
    int checkEnrollmentExists(EnrollmentVO enrollVO);
    
    /** 
     * 환불 시 수강 상태를 cancelled 로 변경
     * - payment_id 기준으로 전체 강의 취소
     */
    int cancelEnrollmentByPaymentId(int payment_id);
    
    
}
