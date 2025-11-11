package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
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
    
    @Resource(name = "uploadPath")
	private String uploadPath;

    // ✅ 회원가입 페이지 이동
    @GetMapping("/insert")
    public String insertForm() {
    	System.out.println("UesrController: insertForm() 실행");

        return "user/insert"; // views/user/insert.jsp
    }

    // ✅ 회원가입 처리
    @PostMapping("/insertPro")
    public String insertPro(HttpServletRequest request,
                            @RequestParam("user_file") MultipartFile user_file) throws IOException {

        System.out.println("UserController: insertPro() 실행");

        UserVO userVO = new UserVO();
        userVO.setUser_id(request.getParameter("user_id"));
        userVO.setUser_password(request.getParameter("user_password"));
        userVO.setUser_name(request.getParameter("user_name"));
        userVO.setUser_email(request.getParameter("user_email"));
        userVO.setUser_phone(request.getParameter("user_phone"));
        userVO.setUser_address(request.getParameter("user_address"));
        userVO.setUser_gender(request.getParameter("user_gender"));

        // ✅ 파일 업로드 처리 (한 번만)
        if (!user_file.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            String filename = uuid.toString() + "_" + user_file.getOriginalFilename();
            FileCopyUtils.copy(user_file.getBytes(), new File(uploadPath, filename));
            userVO.setUser_file(filename);

            System.out.println("업로드 경로 : " + uploadPath);
            System.out.println("업로드 파일명 : " + filename);
        }

        System.out.println("저장할 회원 정보: " + userVO);
        userService.insertUser(userVO);

        return "redirect:/user/login";   
    }
    
  //✅ 아이디 중복확인
 	
  	@GetMapping("/checkId")
  	@ResponseBody
  	public String checkId(@RequestParam("user_id")String user_id) {
  		System.out.println("UserControllere checkId() 실행 - user_id : " + user_id);
  		
  		String result = "" ;
  		UserVO userVO = userService.infoUser(user_id);
  		if (userVO == null) {
  			result = "available"; // 사용 가능
  		} else {
  			result = "duplicate"; // 아이디 중복
  		}
  		return result;
  	}
    
    // ✅ 로그인 페이지 이동
    @GetMapping("/login")
    public String loginForm() {
    	System.out.println("UesrController: loginForm() 실행");
    	return "user/login";
    }
    
    // ✅ 로그인 처리
    @PostMapping("/loginPro")
    public String loginPro(@ModelAttribute UserVO userVO, HttpSession session, RedirectAttributes rttr) {
        System.out.println("UserController loginPro() 실행 - ID: " + userVO.getUser_id());

        // ✅1️. 아이디로 회원 조회
        UserVO dbUser = userService.infoUser(userVO.getUser_id());

        // ✅2️. 비밀번호 검증
        if (dbUser != null && dbUser.getUser_password().equals(userVO.getUser_password())) {
            // ✅ 로그인 성공
            session.setAttribute("user_id", dbUser.getUser_id());
            session.setAttribute("user_name", dbUser.getUser_name());
            System.out.println("로그인 성공: " + dbUser.getUser_name());
            return "redirect:/main/main";
        } else {
            // ❌ 로그인 실패
            rttr.addFlashAttribute("loginFail", true);
            System.out.println("로그인 실패");
            return "redirect:/user/login";
        }
    }

    // ✅ 로그인 성공 main 이돌
    // 가상요청주소 /main/main => /main/main.jsp 주소변경없이 이동
 	@RequestMapping(value = "main/main", method = RequestMethod.GET)
 	public String main() {
 		System.out.println("UserController main()");
    // WEB-INF/views/main/main.jsp 주소변경없이 이동
 		return "main/main";
 	}
 	
 	// ✅ 내정보 페이지 (DB조회)
 	@GetMapping("/infoUser")
 	public String infoUser(HttpSession session, org.springframework.ui.Model model) {
 	    System.out.println("UserController: infoUser() 실행");

 	    // 로그인 세션 체크
 	    String user_id = (String) session.getAttribute("user_id");
 	    if (user_id == null) {
 	        System.out.println("로그인 세션 없음 → 로그인 페이지로 이동");
 	        return "redirect:/user/login";
 	    }

 	    // DB에서 회원 정보 조회
 	    UserVO userVO = userService.infoUser(user_id);
 	    model.addAttribute("user", userVO); // JSP로 데이터 전달

 	    return "user/infoUser"; // /WEB-INF/views/user/infoUser.jsp
 	}

 	// ✅ 로그아웃 처리
 	@GetMapping("/logout")
 	public String logout(HttpSession session) {
 	    System.out.println("UserController: logout() 실행");
 	    session.invalidate(); // 세션 전체 제거
 	    return "redirect:/main/main"; // 메인으로 돌아가기
 	}

}








