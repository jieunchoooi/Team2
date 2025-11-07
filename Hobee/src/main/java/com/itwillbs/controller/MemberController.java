package com.itwillbs.controller;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.domain.UserVO;
import com.itwillbs.service.MemberService;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService memberService;
	
	// 업로드 경로
	@Resource(name = "uploadPath")
	private String uploadPath = "src/main/webapp/resources/img/user_picture";
	
	// 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		System.out.println("MemberController mypage()");
		
		return "member/mypage";  
	}
	
	// 회원수정
	@GetMapping("/editInfo")
	public String editInfo() {
		System.out.println("MemberController editInfo()");
		
		return "member/editInfo"; 
	}
	
	// 내 강의실
	@GetMapping("/my_classroom")
	public String my_classroom() {
		System.out.println("MemberController my_classroom()");
		
		return "member/my_classroom";  
	}
	
	// 결제 내역
	@GetMapping("/payment")
	public String payment() {
		System.out.println("MemberController payment()");
		
		return "member/payment"; 
	}

	// 리뷰
	@GetMapping("/review")
	public String review() {
		System.out.println("MemberController review()");
		
		return "member/review";  
	}
	
	// 스크랩	
	@GetMapping("/scrap")
	public String scrap() {
		System.out.println("MemberController scrap()");
		
		return "member/scrap";  
	}
	
	@PostMapping("/updatePro")
	public String updatePro(HttpServletRequest request, MultipartFile file ) throws Exception {
		System.out.println("MemberController updatePro()");
		
		UUID uuid = UUID.randomUUID();
		String filename = uuid.toString() + "_" + file.getOriginalFilename();
		
		FileCopyUtils.copy(file.getBytes(),new File(uploadPath, filename));
		
		UserVO userVO = new UserVO();
		userVO.setUser_password("User_password");
		userVO.setUser_phone("User_password");
		userVO.setUser_name("User_name");
		userVO.setUser_email("UserVO.User_email");
		
		memberService.updateMember(userVO);
		
		return "redirect:/member/mypage";   
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
