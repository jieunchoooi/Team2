package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.GradeVO;

@Mapper
public interface GradeMapper {

    // 누적 결제금액으로 등급 조회
    GradeVO getGradeByTotalPayment(int totalPayment);

    // (선택) 모든 등급 조회
    List<GradeVO> getAllGrades();
}
