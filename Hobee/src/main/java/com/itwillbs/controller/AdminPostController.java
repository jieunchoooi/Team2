package com.itwillbs.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.domain.AdminCommentVO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.AdminPostService;
import com.itwillbs.service.AdminCommentService;

@Controller
@RequestMapping("/admin")
public class AdminPostController {

	@Inject
	private AdminPostService adminPostService;

	@Inject
	private AdminCommentService adminCommentService;


	/* ============================================================
       📌 1. 게시글 목록
    ============================================================ */
	@GetMapping("/adminPostList")
	public String postList(
			Model model,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String type,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "recent") String sort
	) {

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

		/* --------------------------------------------
       ⭐ 등록일(created_at) 형식 자동 변환 추가
       DB에서 "2025-12-02 09:21:38" 형태가 오면
       JSP에서 한 줄 날짜+시간으로 완벽하게 출력됨
    -------------------------------------------- */
		DateTimeFormatter inputFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter outputFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		for (AdminPostVO post : list) {

			try {
				// 1) 줄바꿈 문자 제거
				String cleaned = post.getCreated_at()
						.replace("\n", " ")
						.replace("\r", " ")
						.trim();

				// 2) LocalDateTime 변환
				LocalDateTime dt = LocalDateTime.parse(cleaned, inputFmt);

				// 3) 다시 한 줄로 포맷
				post.setCreated_at(dt.format(outputFmt));

			} catch (Exception e) {
				// 변환 실패 → 원본 유지
				// (필요하면 콘솔 출력해서 확인 가능)
				// System.out.println("PARSE FAIL:" + post.getCreated_at());
			}
		}


		PageDTO pageDTO = new PageDTO(pageNum, amount, total, sort);

		model.addAttribute("postList", list);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("sort", sort);
		model.addAttribute("page", "postList");
		System.out.println(list);

		return "admin/community/adminPostList";
	}


	/* ============================================================
       📌 2. 게시글 상세 (댓글 포함)
    ============================================================ */
	@GetMapping("/adminPostDetail")
	public String postDetail(@RequestParam("post_id") int post_id, Model model) {

		AdminPostVO post = adminPostService.getPostDetail(post_id);
		model.addAttribute("post", post);

		List<AdminCommentVO> comments = adminCommentService.getComments(post_id);
		model.addAttribute("comments", comments);

		model.addAttribute("page", "postList");

		return "admin/community/adminPostDetail";
	}


	/* ============================================================
       📌 3. 게시글 Soft Delete (is_deleted = 1)
    ============================================================ */
	@PostMapping("/adminPostDelete")
	public String deletePost(@RequestParam("post_id") int post_id) {

		adminPostService.deletePost(post_id);
		return "redirect:/admin/adminPostList";
	}


	/* ============================================================
       📌 4. 삭제된 게시글 목록 (휴지통)
    ============================================================ */
	@GetMapping("/adminPostDeletedList")
	public String deletedPostList(Model model) {

		List<AdminPostVO> deletedList = adminPostService.getDeletedPostList();
		model.addAttribute("deletedList", deletedList);

		model.addAttribute("page", "postDeleted");
		return "admin/community/adminPostDeletedList";
	}


	/* ============================================================
       📌 5-1. 🔥 상세보기에서 "복구" (Detail → Detail)
    ============================================================ */
	@PostMapping("/adminPostRestoreFromDetail")
	public String restorePostFromDetail(@RequestParam("post_id") int post_id) {

		adminPostService.restorePost(post_id);

		// 복구한 글의 상세보기로 이동
		return "redirect:/admin/adminPostDetail?post_id=" + post_id;
	}


	/* ============================================================
       📌 5-2. 🔥 휴지통에서 "복구" (Trash → Trash)
    ============================================================ */
	@PostMapping("/adminPostRestoreFromTrash")
	public String restorePostFromTrash(@RequestParam("post_id") int post_id,
	                                   RedirectAttributes rttr) {

	    adminPostService.restorePost(post_id);

	    // ⭐ Toastify 조건 전달
	    rttr.addFlashAttribute("restored", true);

	    // 휴지통 목록으로 이동
	    return "redirect:/admin/adminPostDeletedList";
	}


	/* ============================================================
       📌 6. 게시글 노출 상태(공개/숨김) 토글
    ============================================================ */
	@PostMapping("/adminPostToggle")
	public String togglePostVisible(@RequestParam("post_id") int post_id) {

		adminPostService.togglePostVisible(post_id);
		return "redirect:/admin/adminPostDetail?post_id=" + post_id;
	}


	/* ============================================================
       📌 7. 게시글 일괄 처리 (숨김 / 표시 / 삭제)
    ============================================================ */
	@PostMapping("/adminPostBatch")
	public String adminPostBatch(
			@RequestParam("postIds") List<Integer> postIds,
			@RequestParam("action") String action
	) {

		switch (action) {
			case "hide":
				adminPostService.batchHide(postIds);
				break;

			case "show":
				adminPostService.batchShow(postIds);
				break;

			case "delete":
				adminPostService.batchDelete(postIds);
				break;
		}

		return "redirect:/admin/adminPostList";
	}
	/* ============================================================
       📌 8. 게시글 통계 페이지
    ============================================================ */
	@GetMapping("/adminPostStats")
	public String adminPostStats(Model model) {

	    model.addAttribute("page", "postStats");

	    // 조회수 TOP 10
	    List<Map<String, Object>> viewStats = adminPostService.getTopViewPosts();

	    // 댓글수 TOP 10
	    List<Map<String, Object>> commentStats = adminPostService.getTopCommentPosts();

	    // 🔥 최근 7일 게시글 수 (정확한 서비스 메서드 사용)
	    List<Map<String, Object>> weeklyStats = adminPostService.getWeeklyPostCount();

	    // 🔥 게시판별 게시글 비율 (정확한 서비스 메서드 사용)
	    List<Map<String, Object>> categoryStats = adminPostService.getPostsByCategory();

	    model.addAttribute("viewStats", viewStats);
	    model.addAttribute("commentStats", commentStats);
	    model.addAttribute("weeklyStats", weeklyStats);
	    model.addAttribute("categoryStats", categoryStats);

	    return "admin/community/adminPostStats";
	}


	// 검색 자동완성
	// 검색 자동완성
	@GetMapping("/post/searchAuto")
	@ResponseBody
	public List<String> searchAuto(@RequestParam("keyword") String keyword) {
		return adminPostService.getAutoComplete(keyword);
	}
}
