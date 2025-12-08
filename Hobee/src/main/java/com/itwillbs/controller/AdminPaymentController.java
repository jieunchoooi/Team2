package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.AdminPaymentCriteria;
import com.itwillbs.domain.AdminPaymentDetailDTO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.AdminPaymentService;

@Controller
@RequestMapping("/admin/*")
public class AdminPaymentController {
    
    @Inject
    private AdminPaymentService adminPaymentService;

	@ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();

	    if (uri.contains("adminPaymentList")) return "paymentList";
	    return "";
	}

    @GetMapping("/adminPaymentList")
    public String list(HttpServletRequest request, Model model,
                       AdminPaymentCriteria adminPaymentCriteria,
                       PageVO pageVO) {

        // 페이지 번호 기본값 설정
        if (pageVO.getPageNum() == null) {
            pageVO.setPageNum("1");
        }

        // pageSize 기본값 및 0 방어 처리
        if (pageVO.getPageSize() <= 0) {
            pageVO.setPageSize(20); // 기본 페이지 사이즈 = 20
        }

        // 페이징 계산에 필요한 값 세팅
        pageVO.setCurrentPage(Integer.parseInt(pageVO.getPageNum()));
        pageVO.setStartRow((pageVO.getCurrentPage() - 1) * pageVO.getPageSize());

        // viewType 설정
        String viewType = adminPaymentCriteria.getViewType();
        if (viewType == null || viewType.equals("")) {
            adminPaymentCriteria.setViewType("payment");
            viewType = "payment";
        }

        List<AdminPaymentDetailDTO> list;
        int totalCount;

        if (viewType.equals("payment")) {
            list = adminPaymentService.getPaymentList(adminPaymentCriteria, pageVO);
            totalCount = adminPaymentService.getPaymentCount(adminPaymentCriteria);
        } else {
            list = adminPaymentService.getLecturePaymentList(adminPaymentCriteria, pageVO);
            totalCount = adminPaymentService.getLecturePaymentCount(adminPaymentCriteria);
        }

        // 페이징 계산
        pageVO.setCount(totalCount);
        pageVO.setPageCount((totalCount - 1) / pageVO.getPageSize() + 1);

        int pageBlock = 10;
        pageVO.setPageBlock(pageBlock);

        int startPage = ((pageVO.getCurrentPage() - 1) / pageBlock) * pageBlock + 1;
        pageVO.setStartPage(startPage);

        int endPage = startPage + pageBlock - 1;
        if (endPage > pageVO.getPageCount()) {
            endPage = pageVO.getPageCount();
        }
        pageVO.setEndPage(endPage);

        // ======================================
        // 📊 통계 4개 (payment_detail 기반)
        // ======================================
        int totalRevenue = adminPaymentService.getTotalRevenue();           // 결제된 강의 가격 총합
        int totalRefund = adminPaymentService.getTotalRefund();             // 환불된 강의 가격 총합
        int lectureSold = adminPaymentService.getTotalLectureSold();        // 판매된 강의 수
        int lectureRefunded = adminPaymentService.getTotalLectureRefunded();// 환불된 강의 수

        // Model 전달
        model.addAttribute("criteria", adminPaymentCriteria);
        model.addAttribute("pageVO", pageVO);
        model.addAttribute("list", list);
        model.addAttribute("viewType", viewType);

        // 📊 통계 데이터 전달
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalRefund", totalRefund);
        model.addAttribute("lectureSold", lectureSold);
        model.addAttribute("lectureRefunded", lectureRefunded);
        System.out.println(list+viewType);
        System.out.println(adminPaymentCriteria);
        System.out.println(pageVO.getPageSize());
        return "/admin/adminPaymentList";
    }

}
