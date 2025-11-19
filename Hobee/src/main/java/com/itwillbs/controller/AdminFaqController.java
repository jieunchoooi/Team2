package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.AdminFaqVO;
import com.itwillbs.service.AdminFaqService;

@Controller
@RequestMapping("/admin/*")
public class AdminFaqController {
	
	@Inject
	private AdminFaqService adminFaqService;
	
	// ⭐ FAQ 목록
    @GetMapping("adminFaqList")
    public String faqList(Model model) {
    	System.out.println("AdminFaqController: faqList() 실행");

        List<AdminFaqVO> faqList = adminFaqService.getFaqList();
        model.addAttribute("faqList", faqList);

        return "admin/community/adminFaqList";
    }

    // ⭐ FAQ 작성 폼
    @GetMapping("adminFaqWrite")
    public String faqWriteForm() {
    	System.out.println("AdminFaqController: faqWriteForm() 실행");
        return "admin/community/adminFaqWrite";
    }

    // ⭐ FAQ 작성 처리
    @PostMapping("adminFaqWritePro")
    public String faqWritePro(AdminFaqVO vo) {
    	System.out.println("AdminFaqController: faqWritePro() 실행");

    	adminFaqService.insertFaq(vo);
        return "redirect:/admin/adminFaqList";
    }

    // ⭐ FAQ 상세
    @GetMapping("adminFaqDetail")
    public String faqDetail(@RequestParam("faq_id") int faq_id, Model model) {
    	System.out.println("AdminFaqController: faqDetail() 실행");

        AdminFaqVO faq = adminFaqService.getFaqDetail(faq_id);
        model.addAttribute("faq", faq);

        return "admin/community/adminFaqDetail";
    }

    // ⭐ FAQ 수정 폼
    @GetMapping("adminFaqEdit")
    public String faqEditForm(@RequestParam("faq_id") int faq_id, Model model) {
    	System.out.println("AdminFaqController: faqEditForm() 실행");

        AdminFaqVO faq = adminFaqService.getFaqDetail(faq_id);
        model.addAttribute("faq", faq);

        return "admin/community/adminFaqEdit";
    }

    // ⭐ FAQ 수정 처리
    @PostMapping("adminFaqEditPro")
    public String faqEditPro(AdminFaqVO vo) {
    	System.out.println("AdminFaqController: faqEditPro() 실행");

    	adminFaqService.updateFaq(vo);
        return "redirect:/admin/adminFaqDetail?faq_id=" + vo.getFaq_id();
    }

    // ⭐ FAQ 삭제
    @PostMapping("adminFaqDelete")
    public String faqDelete(@RequestParam("faq_id") int faq_id) {
    	System.out.println("AdminFaqController: faqDelete() 실행");

    	adminFaqService.deleteFaq(faq_id);
        return "redirect:/admin/adminFaqList";
    }

    // ⭐ FAQ 공개/숨김 변경
    @PostMapping("adminFaqVisible")
    public String faqVisible(AdminFaqVO vo) {
    	System.out.println("AdminFaqController: faqVisible() 실행");

    	adminFaqService.updateVisible(vo);
        return "redirect:/admin/adminFaqList";
    }
}


