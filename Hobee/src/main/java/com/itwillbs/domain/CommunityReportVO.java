package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityReportVO {

    private int report_id;       // PK
    private int reporter_id;     // 신고자(user_num)

    private Integer post_id;     // 게시글 신고면 값 존재
    private Integer comment_id;  // 댓글 신고면 값 존재

    private String reason;       // 신고 사유
    private String created_at;   // 신고 일시

    // 🔽 관리자 처리용 (초기에는 기본값)
    private int is_done;         // 기본 0 (미처리)
    private String done_at;      // 처리 일시
    private String done_reason;  // 처리 사유
}
