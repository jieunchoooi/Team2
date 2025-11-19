package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.service.AdminNoticeService;

@Controller
@RequestMapping("/admin/*")
public class AdminNoticeController {
	
	@Inject
	private AdminNoticeService adminNoticeService;
	
	// ⭐ 공지 목록
    @GetMapping("adminNoticeList")
    public String noticeList(Model model) {
    	System.out.println("AdminNoticeController: noticeList() 실행");

        List<AdminNoticeVO> noticeList = adminNoticeService.getNoticeList();
        model.addAttribute("noticeList", noticeList);

        return "admin/community/adminNoticeList";
    }

    // ⭐ 공지 작성 폼
    @GetMapping("adminNoticeWrite")
    public String noticeWriteForm() {
    	System.out.println("AdminNoticeController: noticeWriteForm() 실행");
        return "admin/community/adminNoticeWrite";
    }

    // ⭐ 공지 작성 처리
    @PostMapping("adminNoticeWritePro")
    public String noticeWritePro(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeController: noticeWritePro() 실행");

        // 관리자 아이디는 로그인 세션에서 가져오는 게 정석이지만,
        // 현재는 테스트용으로 고정 값 사용 가능
        if (vo.getAdmin_id() == null) {
            vo.setAdmin_id("admin");
        }

        adminNoticeService.insertNotice(vo);
        return "redirect:/admin/adminNoticeList";
    }

    // ⭐ 공지 상세 + 조회수 증가
    @GetMapping("adminNoticeDetail")
    public String noticeDetail(@RequestParam("notice_id") int notice_id, Model model) {
    	System.out.println("AdminNoticeController: noticeDetail() 실행");

        // 조회수 증가
    	adminNoticeService.updateViewCount(notice_id);

        AdminNoticeVO notice = adminNoticeService.getNoticeDetail(notice_id);
        model.addAttribute("notice", notice);

        return "admin/community/adminNoticeDetail";
    }

    // ⭐ 공지 수정 폼
    @GetMapping("adminNoticeEdit")
    public String noticeEditForm(@RequestParam("notice_id") int notice_id, Model model) {
    	System.out.println("AdminNoticeController: noticeEditForm() 실행");

        AdminNoticeVO notice = adminNoticeService.getNoticeDetail(notice_id);
        model.addAttribute("notice", notice);

        return "admin/community/adminNoticeEdit";
    }

    // ⭐ 공지 수정 처리
    @PostMapping("adminNoticeEditPro")
    public String noticeEditPro(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeController: noticeEditPro() 실행");

    	adminNoticeService.updateNotice(vo);
        return "redirect:/admin/adminNoticeDetail?notice_id=" + vo.getNotice_id();
    }

    // ⭐ 공지 삭제
    @PostMapping("adminNoticeDelete")
    public String noticeDelete(@RequestParam("notice_id") int notice_id) {
    	System.out.println("AdminNoticeController: noticeDelete() 실행");

    	adminNoticeService.deleteNotice(notice_id);
        return "redirect:/admin/adminNoticeList";
    }

    // ⭐ 공개/숨김 토글
    @PostMapping("adminNoticeVisible")
    public String noticeVisible(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeController: noticeVisible() 실행");

    	adminNoticeService.updateVisible(vo);
        return "redirect:/admin/adminNoticeList";
    }

}
