package com.itwillbs.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.PointHistoryVO;

@Mapper
public interface PointHistoryMapper {

    /** 🔹 포인트 내역 기록 (적립/사용 기록용) */
    int insertPointHistory(PointHistoryVO pointVO);

    /** 🔹 포인트 차감 (포인트 사용 시) */
    int deductPoints(PointHistoryVO pointVO);

    /** 🔹 포인트 적립 (결제 완료 시) */
    int addPoints(PointHistoryVO pointVO);

    /** 🔹 특정 회원의 전체 포인트 내역 조회 */
    List<PointHistoryVO> getPointHistoryByUser(int user_num);

    /** 🔹 특정 회원의 포인트 총합 조회 (현재 포인트 확인용) */
    Integer getUserTotalPoints(int user_num);

    /** 🔹 특정 결제에 대한 포인트 내역 조회 */
    List<PointHistoryVO> getPointHistoryByPayment(int payment_id);
    
    void insertPointHistoryForTest();
    
    

    
}
