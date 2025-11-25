package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminPostVO {

    // 📌 기본 게시글 정보
    private int post_id;       // 게시글 번호 (PK)
    private int board_id;      // 게시판 ID
    private String title;      // 제목
    private String content;    // 내용
    private String author;     // 작성자
    private String tag;        // 태그

    // 📌 관리자용 정보
    private int views;         // 조회수
    private int is_visible;    // 공개(1) / 숨김(0)

    // 📌 날짜 정보
    private String created_at; // 생성일
    private String updated_at; // ★ 수정일(추가됨)
    
    private int is_deleted;   // 0 = 정상, 1 = 삭제됨


    // 📌 JOIN용
    private String board_name; // 게시판 이름
}


