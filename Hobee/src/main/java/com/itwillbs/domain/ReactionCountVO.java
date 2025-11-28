package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReactionCountVO {

    /** 좋아요 개수 */
    private int like_count;

    /** 싫어요 개수 */
    private int dislike_count;
}
