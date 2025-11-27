package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.CommunityContentVO;

public interface CommunityContentMapper {

    // 목록 조회 (카테고리 필터 + 페이징)
    List<CommunityContentVO> getCommunityList(
            @Param("category_main_num") Integer categoryMainNum,
            @Param("offset") int offset,
            @Param("limit") int limit);

    // 전체 글 개수 (페이징용)
    int getCommunityCount(@Param("category_main_num") Integer categoryMainNum);
}
