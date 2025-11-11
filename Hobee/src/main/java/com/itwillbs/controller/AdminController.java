package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.service.AdminService;
import com.itwillbs.service.UserService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

//	@Inject
//	private AdminService adminservice;

	@GetMapping("/adminCategory")
	public String adminCategory() {
		System.out.println("AdminController adminCategory()");
		
		return "admin/adminCategory";
	}	
	
	@GetMapping("/adminClassAdd")
	public String adminClassAdd() {
		System.out.println("AdminController adminClassAdd()");
		
		return "admin/adminClassAdd";
	}	
	
	@PostMapping("/adminClassAddPro")
	public String adminClassAddPro() {
		System.out.println("AdminController adminClassAddPro()");
		
		return "admin/adminClassAdd";
	}	
	
	
	@GetMapping("/adminClassList")
	public String adminClassList() {
		System.out.println("AdminController adminClassList()");
		
		return "admin/adminClassList";
	}	
	
	@GetMapping("/adminMemberList")
	public String adminMemberList() {
		System.out.println("AdminController adminMemberList()");
		
		return "admin/adminMemberList";
	}	
	
	@GetMapping("/adminTeacherList")
	public String adminTeacherList() {
		System.out.println("AdminController adminTeacherList()");
		
		return "admin/adminTeacherList";
	}	
	
	@GetMapping("/adminWithdrawList")
	public String adminWithdrawList() {
		System.out.println("AdminController adminWithdrawList()");
		
		return "admin/adminWithdrawList";
	}	
	
	
	
	
	
	
	
}
