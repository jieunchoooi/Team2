package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminReportVO;

@Mapper
public interface AdminReportMapper {
	
	/* 신고된 모든 목록을 조회하는 메서드 : 게시글 신고 + 댓글 신고 모두 포함 */
	List<AdminReportVO> getReportList();

	/* 특정 신고 상세 정보를 조회하는 메서드 : 게시글 신고인지? 댓글 신고인지? 구분 가능
      @param report_id : 조회할 신고 번호
      @return ReportVO : 신고 상세정보 */
    AdminReportVO getReportDetail(int report_id);

    /* 신고 처리 완료 업데이트
      @param report_id : 처리할 신고 번호 */
    void updateReportDone(int report_id);

}
