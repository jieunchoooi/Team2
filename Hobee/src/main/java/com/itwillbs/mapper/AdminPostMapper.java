package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminPostVO;

@Mapper
public interface AdminPostMapper {
	
	// 게시글 목록
	List<AdminPostVO> getPostList();
	
	// 게시글 상세
    AdminPostVO getPostDetail(int post_id);

    //공개/숨김
    void togglePostVisible(int post_id);

    // 삭제
    void deletePost(int post_id);
}


