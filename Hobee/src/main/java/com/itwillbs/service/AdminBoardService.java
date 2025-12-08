package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminBoardVO;
import com.itwillbs.domain.AdminPostVO;
import com.itwillbs.mapper.AdminBoardMapper;

@Service
public class AdminBoardService {

    @Inject
    private AdminBoardMapper adminBoardMapper;

    // 📌 게시판 전체 목록 조회
    public List<AdminBoardVO> getBoardList() {
        return adminBoardMapper.getBoardList();
    }

    // 📌 활성(사용) 머리말 목록 — 사용자 화면에 노출될 항목
    public List<AdminBoardVO> getActiveBoardList() {
        return adminBoardMapper.getActiveBoardList();
    }

    // 📌 게시판 기본 정보 조회(수정 화면용)
    public AdminBoardVO getBoard(int board_id) {
        return adminBoardMapper.getBoard(board_id);
    }

    // 📌 게시판 생성
    public void insertBoard(AdminBoardVO vo) {
        adminBoardMapper.insertBoard(vo);
    }

    // 📌 게시판 수정
    public void updateBoard(AdminBoardVO vo) {
        adminBoardMapper.updateBoard(vo);
    }

    // 📌 게시판 삭제
    public void deleteBoard(int board_id) {
        adminBoardMapper.deleteBoard(board_id);
    }

    // 📌 게시판 숨김
    public void disableBoard(int board_id) {
        adminBoardMapper.disableBoard(board_id);
    }

    // 📌 게시판 표시
    public void enableBoard(int board_id) {
        adminBoardMapper.enableBoard(board_id);
    }

    // 📌 게시판 순서 수정
    public void updateBoardOrder(AdminBoardVO vo) {
        adminBoardMapper.updateBoardOrder(vo);
    }

    // 📌 게시판 상세 정보 + 통계 조회
    public AdminBoardVO getBoardDetail(int board_id) {
        return adminBoardMapper.getBoardDetail(board_id);
    }

    // 📌 최근 게시글 5개
    public List<AdminPostVO> getRecentPosts(int board_id) {
        return adminBoardMapper.getRecentPosts(board_id);
    }

    // 📌 최근 7일 통계
    public List<Map<String, Object>> getWeeklyPostStats(int board_id) {
        return adminBoardMapper.getWeeklyPostStats(board_id);
    }

    // 📌 조회수 TOP5
    public List<AdminPostVO> getTopViewPosts(int board_id) {
        return adminBoardMapper.getTopViewPosts(board_id);
    }

    // 📌 신고 많은 TOP5
    public List<AdminPostVO> getTopReportPosts(int board_id) {
        return adminBoardMapper.getTopReportPosts(board_id);
    }

    // ==========================
    //  🔧 옵션 변경 기능들
    // ==========================

    public void updateAllowComment(int boardId, int value) {
        Map<String, Object> param = new HashMap<>();
        param.put("board_id", boardId);
        param.put("value", value);
        adminBoardMapper.updateAllowComment(param);
    }

    public void updateAllowImage(int boardId, int value) {
        Map<String, Object> param = new HashMap<>();
        param.put("board_id", boardId);
        param.put("value", value);
        adminBoardMapper.updateAllowImage(param);
    }

    public void updateAllowFile(int boardId, int value) {
        Map<String, Object> param = new HashMap<>();
        param.put("board_id", boardId);
        param.put("value", value);
        adminBoardMapper.updateAllowFile(param);
    }

    public void updateRequireApproval(int boardId, int value) {
        Map<String, Object> param = new HashMap<>();
        param.put("board_id", boardId);
        param.put("value", value);
        adminBoardMapper.updateRequireApproval(param);
    }

}
