package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminPostVO {

    // 기본 게시글 정보
    private int post_id;          // 게시글 번호
    private int board_id;         // 게시판 ID
    private String title;         // 제목
    private String content;       // 내용
    private String author;        // 작성자명
    private int user_num;         // ⭐ 작성자 번호 (JSP에서 필요한 필드)
    private String tag;           // 태그
    private int views;            // 조회수
    private int is_visible;       // 공개/숨김 상태

    // 날짜 정보
    private String created_at;    // 생성일
    private String updated_at;    // 수정일

    // 상태 정보
    private int is_deleted;       // 삭제 여부 (0 정상 / 1 삭제됨)

    // JOIN 된 컬럼
    private String board_name;    // 게시판 이름
    
    private int report_count;     // ⭐ 신고 통계용
}
