package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class AdminPostVO {
	
	
     // 📌 기본 게시글 정보 (사용자 작성)
   
	 private int post_id;     // 게시글 고유 번호 (Primary Key, AI)
	 private String title;    // 게시글 제목
	 private String content;  // 게시글 내용
	 private String author;   // 작성자 (사용자 ID 또는 닉네임)
	 private String tag;      // 게시글 태그 (ex. #잡담, #질문)

	 // 📌 관리자 기능에 필요한 정보
	 private int views;        // 조회수
	 private int is_visible;   // 게시글 공개 상태 (1 = 공개, 0 = 숨김)

	 // 📌 날짜 정보
	 private String created_at;   // 게시글 등록 날짜 (생성일)
	}


