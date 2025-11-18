package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminCommentVO;

@Mapper
public interface AdminCommentMapper {
	
	// 댓글 전체 목록 조회
	// @return List<AdminCommentVO> 댓글 목록 리스트
	List<AdminCommentVO> getCommentList();
	
	// 댓글 상세 조회
    AdminCommentVO getCommentDetail(int comment_id);

	// 댓글 삭제 처리(숨김 처리)
	// @param comment_id 삭제할 댓글의 고유 ID
    void deleteComment(int comment_id);

}
