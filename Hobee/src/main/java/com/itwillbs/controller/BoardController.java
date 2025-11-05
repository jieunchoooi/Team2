package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.BoardVO;
import com.itwillbs.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	private BoardService boardService;

	@RequestMapping (value="/write")
	public String write() {
		System.out.println("BoradController write()");
		return "board/comunityWrite";
	}
	
	@RequestMapping (value="/writePro")
	public String writePro(BoardVO boardVO) {
		System.out.println("BoradController writePro()");
		
		boardService.writeBoard(boardVO);
		
		return "redirect:/board/comunity";
	}
	
	
	
	
	
}
