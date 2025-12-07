package com.itwillbs.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.mapper.EnrollmentMapper;
import com.itwillbs.domain.EnrollmentViewVO;

/**
 * ✅ EnrollmentService (단일 서비스 구조)
 * - EnrollmentMapper를 직접 주입받아 수강내역 관련 로직 처리
 * - 별도의 인터페이스/Impl 분리 없이 사용
 * - Controller에서 바로 호출 가능
 */
@Service
public class EnrollmentService {

    @Autowired
    private EnrollmentMapper enrollmentMapper;

    /**
     * ✅ 로그인된 회원의 수강 내역 조회
     * @param userNum 로그인한 회원 번호 (user_num)
     * @return List<EnrollmentVO> 수강 목록
     */
    /** ✅ 로그인한 회원의 수강 내역 조회 */
    public List<EnrollmentViewVO> getEnrollmentsByUser(int userNum) {
        return enrollmentMapper.getEnrollmentsByUser(userNum);
    }
    //강의 상세 페이지용 현재 회원이 강의 수강했는지 체크용
   

    public int countEnrollment(int userNum, int lectureNum) {
        return enrollmentMapper.countEnrollment(userNum, lectureNum);
    }
}