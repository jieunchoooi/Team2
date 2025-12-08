package com.itwillbs.controller;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.domain.NoticeFileVO;
import com.itwillbs.service.AdminNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class UserNoticeController {

    @Inject
    private AdminNoticeService adminNoticeService;

    /** ================================
     *  📌 사용자 공지 목록
     * ================================ */
    @GetMapping("/list")
    public String noticeList(Model model) {

        // 관리자 공지 중 공개(visible=1)만 사용자에게 노출
        List<AdminNoticeVO> noticeList = adminNoticeService.getNoticeListForUser();

        model.addAttribute("noticeList", noticeList);

        return "community/noticeList";   // ← JSP 파일명
    }

    /** ================================
     *  📌 사용자 공지 상세
     * ================================ */
    @GetMapping("/detail")
    public String noticeDetail(@RequestParam("notice_id") int notice_id, Model model) {

        adminNoticeService.updateViewCount(notice_id);

        AdminNoticeVO notice = adminNoticeService.getNoticeDetail(notice_id);
        List<NoticeFileVO> files = adminNoticeService.getNoticeFiles(notice_id);

        model.addAttribute("notice", notice);
        model.addAttribute("files", files);

        return "community/noticeDetail";  // ← JSP 파일명
    }
}
