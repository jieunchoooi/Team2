package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.CommunityCommentVO;
import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.CommunitySearchCriteria;
import com.itwillbs.domain.ReactionCountVO;

/**
 * CommunityContentMapper
 * ------------------------------------
 * - 커뮤니티 게시글 목록/검색/카테고리/인기글
 * - 좋아요/싫어요(리액션) 관련 Mapper 인터페이스
 */
public interface CommunityContentMapper {

    // ============================================
    // 📌 기존 전체 글 개수 (단순 카운트, category_main_num 기준)
    // ============================================
    int getCommunityCount(@Param("category_main_num") Integer categoryMainNum);

 // 🔥 실시간 HOT TOPIC 가져오기
    public List<CommunityContentVO> getHotTopicList();

    // ============================================
    // 📌 인기글 Top N
    // ============================================
    List<CommunityContentVO> getPopularPosts();


    // ============================================
    // 📌 좋아요/싫어요(리액션)
    // ============================================
    Integer getUserPostReaction(
            @Param("post_id") int post_id,
            @Param("user_num") int user_num
    );

    void insertPostReaction(
            @Param("post_id") int post_id,
            @Param("user_num") int user_num,
            @Param("is_like") int is_like
    );

    void updatePostReaction(
            @Param("post_id") int post_id,
            @Param("user_num") int user_num,
            @Param("is_like") int is_like
    );

    void deletePostReaction(
            @Param("post_id") int post_id,
            @Param("user_num") int user_num
    );

    ReactionCountVO getPostReactionCount(@Param("post_id") int post_id);



    // ============================================
    // 📌 카테고리 메인 리스트
    // ============================================
    List<CommunityContentVO> getCategoryMainList();


    // ============================================
    // 📌 1) 통합 목록 조회 (/community/list)
    //     - 필터 + 정렬 + 기간 + 페이징 + 검색까지 모두 포함
    //     - 기존 Map 제거 → Criteria 통합
    // ============================================
    List<CommunityContentVO> getCommunityList(CommunitySearchCriteria cri);

    // 목록 총 개수
    int getTotalCount(CommunitySearchCriteria cri);


    // ============================================
    // 📌 2) 검색 전용 (과거 호환 위해 유지)
    //     - 내부는 동일하게 Criteria 사용
    // ============================================
   
    
    //여기부터 상세 페이지 조회!!
    /** 게시글 상세 */
    CommunityContentVO getPostDetail(@Param("post_id") int post_id);

    /** 게시글 조회수 증가 */
    int updateViewCount(@Param("post_id") int post_id);

    /** 댓글 조회 (좋아요 상태 & count 포함) */
    List<CommunityCommentVO> getCommentsByPostId(
            @Param("post_id") int post_id,
            @Param("user_num") Integer user_num);

    /** 댓글 좋아요 토글(insert/update/delete)용 */
    int insertCommentLike(@Param("comment_id") int comment_id,
                          @Param("user_num") int user_num,
                          @Param("is_like") int is_like);

    int updateCommentLike(@Param("comment_id") int comment_id,
                          @Param("user_num") int user_num,
                          @Param("is_like") int is_like);

    int deleteCommentLike(@Param("comment_id") int comment_id,
                          @Param("user_num") int user_num);

    /** 댓글 좋아요/싫어요 count 조회 */
    int getCommentLikeCount(@Param("comment_id") int comment_id);
    int getCommentDislikeCount(@Param("comment_id") int comment_id);

}
