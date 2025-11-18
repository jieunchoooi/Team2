package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminCommentVO;
import com.itwillbs.mapper.AdminCommentMapper;

@Service
public class AdminCommentService {
	
	@Inject
	private AdminCommentMapper adminCommentMapper;
	
	public List<AdminCommentVO> getCommentList() {
		System.out.println("AdminCommentService : getCommentList() 실행");
        return adminCommentMapper.getCommentList();

	}
	
    public AdminCommentVO getCommentDetail(int comment_id) {
        return adminCommentMapper.getCommentDetail(comment_id);
    }
	 public void deleteComment(int comment_id) {
		 System.out.println("AdminCommentService : deleteComment() 실행");
		 adminCommentMapper.deleteComment(comment_id);
    }
}
