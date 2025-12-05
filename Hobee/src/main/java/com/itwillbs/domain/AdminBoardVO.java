package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminBoardVO {

    private int board_id;             // 게시판 고유 번호 (PK)
    private String board_name;        // 게시판 이름 (필수)
    private String board_desc;        // 게시판 설명
    private int is_active;            // 게시판 사용 여부 :  1 : 게시판 사용 (노출) / 0 : 게시판 숨김 (비노출)
    private String created_at;        // 생성 날짜
    private int board_order;

    private int post_count;           // 전체 글 수

    // 필요시 통계도 포함
    private int post_count_month;     // 이번달 글 수
    private int post_count_visible;   // 삭제되지 않은 글 수
    private int report_count;         // 신고된 게시글 수

    private int allow_comment;        // 댓글 허용
    private int allow_image;          // 이미지 첨부 허용
    private int allow_file;           // 파일 업로드 허용
    private String write_role;        // 글쓰기 권한 (all, member, teacher, admin)
    private String banned_words;      // 금지 단어
    private int require_approval;     // 승인 필요 여부

}
