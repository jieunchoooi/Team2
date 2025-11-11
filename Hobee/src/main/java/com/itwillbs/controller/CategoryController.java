package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.service.CategoryService;

@Controller
@RequestMapping("/category/*")
public class CategoryController {
	
	@Inject
	private CategoryService categoryService;
	
	@RequestMapping(value="/lectureList")
	public String lectureList(@RequestParam(required = false, defaultValue = "전체") String category_detail,
            Model model) {
		System.out.println("CategoryController lectureList()");
		
		List<LectureVO> lectureList;
	    List<LectureVO> top10List;
	    
	    if (category_detail.equals("전체")) {
	        lectureList = categoryService.getAllLectures();
	        top10List = categoryService.getTop10();
	    } else {
	        lectureList = categoryService.getLecturesByCategory(category_detail);
	        top10List = categoryService.getTop10ByCategory(category_detail);
	    }
	    
	    model.addAttribute("lectureList", lectureList);
	    model.addAttribute("top10List", top10List);
	    model.addAttribute("category", category_detail);
		
		return "category/lectureList";
	}
	
	@RequestMapping(value="/lecture")
	public String lecture() {
		System.out.println("CategoryController lecture()");
		return "category/lecture";
	}
	
	

}
