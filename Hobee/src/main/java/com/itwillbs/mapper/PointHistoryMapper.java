package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.PointHistoryVO;

@Mapper
public interface PointHistoryMapper {

    // 🔹 포인트 내역 등록 (적립/차감 모두)
    int insertPointHistory(PointHistoryVO pointHistoryVO);

    // 🔹 특정 회원의 포인트 내역 조회
    List<PointHistoryVO> getPointHistoryByUser(PointHistoryVO pointHistoryVO);

    // 🔹 특정 회원의 총 포인트 조회
    int getTotalPoints(PointHistoryVO pointHistoryVO);

    // 🔹 포인트 차감
    int deductPoints(PointHistoryVO pointHistoryVO);

    // 🔹 포인트 적립
    int addPoints(PointHistoryVO pointHistoryVO);
}
