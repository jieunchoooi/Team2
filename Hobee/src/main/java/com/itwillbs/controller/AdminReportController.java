package com.itwillbs.controller;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.service.AdminReportService;

@Controller
@RequestMapping("/admin")
public class AdminReportController {

    @Inject
    private AdminReportService adminReportService;

    @ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();
	    
	    if (uri.contains("adminReportList")) return "reportList";
	    return "";
	}
   
    
    // ⭐ 신고 목록 (필터 + 페이징)
    @GetMapping("/adminReportList")
    public String reportList(
            @RequestParam(defaultValue = "1") int currentPage,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String status,
            Model model) {

        System.out.println("AdminReportController: reportList() 실행");

        // 서비스에서 리스트 + 페이징정보 맵으로 받기
        Map<String, Object> result =
                adminReportService.getReportListWithPaging(type, status, currentPage);

        // 통계 추가
        Map<String, Integer> stats = adminReportService.getReportStats();
        model.addAttribute("stats", stats);

        // 리스트
        model.addAttribute("reportList", result.get("list"));

        // 페이징 관련 변수들
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPage", result.get("totalPage"));
        model.addAttribute("totalCount", result.get("totalCount"));

        // 필터 유지
        model.addAttribute("type", type);
        model.addAttribute("status", status);

        return "admin/community/adminReportList";
    }

    // ⭐ 신고 상세 보기
    @GetMapping("/adminReportDetail")
    public String reportDetail(@RequestParam int report_id, Model model) {

        System.out.println("AdminReportController: reportDetail() 실행");

        model.addAttribute("report", adminReportService.getReportDetail(report_id));

        // 🔥 신고 처리 로그 가져오기
        model.addAttribute("actionLogs", adminReportService.getActionLogs(report_id));

        return "admin/community/adminReportDetail";
    }

    // ⭐ 신고 처리 완료
    @PostMapping("/adminReportDone")
    public String reportDone(@RequestParam int report_id,
                             @RequestParam(required=false) String done_reason, HttpSession session) {

        String adminId = (String) session.getAttribute("user_id");

        // 신고 처리
        adminReportService.updateReportDone(report_id, done_reason);

        // 🔥 신고 처리 로그 기록
        adminReportService.insertActionLog(report_id, adminId, "처리완료", done_reason);

        return "redirect:/admin/adminReportList";
    }

    @PostMapping("/adminReportReject")
    public String rejectReport(@RequestParam int report_id,
                               @RequestParam String reason,
                               HttpSession session) {

        String adminId = (String) session.getAttribute("user_id");

        adminReportService.rejectReport(report_id, reason);

        // 🔥 반려 로그 자동 저장
        adminReportService.insertActionLog(report_id, adminId, "반려", reason);

        return "redirect:/admin/adminReportDetail?report_id=" + report_id;
    }


}
