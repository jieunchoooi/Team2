package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.CommunitySearchCriteria;
import com.itwillbs.domain.ReactionCountVO;
import com.itwillbs.mapper.CommunityContentMapper;

/**
 * CommunityService
 * ------------------------------------
 * - Controller와 Mapper 사이의 비즈니스 레이어
 * - 커뮤니티 목록/검색/카테고리/인기글/리액션 처리
 */
@Service
public class CommunityService {

    @Autowired
    private CommunityContentMapper communityContentMapper;


    // ============================================
    // 📌 예전 전체 카운트 (단순 category_main_num 기준)
    //    - 기존 코드와의 호환을 위해 유지
    // ============================================
    public int getCommunityCount(Integer categoryMainNum) {
        return communityContentMapper.getCommunityCount(categoryMainNum);
    }


    // ============================================
    // 📌 인기글 Top N
    // ============================================
    public List<CommunityContentVO> getPopularPosts() {
        return communityContentMapper.getPopularPosts();
    }


    // ============================================
    // 📌 좋아요/싫어요(리액션)
    // ============================================
    public Integer getUserPostReaction(int post_id, int user_num) {
        return communityContentMapper.getUserPostReaction(post_id, user_num);
    }

    public ReactionCountVO getPostReactionCount(int post_id) {
        return communityContentMapper.getPostReactionCount(post_id);
    }

    public String togglePostReaction(int post_id, int user_num, int is_like) {

        Integer current = communityContentMapper.getUserPostReaction(post_id, user_num);

        // 1) 반응 없음 → INSERT
        if (current == null) {
            communityContentMapper.insertPostReaction(post_id, user_num, is_like);
            return is_like == 1 ? "liked" : "disliked";
        }

        // 2) 동일 반응 → 삭제
        if (current == is_like) {
            communityContentMapper.deletePostReaction(post_id, user_num);
            return "removed";
        }

        // 3) 반대 반응 → UPDATE
        communityContentMapper.updatePostReaction(post_id, user_num, is_like);
        return is_like == 1 ? "liked" : "disliked";
    }


    // ============================================
    // 📌 카테고리 메인 리스트 (Chip 버튼용)
    // ============================================
    public List<CommunityContentVO> getCategoryMainList() {
        return communityContentMapper.getCategoryMainList();
    }


    // ============================================
    // 📌 1) 통합 목록 조회 (검색 + 필터 + 정렬 + 기간 + 페이징)
    //     - CommunitySearchCriteria 기반으로 통합
    // ============================================
    public List<CommunityContentVO> getCommunityList(CommunitySearchCriteria cri) {
        return communityContentMapper.getCommunityList(cri);
    }

    public int getTotalCount(CommunitySearchCriteria cri) {
        return communityContentMapper.getTotalCount(cri);
    }


    // ============================================
    // 📌 2) 검색 전용 — 예전 코드 호환 위해 유지하지만 내부는 동일 방식
    //     (굳이 분리할 필요 없지만 네 기존 구조 유지 목적)
    // ============================================
    public List<CommunityContentVO> searchCommunityList(CommunitySearchCriteria cri) {
        return communityContentMapper.searchCommunityList(cri);
    }

    public int getSearchCommunityListCount(CommunitySearchCriteria cri) {
        return communityContentMapper.getSearchCommunityListCount(cri);
    }

}
