package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.service.LectureService;

@Controller
@RequestMapping("/main/*")
public class MainController {
	
	@Inject
	private LectureService lectureService;
	
	@RequestMapping(value="/main")
	public String main(Model model) {
		System.out.println("MainController main()");
		
		List<LectureVO> bestList = lectureService.getTop10();
		
		model.addAttribute("bestList", bestList);
		
		return "main/main";
	}

}
