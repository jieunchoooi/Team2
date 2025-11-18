package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.service.AdminReportService;

@Controller
@RequestMapping("/admin")
public class AdminReportController {
	
	@Inject
	private AdminReportService adminReportService;
	
	// 신고 목록
    @GetMapping("/adminReportList")
    public String reportList(Model model) {
    	System.out.println("AdminReportController: reportList() 실행");
        model.addAttribute("page", "reportList");
        model.addAttribute("reportList", adminReportService.getReportList());
        return "admin/community/adminReportList";
    }

    // 상세 페이지
    @GetMapping("/adminReportDetail")
    public String reportDetail(@RequestParam int report_id, Model model) {
    	System.out.println("AdminReportController: reportDetail() 실행");
        model.addAttribute("report", adminReportService.getReportDetail(report_id));
        return "admin/community/adminReportDetail";
    }

    // 신고 처리 완료
    @PostMapping("/adminReportDone")
    public String reportDone(@RequestParam int report_id) {
    	System.out.println("AdminReportController: reportDone() 실행");
    	adminReportService.updateReportDone(report_id);
        return "redirect:/admin/adminReportList";
    }
}


