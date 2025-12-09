package com.itwillbs.controller;

import com.itwillbs.domain.AdminFaqVO;
import com.itwillbs.service.AdminFaqService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/faq/*")
public class FaqUserController {

    @Inject
    private AdminFaqService faqService;


    /** =======================================================
     *  사용자 FAQ 목록
     *  - 카테고리 필터 적용
     *  - 공개된 FAQ만 노출 (is_visible = 1)
     * ======================================================= */
    @GetMapping("faqList")
    public String faqList(@RequestParam(required = false) String category,
                          Model model) {

        // 관리자가 만든 FAQ 리스트 가져오기 (검색 없음)
        List<AdminFaqVO> faqList = faqService.getFaqListFiltered(category, "");

        // 🔥 공개 상태(is_visible = 1)만 사용자에게 노출
        faqList.removeIf(f -> f.getIs_visible() == 0);

        model.addAttribute("faqList", faqList);
        model.addAttribute("category", category);

        return "faq/faqList";   // 사용자 JSP
    }



    /** =======================================================
     *  사용자 FAQ 상세
     *  - 숨김 FAQ 접근 차단
     * ======================================================= */
    @GetMapping("faqDetail")
    public String faqDetail(@RequestParam("faq_id") int faqId, Model model) {

        AdminFaqVO faq = faqService.getFaqDetail(faqId);

        // 🔥 숨김 FAQ는 강제로 목록으로 이동
        if (faq.getIs_visible() == 0) {
            return "redirect:/faq/list";
        }

        model.addAttribute("faq", faq);

        return "faq/faqDetail";   // 사용자 JSP
    }

}
