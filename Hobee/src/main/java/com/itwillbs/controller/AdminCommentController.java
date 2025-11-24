package com.itwillbs.controller;

import javax.inject.Inject;

import com.itwillbs.domain.AdminCommentVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.PageDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.service.AdminCommentService;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminCommentController {

	@Inject
	private AdminCommentService adminCommentService;


	/** 댓글 목록 */
	@GetMapping("/adminCommentList")
	public String commentList(
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false) String type,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="sort", defaultValue="recent") String sort,
			@RequestParam(value="status", defaultValue="normal") String status,
			Model model) {

		Criteria cri = new Criteria(pageNum, 10);
		cri.setType(type);
		cri.setKeyword(keyword);

		// 리스트 조회
		List<AdminCommentVO> list =
				adminCommentService.getPagingCommentList(cri, type, keyword, sort, status);
		model.addAttribute("commentList", list);

		// 페이징 정보 (status 포함해야 함!)
		int total = adminCommentService.getTotalCount(type, keyword, status);
		PageDTO pageMaker = new PageDTO(pageNum, 10, total, sort);

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("status", status);


		// 사이드바 active 표시
		model.addAttribute("page", "commentList");

		return "admin/community/adminCommentList";
	}


	/** 일괄 삭제 */
	@PostMapping("/adminCommentBatchDelete")
	@ResponseBody
	public String batchDelete(@RequestParam("ids[]") List<Integer> ids) {
		adminCommentService.batchDelete(ids);
		return "success";
	}


	/** 댓글 상세보기 */
	@GetMapping("/adminCommentDetail")
	public String commentDetail(
			@RequestParam("comment_id") int comment_id,
			Model model) {

		model.addAttribute("comment", adminCommentService.getCommentDetail(comment_id));
		model.addAttribute("page", "commentList");

		return "admin/community/adminCommentDetail";
	}


	/** 개별 삭제 */
	@PostMapping("/adminCommentDelete")
	public String deleteComment(@RequestParam("comment_id") int comment_id) {

		adminCommentService.deleteComment(comment_id);
		return "redirect:/admin/adminCommentList";
	}


	/** 댓글 복구 */
	@PostMapping("/adminCommentRestore")
	public String restoreComment(@RequestParam("comment_id") int comment_id) {

		adminCommentService.restoreComment(comment_id);
		return "redirect:/admin/adminCommentDetail?comment_id=" + comment_id;
	}

}
