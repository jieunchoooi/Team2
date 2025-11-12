package com.itwillbs.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ✅ 추가

import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.EnrollmentViewVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.EnrollmentService;
import com.itwillbs.service.MemberService;
import com.mysql.cj.Session;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService memberService;
	@Inject
	private EnrollmentService enrollmentService;
	
	// 업로드 경로
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 마이페이지
	@GetMapping("/mypage") 
	public String mypage(Model model, HttpSession session) {
		System.out.println("MemberController mypage()");
		String user_id = (String) session.getAttribute("user_id");
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
	public String editInfo(Model model, HttpSession session) {
		System.out.println("MemberController editInfo()");
		String user_id = (String)session.getAttribute("user_id");
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
	public String updatePro(HttpSession session,HttpServletRequest request, 	// 파일 없으면 null값이 됨
			@RequestParam(value = "user_picture", required = false) MultipartFile user_picture,
            RedirectAttributes rttr) throws Exception { //) throws Exception {
	    System.out.println("MemberController updatePro()");
	    
	    String user_id = (String) session.getAttribute("user_id");
	    // ✅ 1. 세션에서 user_id 가져오기 (현재는 임시로 하드코딩)
	   //  String user_id = "aaa1"; // TODO: 실제로는 session.getAttribute("user_id")로 변경
	    UserVO user = memberService.insertMember(user_id);
	    // ✅ 2. request에서 파라미터 가져오기
	    String password = request.getParameter("user_password");
	    String phone = request.getParameter("user_phone");
	    String name = request.getParameter("user_name");
	    String email = request.getParameter("user_email");
	    String address = request.getParameter("user_address");
	    
	    System.out.println("📝 받은 데이터: " + password + ", " + phone + ", " + name + ", " + email + ", " + address);
	    
	    // ✅ 3. UserVO 객체 생성 및 설정
	    UserVO userVO = new UserVO();
	    userVO.setUser_id(user_id); // WHERE 조건에 필수!
	    
	    // 비밀번호가 입력된 경우만 설정 	// 양쪽 공백 제거. 문자열 길이가 0인지
	    if(password != null && !password.trim().isEmpty()) {
	        userVO.setUser_password(password);
	    }
	    
	    userVO.setUser_phone(phone);
	    userVO.setUser_name(name);
	    userVO.setUser_email(email);
	    userVO.setUser_address(address);
	    
	    // ✅ 4. 파일 업로드 처리
	    if(user_picture != null && !user_picture.isEmpty()) {
	        UUID uuid = UUID.randomUUID();
	        String filename = uuid.toString() + "_" + user_picture.getOriginalFilename();
	        
	        System.out.println("📁 파일 저장 경로: " + uploadPath);
	        System.out.println("📁 파일명: " + filename);
	        
	        // 파일 저장
	        FileCopyUtils.copy(user_picture.getBytes(), new File(uploadPath, filename));
	        
	        // DB에 저장할 파일명 설정
	        userVO.setUser_file(filename);
	    }
	    
	    System.out.println("✅ 저장할 데이터: " + userVO);
	    
	    // ✅ 5. DB 업데이트
	    memberService.updateProMember(userVO);
	    
	 // ✅ 성공 플래그 추가
	    rttr.addFlashAttribute("updateSuccess", "true");
	    
	    return "redirect:/member/mypage";   
	}

	// ✅ 로그인 세션의 user_num 기준으로 조회 → JSP에 enrollList로 전달
	 @GetMapping("/my_classroom")
	    public String my_classroom(HttpSession session, Model model) {
	        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	        if (loginUser == null) {
	        	   return "redirect:/user/login";
	        }

	        List<EnrollmentViewVO> enrollList =
	                enrollmentService.getEnrollmentsByUser(loginUser.getUser_num());
	        model.addAttribute("enrollList", enrollList);
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
	
	// 회원정보수정 들어가기전 비밀번호 확인
	@GetMapping("/updatePassWord") 
	public String updatePassWord(Model model, HttpSession session) {
		System.out.println("MemberController updatePassWord()");
		String user_id = (String) session.getAttribute("user_id");
		UserVO user = memberService.insertMember(user_id);
		
		model.addAttribute("user", user);
		return "member/updatePassWord";  
	}
	
	@PostMapping("/updatePasswordPro")
	public String updatePasswordPro(@RequestParam("user_id") String user_id,
								    @RequestParam("user_password") String user_password, Model model) {
		System.out.println("MemberController updatePasswordPro()");
		
		UserVO user = memberService.insertMember(user_id);
		
		if(user != null && user.getUser_password().equals(user_password)) {
			// 비번 일치
			return "redirect:/member/editInfo";
		}else {	
	        return "member/msg";
		}
		
	}
	
	// 회원탈퇴
	@GetMapping("/memberdeletePro") 
	public String memberdeletePro() {
		System.out.println("MemberController memberdeletePro()");
			
		return "main/main";  
	}

	// 로그아웃
	@GetMapping("/logout") 
	public String logout(HttpSession session) {
		System.out.println("MemberController logout()");
		session.invalidate();
		return "main/main";  
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
