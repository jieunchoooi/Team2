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

	@RequestMapping (value="/comunityWrite")
	public String comunitywrite() {
		System.out.println("BoradController comunityWrite()");
		return "board/comunityWrite";
	}
	
	@RequestMapping (value="/writePro")
	public String writePro(BoardVO boardVO) {
		System.out.println("BoradController writePro()");
		
		boardService.writeBoard(boardVO);
		
		return "redirect:/board/comunity";
	}
	
	@RequestMapping (value="/comunity")
	public String comunity() {
		System.out.println("BoradController comunity()");
		return "board/comunity";
	}
	
	@RequestMapping (value="/comunityContent")
	public String comunityContent() {
		System.out.println("BoradController comunityContent()");
		return "board/comunityContent";
	}
	
	
	
	
	
}
