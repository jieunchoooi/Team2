package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentReportVO {

    private int report_id;
    private int comment_id;
    private String reporter_id;
    private String reason;
    private String created_at;
}
