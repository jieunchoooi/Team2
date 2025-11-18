package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminReportVO {
	
	private int report_id;      		// 신고 번호
    private Integer post_id;   			// 신고된 게시글 ID (null 가능)
    private Integer comment_id;			// 신고된 댓글 ID (null 가능)
    private String reporter_id;			// 신고자
    private String reason;     			// 신고 사유
    private String created_at; 			// 신고 날짜
    private int is_done;       			// 처리 여부

    // JOIN용
    private String post_title;     		// 게시글 제목
    private String comment_content;		// 댓글 내용

}
