package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminFaqVO {
	
	private int faq_id;        // FAQ 번호 (PK)
    private String category;   // 카테고리
    private String question;   // 질문
    private String answer;     // 답변
    private int is_visible;    // 공개 여부 (1=공개, 0=숨김)
    private String created_at; // 등록일
    private String updated_at;
    private int faq_order;

}
