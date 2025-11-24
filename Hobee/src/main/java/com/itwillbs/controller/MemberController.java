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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ✅ 추가

import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.EnrollmentViewVO;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.ScrapVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.EnrollmentService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.PaymentService;
import com.itwillbs.service.ScrapService;
import com.mysql.cj.Session;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService memberService;
	@Inject
	private EnrollmentService enrollmentService;
	@Inject
    private PaymentService paymentService;
	@Inject
    private ScrapService scrapService;
	// 업로드 경로
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// ⭐ 모든 /member/* 요청에 대해 현재 페이지 식별값을 자동으로 Model에 주입
	@ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();

	    if (uri.contains("mypage")) return "mypageHome";
	    if (uri.contains("my_classroom")) return "lecture";
	    if (uri.contains("scrap")) return "scrap";
	    if (uri.contains("review")) return "review";
	    if (uri.contains("paymentList")) return "paymentList";
	    if (uri.contains("payment")) return "paymentList"; // ⭐ 상세 페이지도 동일 그룹
	    if (uri.contains("editInfo")) return "edit";
	    if (uri.contains("updatePassWord")) return "edit";

	    return "";
	}

	
	
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
			@RequestParam(value = "user_file", required = false) MultipartFile user_picture,
            RedirectAttributes rttr) throws Exception { //) throws Exception {
	    System.out.println("MemberController updatePro()");
	    
	    String user_id = (String) session.getAttribute("user_id");
	    // ✅ 1. 세션에서 user_id 가져오기 
	    UserVO user = memberService.insertMember(user_id);
	    // ✅ 2. request에서 파라미터 가져오기
	    String password = request.getParameter("user_password");
	    String phone = request.getParameter("user_phone");
	    String name = request.getParameter("user_name");
	    String email = request.getParameter("user_email");
	    String user_zipcode = request.getParameter("user_zipcode");
	    String address1 = request.getParameter("user_address1");
	    String address2 = request.getParameter("user_address2");
	    int user_num = Integer.parseInt(request.getParameter("user_num"));
	    
	    System.out.println("📝 받은 데이터: " + password + ", " + phone + ", " + name + ", " + email + ", " + user_zipcode + address1 + address2);
	    
	    // ✅ 3. UserVO 객체 생성 및 설정
	    UserVO userVO = new UserVO();
	    userVO.setUser_id(user_id); // WHERE 조건에 필수!
	    userVO.setUser_num(user_num);
	    
	    // 비밀번호가 입력된 경우만 설정 	// 양쪽 공백 제거. 문자열 길이가 0인지
	    if(password != null && !password.trim().isEmpty()) {
	        userVO.setUser_password(password);
	    }
	    
	    userVO.setUser_phone(phone);
	    userVO.setUser_name(name);
	    userVO.setUser_email(email);
	    userVO.setUser_zipcode(user_zipcode);
	    userVO.setUser_address1(address1);
	    userVO.setUser_address2(address2);
	    
	    if(user_picture == null || user_picture.isEmpty()) {
	    	userVO.setUser_file(request.getParameter("oldfile"));
		}else {
			UUID uuid = UUID.randomUUID();
	        String filename = uuid.toString() + "_" + user_picture.getOriginalFilename();
	        
	        System.out.println("📁 파일명: " + filename);
	        
	        FileCopyUtils.copy(user_picture.getBytes(), new File(uploadPath, filename));
	        
	        userVO.setUser_file(filename);
	        
			File oldfile = new File(uploadPath, request.getParameter("oldfile"));
			
			if(oldfile.exists()) {
				oldfile.delete();
			}
		}
		
	    System.out.println("✅ 저장할 데이터: " + userVO);
	    
	    memberService.updateProMember(userVO);
	    
	    rttr.addFlashAttribute("updateSuccess", "true");
	    
	    return "redirect:/member/mypage";   
	}

	// ✅ 로그인 세션의 user_num 기준으로 조회 → JSP에 enrollList로 전달
	 @GetMapping("/my_classroom")
	    public String my_classroom(HttpSession session, Model model) {
	        UserVO loginUser = (UserVO) session.getAttribute("userVO");
	        if (loginUser == null) {
	        	   return "redirect:/main/main";
	        }

	        List<EnrollmentViewVO> enrollList =
	                enrollmentService.getEnrollmentsByUser(loginUser.getUser_num());
	        model.addAttribute("enrollList", enrollList);
	        return "member/my_classroom";
	    }
	


	// 리뷰
	@GetMapping("/review")
	public String review() {
		System.out.println("MemberController review()");
		
		return "member/review";  
	}
	
	// 스크랩	
	@GetMapping("/scrap")
	public String scrapList(HttpSession session, Model model) {
	    UserVO userVO = (UserVO) session.getAttribute("userVO");

	    if (userVO == null) return "redirect:/member/login";

	    List<ScrapVO> scrapList = scrapService.getScrapList(userVO.getUser_num());
	    model.addAttribute("scrapList", scrapList);

	    return "member/scrap";
	}
	
	/** 스크랩 삭제 (단일) */
    @PostMapping("/scrap/delete")
    @ResponseBody
    public String deleteScrap(@RequestParam int lecture_num, HttpSession session) {

        UserVO userVO = (UserVO) session.getAttribute("userVO");
        if (userVO == null) return "LOGIN_REQUIRED";

        boolean result = scrapService.deleteScrap(userVO.getUser_num(), lecture_num);
        return result ? "OK" : "FAIL";
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
	public String memberdeletePro(@RequestParam("user_num") int user_num, HttpSession session) {
		System.out.println("MemberController memberdeletePro()");
		
		memberService.memberDelete(user_num);
		session.invalidate();
		
		return "redirect:/";  
	}

	// 로그아웃
	@GetMapping("/logout") 
	public String logout(HttpSession session) {
		System.out.println("MemberController logout()");
		session.invalidate();
		return "redirect:/";  
	}
	
	
	//결제내역
	  @GetMapping("/paymentList")
	    public String myPayment(HttpSession session, Model model) {
		  	 System.out.println("MemberController paymetList()");
		  	UserVO loginUser = (UserVO) session.getAttribute("userVO");
	        if (loginUser == null) {
	        	   return "redirect:/main/main";
	        }

	        List<PaymentVO> paymentList =
	                paymentService.getPaymentList(loginUser.getUser_num());
	        System.out.println(paymentList);
	        model.addAttribute("paymentList", paymentList);
	        

	        return "member/paymentList";    // JSP 경로
	    }
	
//	  // 결제내역상세상세
//	    @GetMapping("/payment")
//	    public String paymentDetail(int payment_id, HttpSession session, Model model) {
//	    	System.out.println("MemberController paymet()");
//	        UserVO user = (UserVO) session.getAttribute("userVO");
//	        PaymentVO payment = paymentService.getPayment(payment_id);
//
//	        payment.setRefundable(paymentService.isRefundable(payment.getCreated_at()));
//
//	        model.addAttribute("userVO", user);
//	        model.addAttribute("payment", payment);
//
//	        return "member/payment";
//	    }
	    
	    @GetMapping("/payment")
	    public String paymentDetailPage(
	            @RequestParam("payment_id") int paymentId,
	            HttpSession session,
	            Model model) {

	        UserVO user = (UserVO) session.getAttribute("userVO");
	        if (user == null) {
	            return "redirect:/member/login"; // 보호
	        }

	        // 결제 상세 정보
	        PaymentVO payment = paymentService.getPayment(paymentId);

	        // 환불 가능 여부 계산
	        payment.setRefundable(paymentService.isRefundable(payment.getCreated_at()));

	        // JSP에서 사용하도록 모델에 담기
	        model.addAttribute("payment", payment);
	        System.out.println("📌 PaymentVO JSON = " + payment);
	        // JSP 경로
	        return "member/payment";  // /WEB-INF/views/member/payment.jsp
	    }

	
	
	
	
	
}
