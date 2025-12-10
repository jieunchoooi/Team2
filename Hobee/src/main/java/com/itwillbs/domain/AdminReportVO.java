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

    private Integer user_num;   // ← DB 컬럼 그대로 사용

    private String reason;
    private String created_at;
    private int is_done;

    private String action;     // enum(PENDING, ACCEPT, REJECT …)
    private String admin_reason;
    private String done_at;

    // JOIN
    private String post_title;
    private String post_content;
    private String comment_content;

    private String user_id;
    private String user_name;
}
