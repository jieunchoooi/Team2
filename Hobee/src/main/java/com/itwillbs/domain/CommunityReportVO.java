package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityReportVO {

	private int report_id;            // 신고 번호(PK)
    private Integer post_id;          // 신고된 게시글 ID (nullable)
    private Integer comment_id;       // 신고된 댓글 ID (nullable)
    private Integer user_num;       // 신고자
    private String reason;            // 신고 사유(사용자가 입력)
    private String created_at;        // 신고 날짜 (datetime)
    
    private int is_done;              // 처리 여부 (0/1)
    private String action;            // 처리 결과 ENUM: PENDING / ACCEPT / REJECT / DELETE / BLOCK
    private String admin_reason;      // 관리자 처리 사유
    private String done_at;           // 처리 날짜
}
