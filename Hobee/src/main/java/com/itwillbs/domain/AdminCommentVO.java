package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminCommentVO {

    private int comment_id;
    private int post_id;
    private int user_num;       // ✔ 기존 user_id → user_num 로 변경
    private String content;
    private String created_at;
    private String updated_at;
    private int is_deleted;
    private int report_count;

    // JOIN 용 필드
    private String user_name;   // ✔ user 테이블에서 JOIN
    private String post_title;  // ✔ 게시글 제목 JOIN
}
