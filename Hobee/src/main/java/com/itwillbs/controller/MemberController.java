package com.itwillbs.controller;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	private String uploadPath;
	
	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model) {
		System.out.println("MemberController mypage()");
		String user_id = "aaa1";
		UserVO user = memberService.insertMember(user_id);
		   if (user == null) {
		        System.out.println("⚠ user is null (DB 조회 실패)");
		    } else {
		        System.out.println("✅ DB 조회 성공: " + user);
		    }

		model.addAttribute("user",user);
		return "member/mypage";  
	}
	
	// 회원수정
	@GetMapping("/editInfo")
	public String editInfo(Model model) {
		System.out.println("MemberController editInfo()");
		String user_id = "aaa1";
		UserVO user = memberService.insertMember(user_id);
		   if (user == null) {
		        System.out.println("⚠ user is null (DB 조회 실패)");
		    } else {
		        System.out.println("✅ DB 조회 성공: " + user);
		    }

		model.addAttribute("user",user);
		
		return "member/editInfo"; 
	}
	
	@PostMapping("/updatePro")
	public String updatePro(HttpServletRequest request, MultipartFile user_picture) throws Exception {
		System.out.println("MemberController updatePro()");
		
		UUID uuid = UUID.randomUUID();
		String filename = uuid.toString() + "_" + user_picture.getOriginalFilename();
		
		FileCopyUtils.copy(user_picture.getBytes(),new File(uploadPath, filename));
		
		UserVO userVO = new UserVO();
		userVO.setUser_password("user_password");
		userVO.setUser_phone("user_phone");
		userVO.setUser_name("user_name");
		userVO.setUser_email("user_email");
		userVO.setUser_address("user_address");
		
		memberService.updateProMember(userVO);
		
		return "redirect:/member/mypage";   
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
