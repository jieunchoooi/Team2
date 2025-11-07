package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/category/*")
public class CategoryController {
	
	@RequestMapping(value="/lectureList")
	public String drawingList() {
		System.out.println("CategoryController lectureList()");
		return "category/lectureList";
	}
	
	@RequestMapping(value="/lecture")
	public String lecture() {
		System.out.println("CategoryController lecture()");
		return "category/lecture";
	}
	
	

}
