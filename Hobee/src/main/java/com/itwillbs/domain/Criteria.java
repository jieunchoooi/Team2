package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

    private int pageNum;   // 현재 페이지 번호
    private int amount;    // 한 페이지당 글 수

    // 🔥 검색용 필드 추가!!
    private String type;      // 검색 종류
    private String keyword;   // 검색어

    private String status; // normal / deleted / all


    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public int getStartRow() {
        return (pageNum - 1) * amount;
    }
}
