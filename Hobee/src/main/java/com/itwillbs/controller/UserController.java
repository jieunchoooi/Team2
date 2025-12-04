package com.itwillbs.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.domain.GradeVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.GradeService;
import com.itwillbs.service.UserService;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Inject private UserService userService;
    @Inject private GradeService gradeService;
    @Inject private JavaMailSender mailSender;


    /* ==========================================================
       1. insert.jsp 접근 차단 (항상 메인으로 이동)
    ========================================================== */
    @GetMapping("/insert")
    public String blockInsertPage() {
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

        // 아이디 중복
        if (userService.selectUserById(userVO.getUser_id()) != null) {
            result.put("result", "fail");
            result.put("message", "이미 존재하는 아이디입니다.");
            return result;
        }

        // 이메일 중복
        if (userService.checkEmail(userVO.getUser_email()) > 0) {
            result.put("result", "fail");
            result.put("message", "이미 등록된 이메일입니다.");
            return result;
        }

        // 비밀번호 정규식 검사
        String pwPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^*])[A-Za-z\\d!@#$%^*]{8,12}$";
        if (!userVO.getUser_password().matches(pwPattern)) {
            result.put("result", "fail");
            result.put("message", "비밀번호 형식이 올바르지 않습니다.");
            return result;
        }

        // 전화번호 검사
        if (!userVO.getUser_phone().matches("^010-\\d{4}-\\d{4}$")) {
            result.put("result", "fail");
            result.put("message", "전화번호 형식이 올바르지 않습니다.");
            return result;
        }

        // 성별 검사
        if (!("Male".equals(userVO.getUser_gender()) || "Female".equals(userVO.getUser_gender()))) {
            result.put("result", "fail");
            result.put("message", "성별을 선택해주세요.");
            return result;
        }

        // DB 저장
        userService.insertUser(userVO);
        System.out.println("회원가입 완료: " + userVO.getUser_id());

        result.put("result", "success");
        return result;
    }


    /* ==========================================================
       3. 아이디 중복 체크
    ========================================================== */
    @GetMapping("/checkId")
    @ResponseBody
    public String checkId(@RequestParam("user_id") String user_id) {
        return (userService.selectUserById(user_id) == null) ? "available" : "duplicate";
    }


    /* ==========================================================
       4. 이메일 중복 체크
    ========================================================== */
    @GetMapping("/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("user_email") String user_email) {
        return (userService.checkEmail(user_email) == 0) ? "available" : "duplicate";
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
    public Map<String, Object> loginPro(
            @ModelAttribute UserVO userVO,
            HttpSession session, HttpServletRequest request) {

        Map<String, Object> result = new HashMap<>();

        // 1) 아이디 조회
        UserVO dbUser = userService.loginUser(userVO);
        if (dbUser == null) {
            result.put("result", "fail");
            result.put("message", "존재하지 않는 아이디입니다.");
            return result;
        }

        /* -------------------------------
           로그인 실패 횟수 / 30분 제한 체크
        ------------------------------- */
        int failCount = dbUser.getLogin_fail_count();
        String lastFailTime = dbUser.getLast_fail_time();

        if (failCount >= 5 && lastFailTime != null && !lastFailTime.equals("null")) {

            LocalDateTime lastFail = LocalDateTime.parse(
                    lastFailTime,
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            if (lastFail.isAfter(LocalDateTime.now().minusMinutes(30))) {
                result.put("result", "locked");
                return result;
            } else {
                userService.resetFailCount(dbUser.getUser_id());
            }
        }

        /* -------------------------------
           3) 비밀번호 불일치
        ------------------------------- */
        if (!dbUser.getUser_password().equals(userVO.getUser_password())) {

            userService.increaseFailCount(dbUser.getUser_id());
            int left = 5 - (failCount + 1);

            result.put("result", "fail");
            result.put("message", "비밀번호가 일치하지 않습니다. (남은 시도: " + left + ")");
            return result;
        }

        /* -------------------------------
           4) 계정 상태 확인
        ------------------------------- */
        if ("withdraw".equals(dbUser.getUser_status())) {
            result.put("result", "fail");
            result.put("message", "탈퇴한 계정은 로그인할 수 없습니다.");
            return result;
        }
        if ("inactive".equals(dbUser.getUser_status())) {
            result.put("result", "fail");
            result.put("message", "비활성화 계정입니다.");
            return result;
        }

        /* -------------------------------
           5) 로그인 성공 → 실패 횟수 초기화
        ------------------------------- */
        userService.resetFailCount(dbUser.getUser_id());
        userService.updateLastLoginTime(dbUser.getUser_id());

        /* -------------------------------
           6) 로그인 기기 / 지역 저장
        ------------------------------- */
        String userAgent = request.getHeader("User-Agent");
        String deviceInfo = detectDevice(userAgent);

        String ip = request.getRemoteAddr();
        if (ip.equals("0:0:0:0:0:0:0:1")) ip = "1.234.5.6";

        String currentLocation = getLocationFromIP(ip);
        String lastLocation = userService.getLastLocation(dbUser.getUser_id());

        userService.insertLoginHistory(dbUser.getUser_id(), deviceInfo, currentLocation);
        List<String> recent = userService.getRecentLoginDevices(dbUser.getUser_id());

        session.setAttribute("current_location", currentLocation);
        session.setAttribute("last_location", lastLocation);
        session.setAttribute("recent_devices", recent);

        /* -------------------------------
           7) 세션 저장
        ------------------------------- */
        GradeVO gradeVO = gradeService.getGradeByUser(dbUser.getUser_num());

        session.setAttribute("userVO", dbUser);
        session.setAttribute("gradeVO", gradeVO);
        session.setAttribute("user_id", dbUser.getUser_id());
        session.setAttribute("user_name", dbUser.getUser_name());
        session.setAttribute("user_role", dbUser.getUser_role());

        /* -------------------------------
           8) 응답
        ------------------------------- */
        result.put("result", "success");
        result.put("user_name", dbUser.getUser_name());
        result.put("last_login_at", dbUser.getLast_login_at());
        result.put("current_location", currentLocation);
        result.put("last_location", lastLocation);
        result.put("recent_devices", recent);
        result.put("redirect", "/main/main");

        return result;
    }


    /* ==========================================================
       🔥 NEW: 로그인 상세 정보 API
    ========================================================== */
    @GetMapping("/loginInfo")
    @ResponseBody
    public Map<String, Object> loginInfo(HttpSession session) {

        System.out.println("===== loginInfo() 세션 확인 =====");
        System.out.println("user_name = " + session.getAttribute("user_name"));
        System.out.println("current_location = " + session.getAttribute("current_location"));
        System.out.println("recent_devices = " + session.getAttribute("recent_devices"));

        Map<String, Object> map = new HashMap<>();

        UserVO user = (UserVO) session.getAttribute("userVO");

        if (user == null) {
            map.put("error", "not_login");
            return map;
        }

        map.put("user_name", user.getUser_name());
        map.put("last_login_at", user.getLast_login_at());
        map.put("current_location", session.getAttribute("current_location"));
        map.put("last_location", session.getAttribute("last_location"));
        map.put("recent_devices", session.getAttribute("recent_devices"));

        return map;
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
    @ResponseBody
    public Map<String, Object> findIdPro(
            @RequestParam String user_name,
            @RequestParam String user_email) {

        Map<String, Object> result = new HashMap<>();
        UserVO vo = userService.findIdByNameAndEmail(user_name, user_email);

        if (vo == null) {
            result.put("status", "fail");
            result.put("msg", "일치하는 회원 정보가 없습니다.");
        } else {
            result.put("status", "success");
            result.put("user_id", vo.getUser_id());
        }
        return result;
    }


    /* ==========================================================
       9. 비밀번호 찾기
    ========================================================== */
    @GetMapping("/findPw")
    public String findPwForm() {
        return "user/findPw";
    }

    @PostMapping("/findPwPro")
    @ResponseBody
    public Map<String, Object> findPwPro(
            @RequestParam String user_id,
            @RequestParam String user_email) throws Exception {

        Map<String, Object> result = new HashMap<>();

        UserVO user = userService.findUserByIdAndEmail(user_id, user_email);
        if (user == null) {
            result.put("status", "fail");
            result.put("msg", "아이디 또는 이메일이 일치하지 않습니다.");
            return result;
        }

        String tempPw = UUID.randomUUID().toString().substring(0, 8);
        userService.updateTempPassword(user_id, tempPw);

        sendTempPasswordMail(user_email, tempPw);

        result.put("status", "success");
        result.put("msg", "임시 비밀번호가 이메일로 전송되었습니다.");
        return result;
    }


    /* ==========================================================
       10. 임시 비밀번호 이메일 전송
    ========================================================== */
    private void sendTempPasswordMail(String toEmail, String tempPw) {

        String subject = "[Hobee] 임시 비밀번호 안내";
        String content =
                "<h3>Hobee 임시 비밀번호 안내</h3>" +
                "<p>임시 비밀번호:</p>" +
                "<p style='font-size:18px; font-weight:bold; color:#2573ff;'>" +
                tempPw +
                "</p><p>로그인 후 비밀번호를 변경해주세요.</p>";

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


    /* ==========================================================
       11. User-Agent 파싱
    ========================================================== */
    private String detectDevice(String ua) {

        String os = "Unknown OS";
        String browser = "Unknown Browser";

        if (ua.contains("Windows")) os = "Windows";
        else if (ua.contains("Mac")) os = "MacOS";
        else if (ua.contains("Android")) os = "Android";
        else if (ua.contains("iPhone")) os = "iPhone";

        if (ua.contains("Edg/")) browser = "Edge";
        else if (ua.contains("Chrome")) browser = "Chrome";
        else if (ua.contains("Safari") && !ua.contains("Chrome")) browser = "Safari";
        else if (ua.contains("Firefox")) browser = "Firefox";

        return browser + " / " + os;
    }


    /* ==========================================================
       12. IP → 지역 조회 API
    ========================================================== */
    private String getLocationFromIP(String ip) {

        try {
            URL url = new URL("https://ipapi.co/" + ip + "/json/");
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            br.close();

            String json = sb.toString();

            String country = extract(json, "country_name");
            String region = extract(json, "region");
            String city = extract(json, "city");

            if (country == null) country = "UnknownCountry";
            if (region == null) region = "UnknownRegion";
            if (city == null) city = "UnknownCity";

            // 한국 지역 변환
            if (country.equals("South Korea")) {

                switch (region) {
                    case "Seoul": region = "서울특별시"; break;
                    case "Busan": region = "부산광역시"; break;
                    case "Daegu": region = "대구광역시"; break;
                    case "Incheon": region = "인천광역시"; break;
                    case "Gwangju": region = "광주광역시"; break;
                    case "Daejeon": region = "대전광역시"; break;
                    case "Ulsan": region = "울산광역시"; break;
                }
            }

            return country + " " + region + " " + city;

        } catch (Exception e) {
            return "Unknown";
        }
    }


    /* ==========================================================
       13. JSON 파싱 보조 함수
    ========================================================== */
    private String extract(String json, String key) {
        try {
            int index = json.indexOf("\"" + key + "\"");
            if (index == -1) return null;

            int start = json.indexOf(":", index) + 1;

            // 공백 또는 따옴표 제거
            while (json.charAt(start) == ' ' || json.charAt(start) == '"') start++;

            int end = start;
            while (end < json.length() &&
                    json.charAt(end) != '"' &&
                    json.charAt(end) != ',' &&
                    json.charAt(end) != '}') {
                end++;
            }

            return json.substring(start, end).trim();

        } catch (Exception e) {
            return null;
        }
    }
}
