package com.itwillbs.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityDetailDTO {

    /** 현재 게시글 */
    private CommunityContentVO post;

    /** 댓글 목록 */
    private List<CommunityCommentVO> comments;

    /** 🔥 이전 글 3개 (rn 기준 현재 글보다 작은 것들) */
    private List<CommunityContentVO> prev3;

    /** 🔥 현재 글을 포함한 객체 (중앙 강조용) */
    private CommunityContentVO current;

    /** 🔥 다음 글 3개 (rn 기준 현재 글보다 큰 것들) */
    private List<CommunityContentVO> next3;

}
