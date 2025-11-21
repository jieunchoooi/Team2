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

    private int startPage;  // 시작 페이지 번호
    private int endPage;    // 끝 페이지 번호
    private boolean prev;   // 이전 버튼
    private boolean next;   // 다음 버튼
    private int total;      // 전체 게시글 수
    
    private String sort;    // 🔥 정렬 옵션 (recent/views/reply/visible)
    
    // ⭐ 기존 생성자 (정렬 없는 기본)
    public PageDTO(int page, int amount, int total) {
        this.page = page;
        this.amount = amount;
        this.total = total;

        this.endPage = (int)Math.ceil(page / 10.0) * 10;
        this.startPage = this.endPage - 9;

        int realEnd = (int)Math.ceil(total / (double)amount);

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }

    // ⭐⭐⭐ 정렬 옵션 포함한 생성자 (새로 추가!)
    public PageDTO(int page, int amount, int total, String sort) {
        this(page, amount, total);   // 기존 계산 로직 재사용
        this.sort = sort;            // 정렬 값 저장
    }
}

