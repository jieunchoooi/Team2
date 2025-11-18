package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.mapper.AdminPostMapper;

@Service   // ⭐ Spring 서비스 빈 등록
public class AdminPostService {
	
	@Inject
	private AdminPostMapper adminPostMapper;
	
	 /* ===============================================================
    📌 1. 게시글 전체 조회
    - 관리자 게시판 목록에서 사용
    - community_content 테이블 전체 글 불러오기
    =============================================================== */
	public List<AdminPostVO> getPostList() {
		System.out.println("AdminPostService: getPostList() 실행");
        return adminPostMapper.getPostList();
	}
	 /* ===============================================================
    📌 2. 게시글 상세 조회
    - 관리자 상세 페이지(adminPostDetail.jsp)에서 사용
    - post_id로 한 게시글만 조회
    =============================================================== */
	public AdminPostVO getPostDetail(int post_id) {
		System.out.println("AdminPostService: getPostDetail() 실행");
		return adminPostMapper.getPostDetail(post_id);
	}
	/* ===============================================================
    📌 3. 게시글 공개/숨김 토글
    - is_visible이 1이면 0으로, 0이면 1로 변경
    - 관리자 게시글 관리에서 노출 제어 기능
    =============================================================== */
	public void togglePostVisible(int post_id) {
		System.out.println("AdminPostService: togglePostVisible() 실행");
		adminPostMapper.togglePostVisible(post_id);
	}
	 /* ===============================================================
    📌 4. 게시글 삭제
    - 관리자 기능: 글을 DB에서 완전 삭제
    - 사용자 글도 함께 사라짐
    =============================================================== */
	public void deletePost(int post_id) {
		System.out.println("AdminPostService: deletePost() 실행");
		adminPostMapper.deletePost(post_id);
	}

}
