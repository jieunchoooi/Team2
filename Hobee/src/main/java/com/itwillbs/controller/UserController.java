package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.UserService;


@Controller
@RequestMapping("/user/*")
public class UserController {

    @Inject
    private UserService userService;
    
    // 업로드 경로 설정 (root-context.xml -> bean 등록)
    @javax.annotation.Resource(name = "uploadPath")
	private String uploadPath;

    /* ==========================================================
    // ✅ 1. 회원가입 페이지 이동
    ========================================================== */
    @GetMapping("/insert")
    public String insertForm() {
    	System.out.println("UesrController: insertForm() 실행");

        return "user/insert"; // views/user/insert.jsp
    }
    /* ==========================================================
    // ✅ 2. 회원가입 처리
     ========================================================== */
    @PostMapping("/insertPro")
    public String insertPro(HttpServletRequest request,
                            @RequestParam("user_file") MultipartFile user_file) throws IOException {

        System.out.println("UserController: insertPro() 실행");
        
        // ✅ 폼 데이터 수집
        UserVO userVO = new UserVO();
        userVO.setUser_id(request.getParameter("user_id"));
        userVO.setUser_password(request.getParameter("user_password"));
        userVO.setUser_name(request.getParameter("user_name"));
        userVO.setUser_email(request.getParameter("user_email"));
        userVO.setUser_phone(request.getParameter("user_phone"));
        userVO.setUser_address(request.getParameter("user_address"));
        userVO.setUser_gender(request.getParameter("user_gender"));
        
     
       // ✅ 서버단 유효성검사 (2차 방어)
    

     // 아이디
     if (userVO.getUser_id() == null || userVO.getUser_id().trim().isEmpty()) {
         System.out.println("❌ 아이디 미입력");
         return "redirect:/user/insert";
     }

     // 비밀번호
     String pwPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^*])[A-Za-z\\d!@#$%^*]{8,12}$";
     if (!userVO.getUser_password().matches(pwPattern)) {
         System.out.println("❌ 비밀번호 형식 오류");
         return "redirect:/user/insert";
     }

     // 전화번호
     String phonePattern = "^010-\\d{4}-\\d{4}$";
     if (!userVO.getUser_phone().matches(phonePattern)) {
         System.out.println("❌ 전화번호 형식 오류");
         return "redirect:/user/insert";
     }

     // 주소
     if (userVO.getUser_address() == null || userVO.getUser_address().trim().isEmpty()) {
         System.out.println("❌ 주소 미입력");
         return "redirect:/user/insert";
     }

     // 성별 (DB는 ENUM('Male','Female'))
     if (!("Male".equals(userVO.getUser_gender()) || "Female".equals(userVO.getUser_gender()))) {
         System.out.println("❌ 성별 값 오류: " + userVO.getUser_gender());
         return "redirect:/user/insert";
     }
    
     // ✅ 파일 업로드 필수 
     if (user_file == null || user_file.isEmpty()) {
    	 System.out.println("❌ 프로필 이미지 미업로드");
    	 return "redirect:/user/insert";
     }
    	// ✅ 파일 업로드 처리
    	 try {
    		 UUID uuid = UUID.randomUUID();
    		 String filename = uuid.toString() + "_" + user_file.getOriginalFilename();
    		 File target = new File(uploadPath, filename);

    		 FileCopyUtils.copy(user_file.getBytes(), target);
    		 userVO.setUser_file(filename);
    		 System.out.println("✅ 파일 업로드 완료: " + filename);

    	 } catch (IOException e) {
    		 e.printStackTrace();
    		 System.out.println("❌ 파일 업로드 실패");
    		 return "redirect:/user/insert";
     }

     // ✅  DB 저장
    
    	 userService.insertUser(userVO);
    	 System.out.println("✅ 회원가입 완료: " + userVO.getUser_id());

  
     // ✅ 가입 완료 페이지로 이동
    
    	 return "redirect:/user/login";
    }

    /* ==========================================================
    // 3. ✅ 아이디 중복확인
 	 ========================================================== */
  	@GetMapping("/checkId")
  	@ResponseBody
  	public String checkId(@RequestParam("user_id")String user_id) {
  		System.out.println("UserControllere checkId() 실행 - user_id : " + user_id);
  		
  		String result = "" ;
  		UserVO userVO = userService.selectUserById(user_id);
  		if (userVO == null) {
  			result = "available"; // 사용 가능
  		} else {
  			result = "duplicate"; // 아이디 중복
  		}
  		return result;
  	}
    
  	/* ==========================================================
    // 4. ✅ 로그인 페이지 이동
       ========================================================== */
     
    @GetMapping("/login")
    public String loginForm() {
    	System.out.println("UesrController: loginForm() 실행");
    	return "user/login";
    }
    
    // ✅ 로그인 처리 (로그인 실패 메세지 포함)
    @PostMapping("/loginPro")
    public String loginPro(@ModelAttribute UserVO userVO, HttpSession session, RedirectAttributes rttr) {
        System.out.println("UserController loginPro() 실행 - ID: " + userVO.getUser_id());

        // ✅ 아이디로 회원 조회
        UserVO dbUser = userService.selectUserById(userVO.getUser_id());

        // ✅  비밀번호 검증
        if (dbUser != null && dbUser.getUser_password().equals(userVO.getUser_password())) {
            // ✅ 로그인 성공
            session.setAttribute("user_id", dbUser.getUser_id());
            session.setAttribute("user_name", dbUser.getUser_name());
            System.out.println("✅ 로그인 성공: " + dbUser.getUser_name());
            // member 팀원 페이지로 이동
            return "redirect:/member/mypage";
        } else {
            // ❌ 로그인 실패 시 메세지 전달
        	System.out.println("❌ 로그인 실패");
            rttr.addFlashAttribute("loginFail", "아이디 또는 비밀번호가 일치하지 않습니다.");
    
            return "redirect:/user/login";
        }
    }
    /* ==========================================================
 	// ✅ 6. 로그아웃 처리
 	   ========================================================== */
 	@GetMapping("/logout")
 	public String logout(HttpSession session) {
 	    System.out.println("UserController: logout() 실행");
 	    session.invalidate(); // 세션 전체 제거
 	    System.out.println("✅ 로그아웃 완료");
 	    return "redirect:/user/login"; 
 	}
}











