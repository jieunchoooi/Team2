package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.LectureService;

@Controller
@RequestMapping("/category/*")
public class LectureController {
	
	@Inject
	private LectureService lectureService;
	
	@RequestMapping(value="/lectureList")
	public String lectureList(@RequestParam(required = false, defaultValue = "전체") String category_detail,
            Model model) {
		System.out.println("LectureController lectureList()");
		
		List<LectureVO> lectureList;
	    List<LectureVO> top10List;
	    
	    if (category_detail.equals("전체")) {
	        lectureList = lectureService.getAllLectures();
	        top10List = lectureService.getTop10();
	    } else {
	        lectureList = lectureService.getLecturesByCategory(category_detail);
	        top10List = lectureService.getTop10ByCategory(category_detail);
	    }
	    
	    model.addAttribute("lectureList", lectureList);
	    model.addAttribute("top10List", top10List);
	    model.addAttribute("category_detail", category_detail);
		
		return "category/lectureList";
	}
	
	@RequestMapping(value="/lecture")
	public String lecture(@RequestParam("no") int lecture_num,
            Model model) {
		System.out.println("LectureController lecture()");
		
		LectureVO lectureVO = lectureService.contentLecture(lecture_num);
		UserVO userVO = lectureService.getUserImg(lecture_num);
		List<LectureVO> authorLectures = lectureService.authorLectures(lectureVO);

		model.addAttribute("lectureVO", lectureVO);
		model.addAttribute("userVO", userVO);
		model.addAttribute("authorLectures", authorLectures);
		return "category/lecture";
	}
	
	

}
