package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import com.itwillbs.domain.AdminActionLogVO;
import com.itwillbs.domain.CommentReportVO;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminCommentVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.mapper.AdminCommentMapper;

@Service
public class AdminCommentService {

	@Inject
	private AdminCommentMapper adminCommentMapper;

	// 🔥 검색 + 페이징 리스트
	public List<AdminCommentVO> getPagingCommentList(Criteria cri, String type, String keyword, String sort, String status) {
		System.out.println("AdminCommentService : getPagingCommentList() 실행");
		return adminCommentMapper.getPagingCommentList(cri, type, keyword, sort, status);
	}

	// 🔥 전체 댓글 수 (페이징 계산용)
	public int getTotalCount(String type, String keyword, String status) {
		System.out.println("AdminCommentService : getTotalCount() 실행");
		return adminCommentMapper.getTotalCount(type, keyword, status);
	}

	// 상세보기
	public AdminCommentVO getCommentDetail(int comment_id) {
		System.out.println("AdminCommentService : getCommentDetail() 실행");
		return adminCommentMapper.getCommentDetail(comment_id);
	}

	// 삭제
	public void deleteComment(int comment_id) {
		System.out.println("AdminCommentService : deleteComment() 실행");
		adminCommentMapper.deleteComment(comment_id);
	}

	public void batchDelete(List<Integer> ids) {
		System.out.println("AdminCommentService : batchDelete() 실행");
		adminCommentMapper.batchDelete(ids);
	}

	public void restoreComment(int id) {
		System.out.println("AdminCommentService : restoreComment() 실행");
		adminCommentMapper.restoreComment(id);
	}

	public List<CommentReportVO> getCommentReportList(int comment_id) {
		System.out.println("AdminCommentService : getCommentReportList() 실행");
		return adminCommentMapper.getCommentReportList(comment_id);
	}

	public void logAction(int comment_id, String admin_id, String action, String reason) {
		System.out.println("AdminCommentService : logAction() 실행");
		adminCommentMapper.insertActionLog(comment_id, admin_id, action, reason);
	}

	public List<AdminActionLogVO> getActionLogs(int comment_id) {
		System.out.println("AdminCommentService : getActionLogs() 실행");
		return adminCommentMapper.getCommentActionLogs(comment_id);
	}
	
	public List<AdminCommentVO> getComments(int post_id) {
		System.out.println("AdminCommentService : getComments() 실행");
	    return adminCommentMapper.getCommentsByPostId(post_id);
	}


}
