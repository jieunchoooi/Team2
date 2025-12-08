package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.ReportActionLogVO;
import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminReportVO;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminReportMapper {

    List<AdminReportVO> getReportList(
            @Param("type") String type,
            @Param("status") String status,
            @Param("offset") int offset,
            @Param("pageSize") int pageSize
    );

    int getReportCount(@Param("type") String type,
                       @Param("status") String status);

    AdminReportVO getReportDetail(int report_id);

    void updateReportDone(@Param("report_id") int report_id,
                          @Param("done_reason") String done_reason);

    void rejectReport(@Param("report_id") int report_id,
                      @Param("reason") String reason);

    /* 🔥 필터된 통계 4종 */
    int getTotalCountFiltered();
    int getMonthCountFiltered();
    int getPostCountFiltered();
    int getCommentCountFiltered();

    /* 로그 */
    void insertReportActionLog(
            @Param("report_id") int report_id,
            @Param("admin_id") String admin_id,
            @Param("action") String action,
            @Param("reason") String reason
    );

    List<ReportActionLogVO> getReportActionLogs(int report_id);
}
