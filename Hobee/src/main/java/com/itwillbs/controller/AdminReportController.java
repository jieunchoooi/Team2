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

        Map<String, Object> result =
                adminReportService.getReportListWithPaging(type, status, currentPage);

        model.addAttribute("reportList", result.get("list"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPage", result.get("totalPage"));
        model.addAttribute("totalCount", result.get("totalCount"));

        model.addAttribute("type", type);
        model.addAttribute("status", status);

        // 🔥 통계 정보
        model.addAttribute("stats", adminReportService.getReportStats());

        return "admin/community/adminReportList";
    }

    // ⭐ 신고 상세 보기
    @GetMapping("/adminReportDetail")
    public String reportDetail(@RequestParam int report_id, Model model) {

        model.addAttribute("report", adminReportService.getReportDetail(report_id));

        // 🔥 신고 처리 로그
        model.addAttribute("actionLogs", adminReportService.getActionLogs(report_id));

        return "admin/community/adminReportDetail";
    }

    // ⭐ 신고 처리/반려 통합 엔드포인트
    @PostMapping("/adminReportProcess")
    public String processReport(
            @RequestParam int report_id,
            @RequestParam String action,        // ACCEPT or REJECT
            @RequestParam String admin_reason,  // 사유 통합
            HttpSession session) {

        String adminId = (String) session.getAttribute("user_id");

        // 처리 완료
        if ("ACCEPT".equals(action)) {
            adminReportService.updateReportDone(report_id, admin_reason);
            adminReportService.insertActionLog(report_id, adminId, "ACCEPT", admin_reason);
        }

        // 반려
        else if ("REJECT".equals(action)) {
            adminReportService.rejectReport(report_id, admin_reason);
            adminReportService.insertActionLog(report_id, adminId, "REJECT", admin_reason);
        }

        return "redirect:/admin/adminReportDetail?report_id=" + report_id;
    }


}