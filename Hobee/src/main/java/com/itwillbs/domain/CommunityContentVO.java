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

    private int category_id;       // community_category FK
    private Integer category_main_num;  // category_main FK (nullable)
    private Integer lecture_num;

    private int views;
    private int is_visible;
    private int is_deleted;

    private Timestamp created_at;
    private Timestamp updated_at;
    
   
    // JOIN 필드
    private String user_name;
    private String category_name;        // 말머리(community_category)
    private String category_main_name;   // 메인 카테고리(category_main)
    private String lecture_title;
    
    private String summary;              // 요약문
    private String user_file;   // 작성자 썸네일
    
    private Integer comment_count;
    private Integer like_count;
    private Integer dislike_count;
}
