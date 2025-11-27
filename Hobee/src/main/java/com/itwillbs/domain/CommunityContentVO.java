package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityContentVO {

    private int post_id;
    private String title;
    private String content;

    private int user_num;
    private String tag;

    private int views;
    private int is_visible;
    private int is_deleted;

    private int board_id;
    private int category_main_num;
    private Integer lecture_num;

    private Timestamp created_at;
    private Timestamp updated_at;

    // 🔥 JOIN 조회용 필드
    private String user_name;             // user.nickname
    private String category_main_name;   // category_main.category_main_name
    private String lecture_title;        // lecture.title
}
