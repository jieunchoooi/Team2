package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/category/*")
public class CategoryController {
	
	@RequestMapping(value="/drawingList")
	public String lecture() {
		System.out.println("CategoryController lecture()");
		return "category/drawingList";
	}
	
	

}
