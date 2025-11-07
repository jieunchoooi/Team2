package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.service.MemberService;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService memberService;
	
	// 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		System.out.println("MemberController mypage()");
		
		return "member/mypage";  // WEB-INF/views/user/join.jsp
	}
	
	// 회원수정
	@GetMapping("/editInfo")
	public String editInfo() {
		System.out.println("MemberController editInfo()");
		
		return "member/editInfo";  // WEB-INF/views/user/join.jsp
	}
	
	// 내 강의실
	@GetMapping("/my_classroom")
	public String my_classroom() {
		System.out.println("MemberController my_classroom()");
		
		return "member/my_classroom";  // WEB-INF/views/user/join.jsp
	}
	
	// 결제 내역
	@GetMapping("/payment")
	public String payment() {
		System.out.println("MemberController payment()");
		
		return "member/payment";  // WEB-INF/views/user/join.jsp
	}

	// 리뷰
	@GetMapping("/review")
	public String review() {
		System.out.println("MemberController review()");
		
		return "member/review";  // WEB-INF/views/user/join.jsp
	}
	
	// 스크랩	
	@GetMapping("/scrap")
	public String scrap() {
		System.out.println("MemberController scrap()");
		
		return "member/scrap";  // WEB-INF/views/user/join.jsp
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
