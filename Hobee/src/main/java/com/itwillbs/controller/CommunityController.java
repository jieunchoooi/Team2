package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.CommunityDetailDTO;
import com.itwillbs.domain.CommunitySearchCriteria;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReactionCountVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.CommunityService;

/**
 * CommunityController
 * ------------------------------------
 * - /community/list  : 기본 목록 (카테고리/정렬/기간 + 페이징)
 * - /community/search: 검색 전용 (제목/제목+내용/댓글/사용자 + 페이징)
 * - /community/reaction: 좋아요/싫어요 토글
 */
@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    /* ============================================================
    📌 커뮤니티 목록 (검색 + 필터 + 정렬 + 기간 + 페이징)
    - CommunitySearchCriteria 로 통합
    - 파라미터 이름 절대 변경 안 함
    ============================================================ */
	 @GetMapping("/list")
	 public String communityList(CommunitySearchCriteria cri, Model model) {
	
	     // <%-- 기본값 설정 (널 또는 빈값일 때) --%>
	     if (cri.getSort() == null || cri.getSort().equals("")) {
	         cri.setSort("latest");
	     }
	
	     if (cri.getPeriod() == null || cri.getPeriod().equals("")) {
	         cri.setPeriod("all");
	     }
	
	     if (cri.getPage() <= 0) {
	         cri.setPage(1);
	     }
	
	     if (cri.getAmount() <= 0) {
	         cri.setAmount(10);
	     }
	  // offset 계산
	     cri.setOffset((cri.getPage() - 1) * cri.getAmount());
	     // <%-- 게시글 목록 조회 --%>
	     List<CommunityContentVO> communityList = communityService.getCommunityList(cri);
	
	     // <%-- 총 게시글 수 조회 --%>
	     int totalCount = communityService.getTotalCount(cri);
	     PageDTO pageMaker = new PageDTO(cri.getPage(), cri.getAmount(), totalCount);
	
	     // <%-- 카테고리 메인 목록(Chip 버튼용) --%>
	     List<CommunityContentVO> categoryMainList = communityService.getCategoryMainList();
	
	     // <%-- 인기글 목록 --%>
	     List<CommunityContentVO> popularList = communityService.getPopularPosts();
	
	     // 🔥 실시간 핫토픽
	     List<CommunityContentVO> hotTopicList = communityService.getHotTopicList();
	     System.out.println("핫토픽 리스트 "+hotTopicList);
	     model.addAttribute("hotTopicList", hotTopicList);
	
	     // <%-- 모델 등록 --%>
	     model.addAttribute("communityList", communityList);
	     model.addAttribute("categoryMainList", categoryMainList);
	     model.addAttribute("popularList", popularList);
	     model.addAttribute("pageMaker", pageMaker);
	
	     // <%-- 검색/필터 상태유지 --%>
	     model.addAttribute("cri", cri);
	
	     return "community/communityList";
	 }


    // ============================================
    // 📌 3) 좋아요/싫어요 토글 (AJAX)
    // URL: POST /community/reaction
    // 파라미터: post_id, is_like(1=좋아요, 0=싫어요)
    // ============================================
    @ResponseBody
    @PostMapping("/reaction")
    public Map<String, Object> toggleReaction(
            @RequestParam("post_id") int post_id,
            @RequestParam("is_like") int is_like,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 1) 로그인 여부 확인
        UserVO userVO = (UserVO) session.getAttribute("userVO");
        if (userVO == null) {
            result.put("status", "error");
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        int user_num = userVO.getUser_num();

        // 2) 토글 로직 수행 (INSERT / DELETE / UPDATE)
        String action = communityService.togglePostReaction(post_id, user_num, is_like);

        // 3) 변경된 좋아요/싫어요 카운트 조회
        ReactionCountVO reactionCountVO = communityService.getPostReactionCount(post_id);

        result.put("status", "success");
        result.put("action", action);
        result.put("like_count", reactionCountVO.getLike_count());
        result.put("dislike_count", reactionCountVO.getDislike_count());

        return result;
    }
    
    @GetMapping("/detail")
    public String detail(@RequestParam("post_id") int post_id,
                         HttpSession session,
                         Model model) {

        UserVO userVO = (UserVO) session.getAttribute("userVO");
        Integer user_num = userVO != null ? userVO.getUser_num() : null;

        CommunityDetailDTO communityDetailDTO = communityService.getDetailPage(post_id, user_num);

        model.addAttribute("post", communityDetailDTO.getPost());
        model.addAttribute("comments", communityDetailDTO.getComments());

        return "community/communityDetail";
    }


}
