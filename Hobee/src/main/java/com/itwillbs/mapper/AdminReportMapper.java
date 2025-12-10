package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.ReportActionLogVO;
import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminReportVO;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminReportMapper {

    /* 목록 조회 + 페이징 */
    List<AdminReportVO> getReportList(
            @Param("type") String type,
            @Param("status") String status,
            @Param("offset") int offset,
            @Param("pageSize") int pageSize
    );

    int getReportCount(@Param("type") String type,
                       @Param("status") String status);

    /* 상세 조회 */
    AdminReportVO getReportDetail(int report_id);

    /* 처리 완료 (ACCEPT) */
    void updateReportDone(
            @Param("report_id") int report_id,
            @Param("admin_reason") String admin_reason
    );

    /* 신고 반려 (REJECT) */
    void rejectReport(
            @Param("report_id") int report_id,
            @Param("admin_reason") String admin_reason
    );

    /* 통계 */
    int getTotalCountFiltered();
    int getMonthCountFiltered();
    int getPostCountFiltered();
    int getCommentCountFiltered();

    /* 처리 로그 */
    void insertReportActionLog(
            @Param("report_id") int report_id,
            @Param("admin_id") String admin_id,
            @Param("action") String action,
            @Param("reason") String reason
    );

    List<ReportActionLogVO> getReportActionLogs(int report_id);
}
