package com.itwillbs.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.PointHistoryVO;

@Mapper
public interface PointHistoryMapper {

    /** 🔹 포인트 내역 기록 (적립/사용 기록용) */
    int insertPointHistory(PointHistoryVO pointVO);
    // pointVO.detail_id 가 필수로 들어가야 함 (payment_id X)

    /** 🔹 포인트 차감 (포인트 사용 시) */
    int deductPoints(PointHistoryVO pointVO);

    /** 🔹 포인트 적립 (결제 완료 시) */
    int addPoints(PointHistoryVO pointVO);

    /** 🔹 특정 회원의 전체 포인트 내역 조회 */
    List<PointHistoryVO> getPointHistoryByUser(@Param("user_num") int userNum);

    /** 🔹 특정 회원의 포인트 총합 조회 (현재 포인트 확인용) */
    Integer getUserTotalPoints(int user_num);

    /**
     * 🔹 특정 결제에 대한 포인트 내역 조회
     *    → 내부적으로 payment_id로 조회하되,
     *      실제 point_history는 detail_id로 연결됨
     *    → XML에서 payment_detail JOIN 해서 payment_id 기준으로 조회함
     */
    List<PointHistoryVO> getPointHistoryByPayment(int payment_id);

    /** 🔹 테스트용 */
    void insertPointHistoryForTest();

}
