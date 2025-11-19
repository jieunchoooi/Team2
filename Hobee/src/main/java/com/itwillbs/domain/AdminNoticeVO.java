package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminNoticeVO {
	
	private int notice_id;        // 공지 번호 (PK)
    private String admin_id;      // 작성자(관리자)
    private String title;         // 공지 제목
    private String content;       // 공지 내용

    private int is_visible;       // 공개 여부 (1=공개, 0=숨김)
    private int view_count;       // 조회수

    private String created_at;    // 생성일
    private String updated_at;    // 수정일

}
