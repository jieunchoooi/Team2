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
public class UserNoticeController {

    @Inject
    private AdminNoticeService noticeService;

    /** =============================================
     *  사용자 공지사항 목록
     *  - 공개된 공지만 노출 (is_visible = 1)
     *  - 상단고정(pinned) 먼저 정렬된 상태로 Mapper 제공됨
     * ============================================= */
    @GetMapping("list")
    public String list(Model model) {

        // ⭐ AdminNoticeMapper에 구현되어 있는 사용자 전용 조회 메서드 사용
        List<AdminNoticeVO> noticeList = noticeService.getNoticeListForUser();

        model.addAttribute("noticeList", noticeList);

        return "notice/noticeList";   // 사용자용 JSP
    }


    /** =============================================
     *  사용자 공지 상세
     *  - 숨김 처리된 공지 접근 시 list로 리다이렉트
     *  - 조회수 증가
     * ============================================= */
    @GetMapping("detail")
    public String detail(@RequestParam("notice_id") int noticeId,
                         Model model) {

        // 조회수 증가
        noticeService.updateViewCount(noticeId);

        AdminNoticeVO notice = noticeService.getNoticeDetail(noticeId);
        List<NoticeFileVO> files = noticeService.getNoticeFiles(noticeId);

        // 숨김(is_visible=0) 상태면 접근 차단
        if (notice.getIs_visible() == 0) {
            return "redirect:/notice/list";
        }

        model.addAttribute("notice", notice);
        model.addAttribute("files", files);

        return "notice/noticeDetail";
    }
}
