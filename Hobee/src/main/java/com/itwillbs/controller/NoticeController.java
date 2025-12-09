package com.itwillbs.controller;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.domain.NoticeFileVO;
import com.itwillbs.service.AdminNoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

    @Inject
    private AdminNoticeService noticeService;

    /** ===============================
     * 사용자 공지사항 목록
     * =============================== */
    @GetMapping("list")
    public String noticeList(Model model) {

        // ⭐ Mapper에 이미 준비된 사용자 조회 기능!
        List<AdminNoticeVO> noticeList = noticeService.getNoticeListForUser();

        model.addAttribute("noticeList", noticeList);

        return "notice/noticeList";   // 사용자 JSP
    }


    /** ===============================
     * 사용자 공지사항 상세
     * =============================== */
    @GetMapping("detail")
    public String noticeDetail(@RequestParam("notice_id") int noticeId,
                               Model model) {

        // 조회수 증가
        noticeService.updateViewCount(noticeId);

        AdminNoticeVO notice = noticeService.getNoticeDetail(noticeId);
        List<NoticeFileVO> files = noticeService.getNoticeFiles(noticeId);

        // 공개되지 않은 공지 숨김 처리
        if (notice.getIs_visible() == 0) {
            return "redirect:/notice/list";
        }

        model.addAttribute("notice", notice);
        model.addAttribute("files", files);

        return "notice/noticeDetail";  // 사용자 JSP
    }

}
