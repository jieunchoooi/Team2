package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.itwillbs.domain.ReportActionLogVO;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminReportVO;
import com.itwillbs.mapper.AdminReportMapper;

@Service
public class AdminReportService {

    @Inject
    private AdminReportMapper adminReportMapper;

    // 🔹 페이징 + 필터 통합 조회
    public Map<String, Object> getReportListWithPaging(String type, String status, int currentPage) {

        int pageSize = 10;
        int offset = (currentPage - 1) * pageSize;

        int totalCount = adminReportMapper.getReportCount(type, status);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        List<AdminReportVO> list =
                adminReportMapper.getReportList(type, status, offset, pageSize);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("currentPage", currentPage);
        result.put("totalPage", totalPage);
        result.put("totalCount", totalCount);

        return result;
    }

    // 상세
    public AdminReportVO getReportDetail(int report_id) {
        return adminReportMapper.getReportDetail(report_id);
    }

    // 신고 처리
    public void updateReportDone(int report_id, String done_reason) {
        adminReportMapper.updateReportDone(report_id, done_reason);
    }

    // 🔥🔥 통계(상단 박스) — 리스트 조건과 동일하게 필터된 버전 사용!!!!
    public Map<String, Integer> getReportStats() {

        Map<String, Integer> map = new HashMap<>();

        map.put("total",   adminReportMapper.getTotalCountFiltered());
        map.put("month",   adminReportMapper.getMonthCountFiltered());
        map.put("post",    adminReportMapper.getPostCountFiltered());
        map.put("comment", adminReportMapper.getCommentCountFiltered());

        return map;
    }

    // 로그 기록
    public void insertActionLog(int report_id, String admin_id, String action, String reason) {
        adminReportMapper.insertReportActionLog(report_id, admin_id, action, reason);
    }

    public List<ReportActionLogVO> getActionLogs(int report_id) {
        return adminReportMapper.getReportActionLogs(report_id);
    }

    public void rejectReport(int report_id, String reason) {
        adminReportMapper.rejectReport(report_id, reason);
    }
}
