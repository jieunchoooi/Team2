package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.mapper.AdminPostMapper;

@Service
public class AdminPostService {

    @Inject
    private AdminPostMapper adminPostMapper;

    /* ============================================================
       📌 게시글 상세
    ============================================================ */
    public AdminPostVO getPostDetail(int post_id) {
        return adminPostMapper.getPostDetail(post_id);
    }

    /* ============================================================
       📌 전체 게시글 개수
    ============================================================ */
    public int getTotalCount() {
        return adminPostMapper.getTotalCount();
    }

    /* ============================================================
       📌 게시글 목록(페이징 + 정렬)
    ============================================================ */
    public List<AdminPostVO> getPostListPaging(int pageNum, int amount, String sort) {

        int start = (pageNum - 1) * amount;

        return adminPostMapper.getPostListPagingSorted(start, amount, sort);
    }

    /* ============================================================
       📌 검색된 게시글 개수
    ============================================================ */
    public int getSearchTotalCount(String type, String keyword) {
        return adminPostMapper.getSearchTotalCount(type, keyword);
    }

    /* ============================================================
       📌 검색 + 정렬 + 페이징 목록
    ============================================================ */
    public List<AdminPostVO> getSearchPostList(int pageNum, int amount, String type, String keyword, String sort) {

        int start = (pageNum - 1) * amount;

        return adminPostMapper.getSearchPostListSorted(start, amount, type, keyword, sort);
    }

    /* ============================================================
       📌 게시글 공개/숨김 토글
    ============================================================ */
    public void togglePostVisible(int post_id) {
        adminPostMapper.togglePostVisible(post_id);
    }

    /* ============================================================
       📌 Soft Delete — 게시글 삭제 (is_deleted = 1)
    ============================================================ */
    public void deletePost(int post_id) {
        adminPostMapper.deletePost(post_id);
    }

    /* ============================================================
       📌 Soft Delete 된 게시글 목록
    ============================================================ */
    public List<AdminPostVO> getDeletedPostList() {
        return adminPostMapper.getDeletedPostList();
    }

    /* ============================================================
       📌 Soft Delete 게시글 복구
    ============================================================ */
    public void restorePost(int post_id) {
        adminPostMapper.restorePost(post_id);
    }

    /* ============================================================
       📌 일괄 숨김
    ============================================================ */
    public void batchHide(List<Integer> postIds) {
        adminPostMapper.batchHide(postIds);
    }

    /* ============================================================
       📌 일괄 표시
    ============================================================ */
    public void batchShow(List<Integer> postIds) {
        adminPostMapper.batchShow(postIds);
    }

    /* ============================================================
       📌 일괄 삭제 (Soft Delete)
    ============================================================ */
    public void batchDelete(List<Integer> postIds) {
        adminPostMapper.batchDelete(postIds);
    }


    /* ============================================================
       📌 조회수 TOP10
    ============================================================ */
    public List<Map<String, Object>> getTopViewPosts() {
        return adminPostMapper.getTopViewPosts();
    }

    /* ============================================================
       📌 댓글 수 TOP10
    ============================================================ */
    public List<Map<String, Object>> getTopCommentPosts() {
        return adminPostMapper.getTopCommentPosts();
    }

}
