package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.AdminPostVO;

@Mapper
public interface AdminPostMapper {

    // 페이징 + 검색 목록
    List<AdminPostVO> getSearchPostList(
            @Param("start") int start,
            @Param("amount") int amount,
            @Param("type") String type,
            @Param("keyword") String keyword);

    int getSearchTotalCount(
            @Param("type") String type,
            @Param("keyword") String keyword);

    // 기존 목록
    List<AdminPostVO> getPostListPaging(
            @Param("start") int start,
            @Param("amount") int amount);

    int getTotalCount();

    AdminPostVO getPostDetail(int post_id);

    void togglePostVisible(int post_id);

    // ❗ 이름 수정 (softDelete → deletePost)
    void deletePost(int post_id);

    void restorePost(int post_id);

    List<AdminPostVO> getPostListPagingSorted(
            @Param("start") int start,
            @Param("amount") int amount,
            @Param("sort") String sort);

    List<AdminPostVO> getSearchPostListSorted(
            @Param("start") int start,
            @Param("amount") int amount,
            @Param("type") String type,
            @Param("keyword") String keyword,
            @Param("sort") String sort);

    void batchHide(@Param("postIds") List<Integer> postIds);
    void batchShow(@Param("postIds") List<Integer> postIds);
    void batchDelete(@Param("postIds") List<Integer> postIds);


    List<Map<String, Object>> getTopViewPosts();

    List<Map<String, Object>> getTopCommentPosts();

    List<AdminPostVO> getDeletedPostList();

    List<String> getAutoComplete(@Param("keyword") String keyword);

	List<Map<String, Object>> getWeeklyPostCount();

	List<Map<String, Object>> getPostsByCategory();

}
