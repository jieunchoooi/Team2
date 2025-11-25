package com.itwillbs.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.domain.AdminCommentVO;   // ⭐ 댓글 VO import
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.AdminPostService;
import com.itwillbs.service.AdminCommentService;   // ⭐ 댓글 서비스 import

@Controller
@RequestMapping("/admin")
public class AdminPostController {

    @Inject
    private AdminPostService adminPostService;

    @Inject
    private AdminCommentService adminCommentService;   // ⭐ 댓글 서비스 연결

    // ======================================
    // ⭐ 게시글 목록
    // ======================================
    @GetMapping("/adminPostList")
    public String postList(
            Model model,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "") String type,
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "recent") String sort) {

        System.out.println("AdminPostController: postList() 실행");

        int amount = 10;

        List<AdminPostVO> list;
        int total;

        if (type.equals("") || keyword.equals("")) {
            total = adminPostService.getTotalCount();
            list = adminPostService.getPostListPaging(pageNum, amount, sort);
        } else {
            total = adminPostService.getSearchTotalCount(type, keyword);
            list = adminPostService.getSearchPostList(pageNum, amount, type, keyword, sort);
        }

        PageDTO pageDTO = new PageDTO(pageNum, amount, total, sort);

        model.addAttribute("postList", list);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sort", sort);

        return "admin/community/adminPostList";
    }

    // ======================================
    // ⭐ 게시글 상세 + 댓글 목록 조회
    // ======================================
    @GetMapping("/adminPostDetail")
    public String postDetail(@RequestParam("post_id") int post_id, Model model) {
        System.out.println("AdminPostController: postDetail() 실행");

        // 📌 게시글 정보 조회
        AdminPostVO post = adminPostService.getPostDetail(post_id);
        model.addAttribute("post", post);

        // ⭐📌 댓글 목록 조회 추가 (여기!!)
        List<AdminCommentVO> comments = adminCommentService.getComments(post_id);
        model.addAttribute("comments", comments);

        // 사이드바 활성화용
        model.addAttribute("page", "postList");

        return "admin/community/adminPostDetail";
    }

    // ======================================
    // ⭐ 댓글 삭제 (is_deleted = 1)
    // ======================================
    @PostMapping("/postDetailCommentDelete")
    public String adminCommentDelete(
            @RequestParam int post_id,
            @RequestParam int comment_id) {

        System.out.println("AdminPostController: adminCommentDelete() 실행");

        adminCommentService.deleteComment(comment_id);
        return "redirect:/admin/adminPostDetail?post_id=" + post_id;
    }

    // ======================================
    // ⭐ 댓글 복구 (is_deleted = 0)
    // ======================================
    @PostMapping("/postDetailCommentRestore")
    public String adminCommentRestore(
            @RequestParam int post_id,
            @RequestParam int comment_id) {

        System.out.println("AdminPostController: adminCommentRestore() 실행");

        adminCommentService.restoreComment(comment_id);
        return "redirect:/admin/adminPostDetail?post_id=" + post_id;
    }

    // ======================================
    // 게시글 공개/숨김 토글
    // ======================================
    @PostMapping("/adminPostToggle")
    public String togglePostVisible(@RequestParam("post_id") int post_id) {

        adminPostService.togglePostVisible(post_id);
        return "redirect:/admin/adminPostDetail?post_id=" + post_id;
    }

    // ======================================
    // 게시글 삭제
    // ======================================
    @PostMapping("/adminPostDelete")
    public String deletePost(@RequestParam("post_id") int post_id) {

        adminPostService.deletePost(post_id);
        return "redirect:/admin/adminPostList";
    }

    // ======================================
    // 게시글 일괄 처리
    // ======================================
    @PostMapping("/adminPostBatch")
    public String adminPostBatch(
            @RequestParam("postIds") List<Integer> postIds,
            @RequestParam("action") String action) {

        if (action.equals("hide")) {
            adminPostService.batchHide(postIds);
        } else if (action.equals("show")) {
            adminPostService.batchShow(postIds);
        } else if (action.equals("delete")) {
            adminPostService.batchDelete(postIds);
        }

        return "redirect:/admin/adminPostList";
    }

    // ======================================
    // 게시글 수정 페이지 이동
    // ======================================
    @GetMapping("/adminPostEdit")
    public String adminPostEdit(@RequestParam int post_id, Model model) {

        model.addAttribute("post", adminPostService.getPostDetail(post_id));
        return "admin/community/adminPostEdit";
    }

    // ======================================
    // 게시글 수정 처리
    // ======================================
    @PostMapping("/adminPostEditPro")
    public String adminPostEditPro(AdminPostVO vo) {

        adminPostService.updatePost(vo);
        return "redirect:/admin/adminPostDetail?post_id=" + vo.getPost_id();
    }
    
    @GetMapping("/adminPostStats")
    public String adminPostStats(Model model) {

        model.addAttribute("page", "postStats"); // ⭐ 사이드바 활성화

        List<Map<String, Object>> viewStats = adminPostService.getTopViewPosts();
        List<Map<String, Object>> commentStats = adminPostService.getTopCommentPosts();

        model.addAttribute("viewStats", viewStats);
        model.addAttribute("commentStats", commentStats);

        return "admin/community/adminPostStats";
    }


}
