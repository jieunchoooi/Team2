package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminBoardVO;
import com.itwillbs.domain.AdminPostVO;

@Mapper
public interface AdminBoardMapper {

    // 게시판 전체 목록 조회
    List<AdminBoardVO> getBoardList();

    // 게시판 단일 정보 조회
    AdminBoardVO getBoard(int board_id);

    // 게시판 추가(INSERT)
    void insertBoard(AdminBoardVO vo);

    // 게시판 수정(UPDATE)
    void updateBoard(AdminBoardVO vo);

    // 게시판 삭제(DELETE)
    void deleteBoard(int board_id);

    // 게시판 숨김 처리 (is_active = 0)
    void disableBoard(int board_id);

    // 게시판 숨김 해제 (is_active = 1)
    void enableBoard(int board_id);

    // 게시판 순서 변경
    void updateBoardOrder(AdminBoardVO vo);

    // 게시판 상세 정보 + 통계 조회
    AdminBoardVO getBoardDetail(int board_id);

    // 최근 게시글 5개 조회
    List<AdminPostVO> getRecentPosts(int board_id);

    // 최근 7일 게시글 통계
    List<Map<String, Object>> getWeeklyPostStats(int board_id);

    // 조회수 TOP5 조회
    List<AdminPostVO> getTopViewPosts(int board_id);

    // 신고 많은 게시글 TOP5 조회
    List<AdminPostVO> getTopReportPosts(int board_id);

    // 댓글 허용 여부 변경
    void updateAllowComment(Map<String, Object> param);

    // 이미지 업로드 허용 여부 변경
    void updateAllowImage(Map<String, Object> param);

    // 파일 업로드 허용 여부 변경
    void updateAllowFile(Map<String, Object> param);

    // 승인 필요 여부 변경
    void updateRequireApproval(Map<String, Object> param);

    // ✔ 사용자에게 노출될 활성 머리말 목록
    List<AdminBoardVO> getActiveBoardList();
    
    
}
