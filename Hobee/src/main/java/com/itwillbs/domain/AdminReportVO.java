package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminReportVO {

    private int report_id;

    private Integer post_id;
    private Integer comment_id;

    // reporter_id는 community_report 기준 → int
    private Integer reporter_id;

    private String reason;
    private String created_at;
    private int is_done;

    private String done_at;
    private String done_reason;

    // ===== JOIN 컬럼 =====
    private String post_title;      // community_content.title
    private String post_content;    // community_content.content
    private String comment_content; // comment.content
}