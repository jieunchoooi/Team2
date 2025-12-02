package com.itwillbs.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Community 댓글 VO
 * -----------------------------
 * 기본 컬럼: community_comment 테이블 매핑
 * 조회용 컬럼: JOIN 및 통계용 (DB 컬럼 X)
 */
@Getter
@Setter
@ToString
public class CommunityCommentVO {

	// ===========================
    // 📌 기본 테이블 필드
    // ===========================
    private int comment_id;
    private int post_id;
    private int user_num;
    private Integer parent_id;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
    private int is_deleted;
    private int report_count;

    // ===========================
    // 📌 JOIN: 작성자(user) 정보
    // ===========================
    private String user_name;          // 작성자 이름
    private String user_file;          // 프로필 이미지
    private String user_grade;         // 사용할 수도 있으니 넣어둠 (OPTION)

    // ===========================
    // 📌 댓글 좋아요/싫어요 집계
    // ===========================
    private Integer like_count;        // 좋아요 수
    private Integer dislike_count;     // 싫어요 수

    // ===========================
    // 📌 로그인 유저의 반응 상태
    // 1 = 좋아요, 0 = 싫어요, null = 반응 없음
    // ===========================
    private Integer user_reaction;

    // ===========================
    // 📌 대댓글 리스트 (재귀 구조)
    // ===========================
    private List<CommunityCommentVO> replies;
}
