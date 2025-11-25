package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReportActionLogVO {

    private int log_id;
    private int report_id;
    private String admin_id;
    private String action;
    private String reason;
    private String created_at;
}

