package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminBoardVO;

@Mapper
public interface AdminBoardMapper {
	
	// 게시판 목록
    public List<AdminBoardVO> getBoardList();

    // 게시판 단일 조회
    public AdminBoardVO getBoard(int board_id);

    // 게시판 추가
    public void insertBoard(AdminBoardVO vo);

    // 게시판 수정
    public void updateBoard(AdminBoardVO vo);

    // 게시판 삭제
    public void deleteBoard(int board_id);
    
    // 삭제 → 숨기기
	public void disableBoard(int board_id);

	public void enableBoard(int board_id);

}
