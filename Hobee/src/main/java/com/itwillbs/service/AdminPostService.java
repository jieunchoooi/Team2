package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.mapper.AdminPostMapper;

@Service   // ⭐ Spring 서비스 빈 등록
public class AdminPostService {
	
	@Inject
	private AdminPostMapper adminPostMapper;
	
	
	 public List<AdminPostVO> getPostListPaging(int page, int amount) {
		System.out.println("AdminPostService: getPostListPaging() 실행");
		int start = (page - 1) * amount;
        return adminPostMapper.getPostListPaging(start, amount);
	}
	 
	public int getTotalCount() {
		System.out.println("AdminPostService: getTotalCount() 실행");
	        return adminPostMapper.getTotalCount();
	}
	
	public AdminPostVO getPostDetail(int post_id) {
		System.out.println("AdminPostService: getPostDetail() 실행");
		return adminPostMapper.getPostDetail(post_id);
	}
	
	public void togglePostVisible(int post_id) {
		System.out.println("AdminPostService: togglePostVisible() 실행");
		adminPostMapper.togglePostVisible(post_id);
	}
	
	public void deletePost(int post_id) {
		System.out.println("AdminPostService: deletePost() 실행");
		adminPostMapper.deletePost(post_id);
	}
	
	public List<AdminPostVO> getSearchPostList(int pageNum, int amount, String type, String keyword) {
		System.out.println("AdminPostService: getSearchPostList() 실행");
	    int start = (pageNum - 1) * amount;
	    return adminPostMapper.getSearchPostList(start, amount, type, keyword);
	}

	public int getSearchTotalCount(String type, String keyword) {
		System.out.println("AdminPostService: getSearchTotalCount() 실행");
		return adminPostMapper.getSearchTotalCount(type, keyword);
	}

	public List<AdminPostVO> getPostListPaging(int pageNum, int amount, String sort) {
		System.out.println("AdminPostService: getPostListPaging() 실행");
		int start = (pageNum - 1) * amount;
        return adminPostMapper.getPostListPagingSorted(start, amount, sort);
    }

	public List<AdminPostVO> getSearchPostList(int pageNum, int amount, String type, String keyword, String sort) {
		System.out.println("AdminPostService: getSearchPostList() 실행");
	     int start = (pageNum - 1) * amount;
	        return adminPostMapper.getSearchPostListSorted(start, amount, type, keyword, sort);
	}

	public void batchHide(List<Integer> ids) {
		System.out.println("AdminPostService: batchHidet() 실행");
			adminPostMapper.batchHide(ids);
	}

	public void batchShow(List<Integer> ids) {
		System.out.println("AdminPostService: batchShow() 실행");
		adminPostMapper.batchShow(ids);
	}

	public void batchDelete(List<Integer> ids) {
		System.out.println("AdminPostService: batchDelete() 실행");
		adminPostMapper.batchDelete(ids);
	}

	public void updatePost(AdminPostVO vo) {
		System.out.println("AdminPostService: updatePost() 실행");
		adminPostMapper.updatePost(vo);
	}
	
	public List<Map<String, Object>> getTopViewPosts() {
	    return adminPostMapper.getTopViewPosts();
	}

	public List<Map<String, Object>> getTopCommentPosts() {
	    return adminPostMapper.getTopCommentPosts();
	}


}
