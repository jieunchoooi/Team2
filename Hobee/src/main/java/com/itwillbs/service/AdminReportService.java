package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminReportVO;
import com.itwillbs.mapper.AdminReportMapper;

@Service
public class AdminReportService {
	
	@Inject
	private AdminReportMapper adminReportMapper;
	
	// 신고 목록
	public List<AdminReportVO> getReportList() {
		System.out.println("AdminReportService: getReportList() 실행");
        return adminReportMapper.getReportList();
    }

	// 상세 페이지
    public AdminReportVO getReportDetail(int report_id) {
    	System.out.println("AdminReportService: getReportDetail() 실행");
        return adminReportMapper.getReportDetail(report_id);
    }

 // 신고 처리 완료
    public void updateReportDone(int report_id) {
    	System.out.println("AdminReportService: updateReportDone() 실행");
    	adminReportMapper.updateReportDone(report_id);
    }

}
