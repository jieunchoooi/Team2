package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.AdminActionLogVO;
import com.itwillbs.domain.CommentReportVO;
import com.itwillbs.domain.Criteria;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.itwillbs.domain.AdminCommentVO;

@Mapper
public interface AdminCommentMapper {

	// 페이징 + 검색 + 정렬 + 상태 필터
	List<AdminCommentVO> getPagingCommentList(
			@Param("cri") Criteria cri,
			@Param("type") String type,
			@Param("keyword") String keyword,
			@Param("sort") String sort,
			@Param("status") String status
	);

	// 전체 개수
	int getTotalCount(
			@Param("type") String type,
			@Param("keyword") String keyword,
			@Param("status") String status
	);

	// 상세
	AdminCommentVO getCommentDetail(int comment_id);

	// 개별 삭제
	void deleteComment(int comment_id);

	// 일괄 삭제
	void batchDelete(@Param("ids") List<Integer> ids);

	// 복구
	void restoreComment(int comment_id);

	List<CommentReportVO> getCommentReportList(int comment_id);

	void insertActionLog(
			@Param("comment_id") int comment_id,
			@Param("admin_id") String admin_id,
			@Param("action") String action,
			@Param("reason") String reason
	);

	List<AdminActionLogVO> getCommentActionLogs(int comment_id);
	
	// 특정 게시글 댓글 목록
	List<AdminCommentVO> getCommentsByPostId(int post_id);



}
