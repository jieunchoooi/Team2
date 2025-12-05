package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 커뮤니티 말머리 카테고리 VO
 * - community_category 테이블 매핑
 */
@Getter
@Setter
@ToString
public class CommunityCategoryVO {

    // PK (말머리 ID)
    private int category_id;

    // 카테고리 Key (예: notice, qna, free 등)
    private String category_key;

    // 카테고리 이름 (예: 공지, Q&A, 잡담 등)
    private String category_name;

    // 정렬 순서
    private int sort_order;
    
    
    

}
