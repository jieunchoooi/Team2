package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Inject
	private MemberService memberservice;

	@GetMapping("/mypage")
	public String mypage() {
		System.out.println("MemberController mypage()");
		
		return "member/mypage";
	}	
	
	@GetMapping("/editInfo")
	public String editInfo() {
		System.out.println("MemberController editInfo()");
		
		return "member/editInfo";
	}	
	
	@GetMapping("/main")
	public String main() {
		System.out.println("MemberController main()");
		
		return "redirect:/member/main";
	}	
	
	@PostMapping("/update")
	public String update(@RequestParam("id") String id) {
		System.out.println("MemberController update()");
		
		MemberVO memberVO = memberservice.udateMember(id);
		
		return "redirect:/member/main";
	}	
	
	@GetMapping("admin/class-manager/adminCategory")
	public String adminCategory() {
		System.out.println("MemberController adminCategory()");
		
		return "redirect:/admin/class-manager/adminCategory";
	}	
	
	@GetMapping("/my_classroom")
	public String my_classroom() {
		System.out.println("MemberController my_classroom()");
		
		return "member/my_classroom";
	}	
	
	@GetMapping("/scrap")
	public String scrap() {
		System.out.println("MemberController scrap()");
		
		return "member/scrap";
	}	
	
	@GetMapping("/review")
	public String review() {
		System.out.println("MemberController review()");
		
		return "member/review";
	}	
	
	@GetMapping("/payment")
	public String payment() {
		System.out.println("MemberController payment()");
		
		return "member/payment";
	}	
	
	
	
	
	
	
	
}
