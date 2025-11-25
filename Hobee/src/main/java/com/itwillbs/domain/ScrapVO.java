package com.itwillbs.domain;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScrapVO {

    private int scrap_id;
    private int user_num;
    private int lecture_num;
    private Timestamp created_at;

    // ========================================
    // 조회용 필드 (JOIN: lecture 테이블)
    // ========================================
    private String lecture_title;
    private String lecture_author;
    private int lecture_price;
    private String lecture_img;   // DB도 소문자면 이 이름 그대로!
}
