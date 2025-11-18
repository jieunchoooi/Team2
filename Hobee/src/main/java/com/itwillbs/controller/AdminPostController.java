package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.service.AdminPostService;

@Controller
@RequestMapping("/admin")  // ⭐ 모든 URL은 /admin/ 으로 시작
public class AdminPostController {
	
	@Inject
	private AdminPostService adminPostService;
	
	 /* ============================================================
    📌 1. 게시글 목록 페이지
    URL: /admin/adminPostList
    설명: community_content의 모든 글을 조회해 목록으로 출력
    ============================================================ */
	@GetMapping("/adminPostList")
	public String postList(Model model) {
		System.out.println("AdminPostController: postList() 실행");

     // 전체 게시글 리스트 가져오기
     model.addAttribute("postList", adminPostService.getPostList());

     // 사이드바 메뉴 활성화 표시용
     model.addAttribute("page", "postList");

     // 이동할 뷰(JSP)
     return "admin/community/adminPostList";
 }



	/* ============================================================
    📌 2. 게시글 상세 페이지
    URL: /admin/adminPostDetail?post_id=번호
    설명: 게시글 1개 상세 보기
    ============================================================ */
	@GetMapping("/adminPostDetail")
	public String postDetail(@RequestParam("post_id") int post_id, Model model) {
		System.out.println("AdminPostController: postDetail() 실행");

     // 상세 게시글 조회
     AdminPostVO post = adminPostService.getPostDetail(post_id);
     model.addAttribute("post", post);

     // 사이드바 메뉴 표시 유지
     model.addAttribute("page", "postList");

     return "admin/community/adminPostDetail";
 }



	/* ============================================================
    📌 3. 게시글 공개/숨김 토글 처리
    URL: /admin/adminPostToggle  (POST)
    설명: is_visible = 1 → 0, 0 → 1 변경
    ============================================================ */
	@PostMapping("/adminPostToggle")
	public String togglePostVisible(@RequestParam("post_id") int post_id) {
		System.out.println("AdminPostController: togglePostVisible() 실행");

     // 토글 실행
     adminPostService.togglePostVisible(post_id);

     // 다시 목록 페이지로 이동
     return "redirect:/admin/adminPostList";
 }



	/* ============================================================
    📌 4. 게시글 삭제
    URL: /admin/adminPostDelete  (POST)
    설명: 게시글을 DB에서 완전 삭제
    ============================================================ */
	@PostMapping("/adminPostDelete")
	public String deletePost(@RequestParam("post_id") int post_id) {
		System.out.println("AdminPostController: deletePost() 실행");

     adminPostService.deletePost(post_id);

     // 목록으로 이동
     return "redirect:/admin/adminPostList";
 	}

}


