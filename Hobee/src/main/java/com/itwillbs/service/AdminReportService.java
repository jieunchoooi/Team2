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

	// 🔹 페이징 + 필터 통합 조회 (최신 메서드)
	public Map<String, Object> getReportListWithPaging(String type, String status, int currentPage) {

		int pageSize = 10;
		int offset = (currentPage - 1) * pageSize;

		// 전체 개수
		int totalCount = adminReportMapper.getReportCount(type, status);

		// 총 페이지
		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		// 리스트 조회
		List<AdminReportVO> list =
				adminReportMapper.getReportList(type, status, offset, pageSize);

		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("currentPage", currentPage);
		result.put("totalPage", totalPage);
		result.put("totalCount", totalCount);

		return result;
	}

	// 상세 페이지
	public AdminReportVO getReportDetail(int report_id) {
		return adminReportMapper.getReportDetail(report_id);
	}

	// 신고 처리
	public void updateReportDone(int report_id, String done_reason) {
		adminReportMapper.updateReportDone(report_id, done_reason);
	}


	public Map<String, Integer> getReportStats() {

		Map<String, Integer> map = new HashMap<>();
		map.put("total", adminReportMapper.getTotalCount());
		map.put("month", adminReportMapper.getMonthCount());
		map.put("post", adminReportMapper.getPostCount());
		map.put("comment", adminReportMapper.getCommentCount());

		return map;
	}

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
