package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminBoardVO;
import com.itwillbs.mapper.AdminBoardMapper;

@Service
public class AdminBoardService {
	
	@Inject
	private AdminBoardMapper adminBoardMapper;
	
	// 게시판 목록 전체 조회
    public List<AdminBoardVO> getBoardList() {
    	System.out.println(" AdminBoardService : getBoardList() 실행");
        return adminBoardMapper.getBoardList();
    }
    
    public AdminBoardVO getBoard(int board_id) {
    	System.out.println(" AdminBoardService : getBoard() 실행");
        return adminBoardMapper.getBoard(board_id);
    }

    // 게시판 생성
    public void insertBoard(AdminBoardVO vo) {
    	System.out.println(" AdminBoardService : insertBoard() 실행");
    	adminBoardMapper.insertBoard(vo);
    }

    // 게시판 수정
    public void updateBoard(AdminBoardVO vo) {
    	System.out.println(" AdminBoardService : updateBoard() 실행");
    	adminBoardMapper.updateBoard(vo);
    }

    // 게시판 삭제
    public void deleteBoard(int board_id) {
    	System.out.println(" AdminBoardService : deleteBoard() 실행");
    	adminBoardMapper.deleteBoard(board_id);
    }
    
    // 삭제 → 숨기기
    public void disableBoard(int board_id) {
    	System.out.println(" AdminBoardService : disableBoard() 실행");
    	adminBoardMapper.disableBoard(board_id);
    }
    
    public void enableBoard(int board_id) {
    	System.out.println(" AdminBoardService : enableBoard() 실행");
    	adminBoardMapper.enableBoard(board_id);
    }

}
