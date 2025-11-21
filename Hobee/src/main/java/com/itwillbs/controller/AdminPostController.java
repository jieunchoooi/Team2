package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.AdminPostService;

@Controller
@RequestMapping("/admin")  // ⭐ 모든 URL은 /admin/ 으로 시작
public class AdminPostController {
	
	@Inject
	private AdminPostService adminPostService;

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

	    // 🔍 검색어 없음 → 전체 목록 조회
	    if(type.equals("") || keyword.equals("")) {
	        total = adminPostService.getTotalCount();
	        list = adminPostService.getPostListPaging(pageNum, amount, sort);   // 🔥 정렬 포함
	    }
	    // 🔍 검색어 있음 → 검색 목록 조회
	    else {
	        total = adminPostService.getSearchTotalCount(type, keyword);
	        list = adminPostService.getSearchPostList(pageNum, amount, type, keyword, sort);  // 🔥 정렬 포함
	    }

	    // 페이징
	    PageDTO pageDTO = new PageDTO(pageNum, amount, total, sort);

	    // 화면 전달
	    model.addAttribute("postList", list);
	    model.addAttribute("pageDTO", pageDTO);
	    model.addAttribute("pageNum", pageNum);

	    model.addAttribute("type", type);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("sort", sort);      // 🔥 정렬 옵션 유지 위해 추가

	    return "admin/community/adminPostList";
	}


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


	@PostMapping("/adminPostToggle")
	public String togglePostVisible(@RequestParam("post_id") int post_id) {
		System.out.println("AdminPostController: togglePostVisible() 실행");

     // 토글 실행
     adminPostService.togglePostVisible(post_id);

     // ★ 상세페이지로 다시 이동하도록 변경
     return "redirect:/admin/adminPostDetail?post_id=" + post_id;
	}


	@PostMapping("/adminPostDelete")
	public String deletePost(@RequestParam("post_id") int post_id) {
		System.out.println("AdminPostController: deletePost() 실행");

     adminPostService.deletePost(post_id);

     // 목록으로 이동
     return "redirect:/admin/adminPostList";
 	}
	
	@PostMapping("/adminPostBatch")
	public String adminPostBatch(
	        @RequestParam("postIds") List<Integer> postIds,
	        @RequestParam("action") String action) {
		
		System.out.println("AdminPostController: adminPostBatch() 실행");
	    if (action.equals("hide")) {
	        adminPostService.batchHide(postIds);
	    } else if (action.equals("show")) {
	        adminPostService.batchShow(postIds);
	    } else if (action.equals("delete")) {
	        adminPostService.batchDelete(postIds);
	    }

	    return "redirect:/admin/adminPostList";
	}
	// 수정 페이지 이동
	@GetMapping("/adminPostEdit")
	public String adminPostEdit(@RequestParam int post_id, Model model) {
		System.out.println("AdminPostController: adminPostEdit() 실행");
	    model.addAttribute("post", adminPostService.getPostDetail(post_id));
	    return "admin/community/adminPostEdit";
	}

	// 수정 처리
	@PostMapping("/adminPostEditPro")
	public String adminPostEditPro(AdminPostVO vo) {
		System.out.println("AdminPostController: adminPostEditPro() 실행");
	    adminPostService.updatePost(vo);
	    return "redirect:/admin/adminPostDetail?post_id=" + vo.getPost_id();
	}
	
}


