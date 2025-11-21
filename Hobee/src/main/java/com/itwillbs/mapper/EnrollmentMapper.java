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
     
     * - payment_id 기준으로 전체 수강기록 삭제
     */
    int deleteEnrollmentByPaymentId(int paymentId);
    

    void deleteEnrollmentByUserAndLecture(EnrollmentVO enrollmentVO);
    
    

    // 🔥 부분 환불용: 특정 payment_id + lecture_num 1개 삭제
    void deleteByPaymentAndLecture(
            @Param("payment_id") int paymentId,
            @Param("lecture_num") int lectureNum);
    
    
}
