package com.itwillbs.controller;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.domain.AdminFaqVO;
import com.itwillbs.service.AdminFaqService;

@Controller
@RequestMapping("/admin/*")
public class AdminFaqController {

    @Inject
    private AdminFaqService adminFaqService;

    // ⭐ FAQ 목록
    @GetMapping("adminFaqList")
    public String faqList(
            @RequestParam(value="pageNum", defaultValue="1") int pageNum,
            @RequestParam(value="category", required=false) String category,
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="sort", defaultValue="order") String sort,
            Model model) {

        int pageSize = 10;
        int startRow = (pageNum - 1) * pageSize;

        List<AdminFaqVO> faqList =
                adminFaqService.getFaqListPaged(startRow, pageSize, category, keyword, sort);

        int totalCount = adminFaqService.getFaqCount(category, keyword);
        int totalPage = (int)Math.ceil((double)totalCount / pageSize);

        model.addAttribute("faqList", faqList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sort", sort);

        return "admin/community/adminFaqList";
    }

    // ⭐ FAQ 작성 폼
    @GetMapping("adminFaqWrite")
    public String faqWriteForm() {
        return "admin/community/adminFaqWrite";
    }

    // ⭐ FAQ 작성 처리
    @PostMapping("adminFaqWritePro")
    public String faqWritePro(AdminFaqVO vo) {
        adminFaqService.insertFaq(vo);
        return "redirect:/admin/adminFaqList";
    }

    // ⭐ FAQ 상세
    @GetMapping("adminFaqDetail")
    public String faqDetail(@RequestParam("faq_id") int faq_id, Model model) {
        AdminFaqVO faq = adminFaqService.getFaqDetail(faq_id);
        model.addAttribute("faq", faq);
        return "admin/community/adminFaqDetail";
    }

    // ⭐ FAQ 수정 폼
    @GetMapping("adminFaqEdit")
    public String faqEditForm(@RequestParam("faq_id") int faq_id, Model model) {
        AdminFaqVO faq = adminFaqService.getFaqDetail(faq_id);
        model.addAttribute("faq", faq);
        return "admin/community/adminFaqEdit";
    }

    // ⭐ FAQ 수정 처리
    @PostMapping("adminFaqEditPro")
    public String faqEditPro(AdminFaqVO vo) {
        adminFaqService.updateFaq(vo);
        return "redirect:/admin/adminFaqDetail?faq_id=" + vo.getFaq_id();
    }

    // ⭐ FAQ 삭제
    @PostMapping("adminFaqDelete")
    public String faqDelete(@RequestParam("faq_id") int faq_id) {
        adminFaqService.deleteFaq(faq_id);
        return "redirect:/admin/adminFaqList";
    }

    // ⭐ 공개 / 숨김
    @PostMapping("adminFaqVisibleAjax")
    @ResponseBody
    public String faqVisibleAjax(@RequestParam("faq_id") int faq_id,
                                 @RequestParam("is_visible") int isVisible) {

        AdminFaqVO vo = new AdminFaqVO();
        vo.setFaq_id(faq_id);
        vo.setIs_visible(isVisible);

        adminFaqService.updateVisible(vo);
        return "success";
    }

    // ⭐ 일괄 공개/숨김
    @PostMapping("adminFaqBatchVisible")
    @ResponseBody
    public String faqBatchVisible(@RequestParam("ids") List<Integer> ids,
                                  @RequestParam("is_visible") int isVisible) {
        adminFaqService.updateVisibleBatch(ids, isVisible);
        return "success";
    }

    // ⭐ 일괄 삭제
    @PostMapping("adminFaqBatchDelete")
    @ResponseBody
    public String faqBatchDelete(@RequestParam("ids") List<Integer> ids) {
        adminFaqService.deleteBatch(ids);
        return "success";
    }

    // ⭐ 드래그 정렬 저장
    @PostMapping("adminFaqUpdateOrder")
    @ResponseBody
    public String updateFaqOrder(@RequestBody List<AdminFaqVO> list) {
        adminFaqService.updateOrder(list);
        return "success";
    }
}
