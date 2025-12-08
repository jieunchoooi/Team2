package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.*;
import org.apache.ibatis.annotations.Param;

/**
 * CommunityContentMapper
 * ------------------------------------
 * - 커뮤니티 게시글 목록/검색/카테고리/인기글
 * - 좋아요/싫어요(리액션) 관련 Mapper 인터페이스
 */
public interface CommunityMapper {

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
	// 📌 카테고리 메인 리스트
	// ============================================
	List<CommunityContentVO> getCategoryMainList();



	//리턴 변수로 위랑 같이 ccVO 쓰기
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
	/** 게시글 상세 조회 (좋아요 여부 포함) */
	CommunityContentVO getPostDetailWithLike(
			@Param("post_id") int postId,
			@Param("user_num") Integer userNum);
	/** 게시글 조회수 증가 */
	int updateViewCount(@Param("post_id") int post_id);

	/** 댓글 조회 (좋아요 상태 & count 포함) */
	List<CommunityCommentVO> getCommentsByPostId(
			@Param("post_id") int post_id,
			@Param("user_num") Integer user_num);




	//상세페이지내 목록 조회(필터링 유지)
	List<CommunityContentVO> getPrevNextPosts(
			@Param("post_id") int postId,
			@Param("cri") CommunitySearchCriteria cri
	);




//좋아요 관련
// =====================================================
// 📌 게시글 좋아요 (좋아요 단일)
// =====================================================

	/** 게시글 좋아요 추가 (upsert) */
	int upsertPostLike(@Param("post_id") int postId,
					   @Param("user_num") int userNum);

	/** 게시글 좋아요 취소 */
	int deletePostLike(@Param("post_id") int postId,
					   @Param("user_num") int userNum);



// =====================================================
// 📌 댓글 좋아요 (좋아요 단일)
// =====================================================

	/** 댓글 좋아요 추가 (upsert) */
	int upsertCommentLike(@Param("comment_id") int commentId,
						  @Param("user_num") int userNum);

	/** 댓글 좋아요 취소 */
	int deleteCommentLike(@Param("comment_id") int commentId,
						  @Param("user_num") int userNum);




	/** 게시글 작성 */
	void insertPost(CommunityContentVO communityContentVO);

	/** 카테고리 목록 */
	List<CommunityCategoryVO> getCategoryList();

	/** 메인 카테고리 목록 */
	List<Category_mainVO> getMainCategoryList();



	// 게시글 단건 조회
	CommunityContentVO getPostById(int post_id);

	// 게시글 수정
	void updatePost(CommunityContentVO communityContentVO);

	// 게시글 삭제 (is_deleted = 1)
	void deletePost(int post_id);


	int insertComment(CommunityCommentVO vo);

	int updateComment(@Param("comment_id") int commentId,
					  @Param("user_num") int userNum,
					  @Param("content") String content);

	int deleteComment(@Param("comment_id") int commentId,
					  @Param("user_num") int userNum);


	// 📌 신고 여부 체크 (게시글)
	int checkAlreadyReported(@Param("user_num") int user_num,
							 @Param("post_id") int post_id);


	// 📌 신고 여부 체크 (댓글)
	int checkAlreadyReportedComment(@Param("user_num") int user_num,
									@Param("comment_id") int comment_id);


	int insertReport(CommunityReportVO vo);
}