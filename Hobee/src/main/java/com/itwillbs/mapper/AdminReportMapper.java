package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.ReportActionLogVO;
import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminReportVO;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminReportMapper {
	
	/* 신고된 모든 목록을 조회하는 메서드 : 게시글 신고 + 댓글 신고 모두 포함 */
    List<AdminReportVO> getReportList(
            @Param("type") String type,
            @Param("status") String status,
            @Param("offset") int offset,
            @Param("pageSize") int pageSize
    );

    int getReportCount(@Param("type") String type,
                       @Param("status") String status);



    /* 특정 신고 상세 정보를 조회하는 메서드 : 게시글 신고인지? 댓글 신고인지? 구분 가능
      @param report_id : 조회할 신고 번호
      @return ReportVO : 신고 상세정보 */
    AdminReportVO getReportDetail(int report_id);

    /* 신고 처리 완료 업데이트
      @param report_id : 처리할 신고 번호 */
    void updateReportDone(@Param("report_id") int report_id,
                          @Param("done_reason") String done_reason);


    int getTotalCount();         // 전체 신고 수
    int getMonthCount();         // 이번달 신고 수
    int getPostCount();          // 게시글 신고 수
    int getCommentCount();       // 댓글 신고 수

    void insertReportActionLog(
            @Param("report_id") int report_id,
            @Param("admin_id") String admin_id,
            @Param("action") String action,
            @Param("reason") String reason
    );

    List<ReportActionLogVO> getReportActionLogs(int report_id);

    void rejectReport(@Param("report_id") int report_id,
                      @Param("reason") String reason);

}
