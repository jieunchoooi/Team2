package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class BoardCategoryVO {

    private int board_id;          // PK
    private String board_name;     // 게시판 이름
    private String board_desc;     // 게시판 설명
    private int is_active;         // 사용 여부 (1 = 사용)
    private String created_at;     // 생성일
    private int board_order;       // 정렬 우선순위

    private int allow_comment;     // 댓글 허용 여부
    private int allow_image;       // 이미지 업로드 허용 여부
    private int allow_file;        // 파일 업로드 허용 여부

    private String write_role;     // 작성 가능한 권한 (all/user/admin 등)
    private String banned_words;   // 금지 단어 목록 (콤마 구분 문자열)
    private int require_approval;  // 글 승인 필요 여부
}
