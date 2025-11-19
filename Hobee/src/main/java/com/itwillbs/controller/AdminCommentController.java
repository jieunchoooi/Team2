package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.service.AdminCommentService;

@Controller
@RequestMapping("/admin")
public class AdminCommentController {
	
	@Inject
	private AdminCommentService adminCommentService;
	
    /* 1. 댓글 목록 페이지
    URL: /admin/adminCommentList
    설명: 관리자 페이지에서 모든 댓글 목록 출력 */
   
	@GetMapping("/adminCommentList")
	public String commentList(Model model) {
		System.out.println("AdminCommentController: commentList() 실행");

     // 댓글 목록 가져오기
     model.addAttribute("commentList", adminCommentService.getCommentList());

     // 사이드바 메뉴 active 표시용
     model.addAttribute("page", "commentList");

     // 이동할 JSP
     return "admin/community/adminCommentList";
	}
	
	@GetMapping("/adminCommentDetail")
	public String commentDetail(@RequestParam("comment_id") int comment_id, Model model) {
		System.out.println("AdminCommentController: commentDetail() 실행");
	    // 서비스에서 상세 데이터 가져오기
	    model.addAttribute("comment", adminCommentService.getCommentDetail(comment_id));
	    
	    // 사이드바 active 유지
	    model.addAttribute("page", "commentList");

	    return "admin/community/adminCommentDetail";
	}


	/* 2. 댓글 삭제 (is_deleted = 1)
    URL: /admin/adminCommentDelete
    설명: '삭제' 버튼 눌렀을 때 처리 */
	@PostMapping("/adminCommentDelete")
	public String deleteComment(@RequestParam("comment_id") int comment_id) {
		System.out.println("AdminCommentController: deleteComment() 실행");

     // 삭제 처리 (is_deleted = 1)
     adminCommentService.deleteComment(comment_id);

     // 다시 목록 페이지로 이동
     return "redirect:/admin/adminCommentList";
     }
}
