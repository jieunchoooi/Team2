package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunitySearchCriteria {

    // 🔸 페이징
    private int page;     // 현재 페이지
    private int amount;   // 한 페이지 글 수
    private int offset;   // LIMIT 시작점

    // 🔸 필터
    private Integer board_id;         // 말머리 FK (community_category)
    private Integer category_main_num;   // 메인 카테고리 FK (category_main)

    // 🔸 검색
    private String searchType;   // title, titleContent, writer, comment
    private String keyword;

    // 🔸 정렬
    private String sort;    // latest, views, likes, comments

    // 🔸 기간 필터
    private String period;  // all, today, week, month

    // 🔸 기본 생성자 (기본값 지정)
    public CommunitySearchCriteria() {
        this.page = 1;
        this.amount = 10;
        this.sort = "latest";
        this.period = "all";
    }

    public int getOffset() {
        return (page - 1) * amount;
    }
}
