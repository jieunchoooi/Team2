package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.service.AdminService;

@ControllerAdvice
public class HeaderController {

	@Inject
	private AdminService adminService;
	
	@ModelAttribute
	public void addheaderCategories(Model model) {
		System.out.println("HeaderController addheaderCategories");
		
		List<Category_mainVO> categoMainryList = adminService.categoMainryList();
	    List<CategoryVO> categoryList = adminService.categoryList();
	    model.addAttribute("categoryList", categoryList);
	    model.addAttribute("categoMainryList", categoMainryList);
	}
	
	
}
