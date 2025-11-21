package com.itwillbs.mapper;

import java.util.List;

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

    // 검색된 총 개수
    int getSearchTotalCount(
            @Param("type") String type,
            @Param("keyword") String keyword);

    // 기존 기능
    List<AdminPostVO> getPostListPaging(@Param("start") int start, @Param("amount") int amount);

    int getTotalCount();

    AdminPostVO getPostDetail(int post_id);

    void togglePostVisible(int post_id);

    void deletePost(int post_id);

    List<AdminPostVO> getPostListPagingSorted(@Param("start") int start, 
            @Param("amount") int amount,
            @Param("sort") String sort);

    List<AdminPostVO> getSearchPostListSorted(@Param("start") int start, 
            @Param("amount") int amount,
            @Param("type") String type,
            @Param("keyword") String keyword,
            @Param("sort") String sort);

    void batchHide(@Param("ids") List<Integer> ids);

    void batchShow(@Param("ids") List<Integer> ids);

    void batchDelete(@Param("ids") List<Integer> ids);

	void updatePost(AdminPostVO vo);


}



