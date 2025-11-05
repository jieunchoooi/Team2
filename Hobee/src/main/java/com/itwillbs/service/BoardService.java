package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.BoardVO;
import com.itwillbs.mapper.BoardMapper;

@Service
public class BoardService {
	@Inject
	private BoardMapper boardMapper;

	public void writeBoard(BoardVO boardVO) {
		System.out.println("BoardService writeBoard()");
		System.out.println(boardVO);
		
		boardMapper.writeBoard(boardVO);
		
	}

}
