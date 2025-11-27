package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.CommunityService;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Inject
    private CommunityService communityService;

    /** 
     * 📌 커뮤니티 목록 페이지
     * - 카테고리 필터 가능
     * - 페이징 PageVO 적용
     */
    @GetMapping("/list")
    public String communityList(
            @RequestParam(value = "categoryMainNum", required = false) Integer categoryMainNum,
            @RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
            Model model) {

        // ---------- 📌 PageVO 기본 설정 ----------
        PageVO pageVO = new PageVO();
        pageVO.setPageNum(pageNum);
        pageVO.setPageSize(10);  // 페이지당 글 수

        // ---------- 📌 전체 게시글 수 조회 ----------
        int totalCount = communityService.getTotalCount(categoryMainNum);
        pageVO.setCount(totalCount);

        // ---------- 📌 현재 페이지 계산 ----------
        int currentPage = Integer.parseInt(pageNum);
        pageVO.setCurrentPage(currentPage);

        // ---------- 📌 DB LIMIT 계산 ----------
        int offset = (currentPage - 1) * pageVO.getPageSize();

        // ---------- 📌 게시글 목록 조회 ----------
        List<CommunityContentVO> communityContentList = communityService.getList(
                categoryMainNum,
                currentPage,
                pageVO.getPageSize()
        );

        // ---------- 📌 모델에 담기 ----------
        model.addAttribute("pageVO", pageVO);
        model.addAttribute("communityContentList", communityContentList);
        model.addAttribute("categoryMainNum", categoryMainNum);

        return "community/communityList";
    }
}
