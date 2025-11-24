package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

    private int page;       // 현재 페이지
    private int amount;     // 한 페이지당 게시글 수

    private int startPage;  // 화면에서 보이는 시작 번호
    private int endPage;    // 화면에서 보이는 끝 번호
    private boolean prev;
    private boolean next;
    private int total;

    private String sort;

    // ⭐ LIMIT 시작 index (MyBatis에서 사용)
    public int getStart() {
        return (page - 1) * amount;
    }

    public PageDTO(int page, int amount, int total) {
        this.page = page;
        this.amount = amount;
        this.total = total;

        this.endPage = (int)Math.ceil(page / 10.0) * 10;
        this.startPage = this.endPage - 9;

        int realEnd = (int)Math.ceil(total / (double)amount);

        if (endPage > realEnd) {
            endPage = realEnd;
        }

        this.prev = startPage > 1;
        this.next = endPage < realEnd;
    }

    public PageDTO(int page, int amount, int total, String sort) {
        this(page, amount, total);
        this.sort = sort;
    }
}