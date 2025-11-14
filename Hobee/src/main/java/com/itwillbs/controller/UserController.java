package com.itwillbs.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.UserService;

//✅ 올바른 import (Spring 5.x 호환)
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;



@Controller
@RequestMapping("/user/*")
public class UserController {

    @Inject
    private UserService userService;
    
    @Inject
    private JavaMailSender mailSender;


    
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
    public String insertPro(HttpServletRequest request) throws IOException {

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
    
 // ✅ 로그인 Ajax 전용 (모달용)
    @PostMapping("/loginPro")
    @ResponseBody
    public Map<String, Object> loginPro(@ModelAttribute UserVO userVO, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        System.out.println("UserController loginPro() 실행 - ID: " + userVO.getUser_id());

        // ✅ DB에서 회원 조회
        UserVO dbUser = userService.selectUserById(userVO.getUser_id());

        // ✅ 비밀번호 검증
        if (dbUser != null && dbUser.getUser_password().equals(userVO.getUser_password())) {

            // ✅ 로그인 성공
            session.setAttribute("userVO", dbUser);                // 전체 VO 객체 저장
            session.setAttribute("user_id", dbUser.getUser_id());  // 기존 JSP 호환용
            session.setAttribute("user_name", dbUser.getUser_name());

            System.out.println("✅ 로그인 성공: " + dbUser.getUser_name());

            result.put("result", "success");
            result.put("user_name", dbUser.getUser_name());

        } else {
            // ❌ 로그인 실패
            System.out.println("❌ 로그인 실패");
            result.put("result", "fail");
            result.put("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }

        return result; // ✅ JSON 응답
    }

    /* ==========================================================
 	// ✅ 6. 로그아웃 처리
 	   ========================================================== */
 	@GetMapping("/logout")
 	public String logout(HttpSession session) {
 	    System.out.println("UserController: logout() 실행");
 	    session.invalidate(); // 세션 전체 제거
 	    System.out.println("✅ 로그아웃 완료");
 	   return "redirect:/main/main";
 	}

 	
 // ✅ 비밀번호 찾기 페이지 이동
    @GetMapping("/findPw")
    public String findPwForm() {
        return "/user/findPw";
    }

    // ✅ 비밀번호 찾기 처리
    @PostMapping("/findPwPro")
    public String findPwPro(String user_email, Model model) throws Exception {
        // 1️⃣ 이메일로 사용자 조회
        UserVO user = userService.findUserByEmail(user_email);

        if (user == null) {
            model.addAttribute("msg", "입력하신 이메일로 가입된 계정이 없습니다.");
            return "/user/findPw";
        }

        // 2️⃣ 임시 비밀번호 생성
        String tempPw = UUID.randomUUID().toString().substring(0, 10);

        // 3️⃣ 임시 비밀번호 DB 업데이트
        userService.updateTempPassword(user.getUser_id(), tempPw);

        // 4️⃣ 이메일 발송
        sendTempPasswordMail(user_email, tempPw);

        model.addAttribute("msg", "임시 비밀번호가 이메일로 발송되었습니다.");
        return "/user/login";
    }

    // ✅ 임시비밀번호 이메일 발송 메서드
    private void sendTempPasswordMail(String toEmail, String tempPw) {
        String subject = "[Hobee] 임시 비밀번호 안내";
        String content = "<h3>Hobee 비밀번호 재설정 안내</h3>"
                + "<p>요청하신 임시 비밀번호는 다음과 같습니다:</p>"
                + "<p style='font-size:18px; font-weight:bold; color:#2573ff;'>" + tempPw + "</p>"
                + "<p>로그인 후 반드시 새 비밀번호로 변경해주세요.</p>";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(toEmail);
            helper.setSubject(subject);
            helper.setText(content, true);
            helper.setFrom("yourgmail@gmail.com", "Hobee 관리자");

            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}













