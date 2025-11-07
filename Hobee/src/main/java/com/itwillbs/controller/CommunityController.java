package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.CommunityVO;
import com.itwillbs.service.CommunityService;

@Controller
@RequestMapping("/board/*")
public class CommunityController {
	
	@Inject
	private CommunityService communityService;

	@RequestMapping (value="/comunityWrite")
	public String comunitywrite() {
		System.out.println("CommunityController comunityWrite()");
		return "board/comunityWrite";
	}
	
	@RequestMapping (value="/writePro")
	public String writePro(CommunityVO communityVO) {
		System.out.println("CommunityController writePro()");
		
		communityService.writeCommunity(communityVO);
		
		return "redirect:/board/comunityList";
	}
	
	@RequestMapping (value="/comunityList")
	public String comunity() {
		System.out.println("CommunityController comunityList()");
		return "board/comunityList";
	}
	
	@RequestMapping (value="/comunityContent")
	public String comunityContent() {
		System.out.println("CommunityController comunityContent()");
		return "board/comunityContent";
	}
	
	
	
	
	
}
