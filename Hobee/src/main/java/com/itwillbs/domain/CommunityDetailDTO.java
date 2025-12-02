package com.itwillbs.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityDetailDTO {
    private CommunityContentVO post;
    private List<CommunityCommentVO> comments;
}