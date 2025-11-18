package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminCommentVO {
	
	// 기본 댓글 정보
	private int comment_id;         // 댓글 고유 번호 (PRIMARY KEY, AUTO_INCREMENT)
    private int post_id;     		// 이 댓글이 달린 게시글 번호 (community_content.post_id)
    private String user_id; 		// 댓글 작성자 ID (user_id)
    private String content;  		// 댓글 본문 내용
    private String created_at;      // 댓글 작성 날짜 (자동 기록)
    
    // 관리자 기능 관련
    private int is_deleted; 		// 댓글 삭제 여부 (0 = 정상, 1 = 관리자 삭제 처리)
    private int report_count; 		// 신고 횟수 (신고 기능 대비 / 기본값 0)

    
    // 게시글 제목을 JOIN 해서 관리자 화면에 보여줄 용도
    private String post_title;

}
