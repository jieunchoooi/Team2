package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CommunityReportVO;
import com.itwillbs.mapper.CommunityMapper;

@Service
public class ReportService {

    @Autowired
    private CommunityMapper communityMapper;

    // 📌 신고 저장
    public boolean insertReport(CommunityReportVO vo) {
        return communityMapper.insertReport(vo) == 1;
    }

    // 📌 게시글 신고 여부 체크
    public boolean alreadyReportedPost(int userNum, int postId) {
        return communityMapper.checkAlreadyReported(userNum, postId) > 0;
    }

    // 📌 댓글 신고 여부 체크
    public boolean alreadyReportedComment(int userNum, int commentId) {
        return communityMapper.checkAlreadyReportedComment(userNum, commentId) > 0;
    }
}
