package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.UserVO;
import com.itwillbs.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Inject
	private UserService userService;
	
	// 회원가입 폼
	@GetMapping("/join")
	public String joinForm() {
		System.out.println("UserController joinForm()");
		
		return "user/join";  // WEB-INF/views/user/join.jsp
	}
	
	// 회원가입 처리
	@PostMapping("/join")
	public String joinPro(UserVO userVO) {
		System.out.println("UserController joinPro()");
	
		userService.registerUser(userVO);
		
		return "redirect:/user/login";
	}
	// 로그인 폼
	@GetMapping("/login")
	public String loginForm() {
	    System.out.println("UserController loginForm()");
	    return "user/login"; // → /WEB-INF/views/user/login.jsp
	}

	
}
