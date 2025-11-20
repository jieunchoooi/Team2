package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.GradeVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.GradeService;
import com.itwillbs.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Inject
    private UserService userService;
    @Inject
    private GradeService gradeService;


    @Inject
    private JavaMailSender mailSender;


    /* ==========================================================
       1. 페이지 회원가입 차단 (insert.jsp 사용 금지)
     ========================================================== */
    @GetMapping("/insert")
    public String blockInsertPage() {
        // insert.jsp 접근 막기 → 메인으로 리다이렉트
        return "redirect:/main/main";
    }


    /* ==========================================================
       2. 회원가입 Ajax (모달 전용)
     ========================================================== */
    @PostMapping("/insertAjax")
    @ResponseBody
    public Map<String, Object> insertAjax(@ModelAttribute UserVO userVO) {

        Map<String, Object> result = new HashMap<>();
        System.out.println("insertAjax 실행 → " + userVO.getUser_id());

        // 1) 아이디 중복
        if (userService.selectUserById(userVO.getUser_id()) != null) {
            result.put("result", "fail");
            result.put("message", "이미 존재하는 아이디입니다.");
            return result;
        }

        // 2) 이메일 중복
        if (userService.checkEmail(userVO.getUser_email()) > 0) {
            result.put("result", "fail");
            result.put("message", "이미 등록된 이메일입니다.");
            return result;
        }

        // 3) 비밀번호 검사
        String pwPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^*])[A-Za-z\\d!@#$%^*]{8,12}$";
        if (!userVO.getUser_password().matches(pwPattern)) {
            result.put("result", "fail");
            result.put("message", "비밀번호 형식이 올바르지 않습니다.");
            return result;
        }

        // 4) 전화번호 검사
        String phonePattern = "^010-\\d{4}-\\d{4}$";
        if (!userVO.getUser_phone().matches(phonePattern)) {
            result.put("result", "fail");
            result.put("message", "전화번호 형식이 올바르지 않습니다.");
            return result;
        }

        // 5) 성별 선택 여부
        if (!( "Male".equals(userVO.getUser_gender())
                || "Female".equals(userVO.getUser_gender()) )) {
            result.put("result", "fail");
            result.put("message", "성별을 선택해주세요.");
            return result;
        }

        // 6) DB 저장
        userService.insertUser(userVO);
        System.out.println("회원가입 완료 : " + userVO.getUser_id());

        result.put("result", "success");
        return result;
    }


    /* ==========================================================
       3. 아이디 중복 체크 (Ajax)
     ========================================================== */
    @GetMapping("/checkId")
    @ResponseBody
    public String checkId(@RequestParam("user_id") String user_id) {

        UserVO userVO = userService.selectUserById(user_id);
        return (userVO == null) ? "available" : "duplicate";
    }


    /* ==========================================================
       4. 이메일 중복 체크 (Ajax)
     ========================================================== */
    @GetMapping("/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("user_email") String user_email) {

        int count = userService.checkEmail(user_email);
        return (count == 0) ? "available" : "duplicate";
    }


    /* ==========================================================
       5. 로그인 페이지 이동
     ========================================================== */
    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }


    /* ==========================================================
       6. 로그인 Ajax (모달 전용)
     ========================================================== */
    @PostMapping("/loginPro")
    @ResponseBody
    public Map<String, Object> loginPro(@ModelAttribute UserVO userVO, HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 1) 아이디로 DB 조회
        UserVO dbUser = userService.loginUser(userVO);

        // 2) 아이디 없음
        if (dbUser == null) {
            result.put("result", "fail");
            result.put("message", "존재하지 않는 아이디입니다.");
            return result;
        }

        // 3) 비밀번호 불일치
        if (!dbUser.getUser_password().equals(userVO.getUser_password())) {
            result.put("result", "fail");
            result.put("message", "비밀번호가 일치하지 않습니다.");
            return result;
        }

        // 4) 상태 체크
        String status = dbUser.getUser_status();

        if ("withdraw".equals(status) || "self-withdraw".equals(status)) {
            result.put("result", "fail");
            result.put("message", "탈퇴한 계정은 로그인이 불가능합니다.");
            return result;
        }

        if ("inactive".equals(status)) {
            result.put("result", "fail");
            result.put("message", "현재 비활성화된 계정입니다.\n관리자에게 문의하세요.");
            return result;
        }
        // 🔥 login 성공 → 등급 정보 가져오기
        GradeVO gradeVO = gradeService.getGradeByUser(userVO.getUser_num());

       
       
        // 5) 로그인 성공 → 세션 저장
        session.setAttribute("gradeVO", gradeVO);
        session.setAttribute("userVO", dbUser);
        session.setAttribute("user_id", dbUser.getUser_id());
        session.setAttribute("user_name", dbUser.getUser_name());
        session.setAttribute("user_role", dbUser.getUser_role()); 

        result.put("result", "success");
        result.put("user_name", dbUser.getUser_name());

        return result;
    }


    /* ==========================================================
       7. 로그아웃
     ========================================================== */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main/main";
    }


    /* ==========================================================
       8. 아이디 찾기
     ========================================================== */
    @GetMapping("/findId")
    public String findId() {
        return "user/findId";
    }

    @PostMapping("/findIdPro")
    public String findIdPro(
            @RequestParam String user_name,
            @RequestParam String user_email,
            Model model) {

        UserVO user = userService.findIdByNameAndEmail(user_name, user_email);

        if (user == null) {
            model.addAttribute("msg", "일치하는 정보가 없습니다.");
        } else {
            model.addAttribute("msg", "회원님의 아이디는: " + user.getUser_id());
        }

        return "user/findId";
    }


    /* ==========================================================
       9. 비밀번호 찾기
     ========================================================== */
    @GetMapping("/findPw")
    public String findPwForm() {
        return "user/findPw";
    }

    @PostMapping("/findPwPro")
    public String findPwPro(
            @RequestParam("user_id") String user_id,
            @RequestParam("user_email") String user_email,
            Model model) throws Exception {

        System.out.println("findPwPro() 실행 - ID : " + user_id + ", Email : " + user_email);

        // 1️⃣ 아이디 + 이메일로 사용자 조회
        UserVO user = userService.findUserByIdAndEmail(user_id, user_email);

        if (user == null) {
            model.addAttribute("msg", "아이디 또는 이메일이 일치하지 않습니다.");
            return "/user/findPw";   // 다시 findPw.jsp로
        }

        // 2️⃣ 임시 비밀번호 생성
        String tempPw = UUID.randomUUID().toString().substring(0, 8);

        // 3️⃣ 임시 비밀번호 DB 업데이트
        userService.updateTempPassword(user_id, tempPw);

        // 4️⃣ 이메일 발송
        sendTempPasswordMail(user_email, tempPw);

        // 5️⃣ 성공 메시지만 findPw.jsp에서 출력
        model.addAttribute("msg", "임시 비밀번호가 이메일로 전송되었습니다.\n로그인 버튼을 눌러주세요.");

        return "/user/findPw";  // ❗ 로그인 페이지로 이동 금지
    }


    /* ==========================================================
       10. 임시 비밀번호 이메일 발송
     ========================================================== */
    private void sendTempPasswordMail(String toEmail, String tempPw) {

        String subject = "[Hobee] 임시 비밀번호 안내";

        String content = "<h3>Hobee 임시 비밀번호 안내</h3>"
                + "<p>임시 비밀번호는 다음과 같습니다:</p>"
                + "<p style='font-size:18px; font-weight:bold; color:#2573ff;'>"
                + tempPw + "</p>"
                + "<p>로그인 후 반드시 비밀번호를 변경해주세요.</p>";

        try {

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper =
                    new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject(subject);
            helper.setText(content, true);
            helper.setFrom("yourgmail@gmail.com", "Hobee 관리자");

            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
