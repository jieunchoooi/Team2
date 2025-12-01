package com.itwillbs.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


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
        if (!("Male".equals(userVO.getUser_gender())
                || "Female".equals(userVO.getUser_gender()))) {
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
   6. 로그인 Ajax (모달 전용) — 실패 횟수 제한 + 30분 잠금 적용
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

    /* ==========================================================
       🔥 2-1. 로그인 실패 횟수 & 시간 검사 (30분 제한)
    ========================================================== */
        // 🔥 로그인 실패 횟수 & 시간 변수 선언 (필수)
        int failCount = dbUser.getLogin_fail_count();
        String lastFailTime = dbUser.getLast_fail_time();

        if (
                failCount >= 5 &&
                        lastFailTime != null &&
                        !lastFailTime.equals("") &&
                        !lastFailTime.equals("null")
        ) {
            LocalDateTime lastFail = LocalDateTime.parse(
                    lastFailTime,
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
            );

            if (lastFail.isAfter(LocalDateTime.now().minusMinutes(30))) {
                result.put("result", "fail");
                result.put("message", "비밀번호 5회 실패로 로그인 제한 상태입니다.\n30분 후 다시 시도해주세요.");
                return result;
            } else {
                userService.resetFailCount(dbUser.getUser_id());
                failCount = 0;
            }
        }


    /* ==========================================================
       🔥 3) 비밀번호 불일치 시 → 실패 횟수 증가
    ========================================================== */
        if (!dbUser.getUser_password().equals(userVO.getUser_password())) {

            userService.increaseFailCount(dbUser.getUser_id());
            int newFail = failCount + 1;

            if (newFail >= 5) {
                result.put("result", "fail");
                result.put("message", "비밀번호 5회 실패로 30분간 로그인이 제한됩니다.");
                return result;
            }

            int remain = 5 - newFail;
            result.put("result", "fail");
            result.put("message", "비밀번호가 일치하지 않습니다. (남은 시도: " + remain + ")");
            return result;
        }
    /* ==========================================================
       🔥 4) 계정 상태 체크
    ========================================================== */
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

        // 🔥 5) 로그인 성공 → 실패 횟수 초기화 + 세션 저장
        userService.resetFailCount(dbUser.getUser_id());

        // 🔥 마지막 로그인 시간 저장
        userService.updateLastLoginTime(dbUser.getUser_id());

        // 🔥 🔥 🔥 로그인 기기 기록 저장
        String userAgent = ((ServletRequestAttributes) RequestContextHolder
                .currentRequestAttributes())
                .getRequest().getHeader("User-Agent");

        String deviceInfo = detectDevice(userAgent);

        // 지역 기능

        // 1) 클라이언트 IP 가져오기
        String ip = ((ServletRequestAttributes) RequestContextHolder
                .currentRequestAttributes())
                .getRequest()
                .getRemoteAddr();

        // 로컬 개발환경 → 테스트 IP 대체
        if (ip.equals("0:0:0:0:0:0:0:1") || ip.equals("127.0.0.1")) {
            ip = "1.234.5.6";  // 서울 강남구 테스트용
        }

        // 현재 지역 (대한민국 서울특별시 강남구)
        String currentLocation = getLocationFromIP(ip);

        // 이전 로그인 지역 조회
        String lastLocation = userService.getLastLocation(dbUser.getUser_id());

        // 4) login_history 저장 (지역 포함)
        userService.insertLoginHistory(dbUser.getUser_id(), deviceInfo, currentLocation);

        // 🔥 🔥 🔥 최근 로그인 기기 3개 조회
        List<String> recentDevices =
                userService.getRecentLoginDevices(dbUser.getUser_id());

        result.put("recent_devices", recentDevices);

        // 🔥 비밀번호 변경 주기(90일) 체크
        if (dbUser.getPassword_updated_at() != null) {

            LocalDateTime lastPwChange = LocalDateTime.parse(
                    dbUser.getPassword_updated_at(),
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
            );

            long days = Duration.between(lastPwChange, LocalDateTime.now()).toDays();

            if (days >= 90) {
                result.put("pw_change_alert",
                        "비밀번호 변경한 지 " + days + "일이 지났습니다! 보안을 위해 변경을 권장합니다.");
            }
        }

        // 등급 정보 가져오기
        GradeVO gradeVO = gradeService.getGradeByUser(dbUser.getUser_num());

        // 세션 저장
        session.setAttribute("gradeVO", gradeVO);
        session.setAttribute("userVO", dbUser);
        session.setAttribute("user_id", dbUser.getUser_id());
        session.setAttribute("user_name", dbUser.getUser_name());
        session.setAttribute("user_role", dbUser.getUser_role());


        // 🔥 마지막 로그인 시간 화면에서도 사용하려고 JSON으로 전송
        result.put("result", "success");
        result.put("user_name", dbUser.getUser_name());
        result.put("last_login_at", dbUser.getLast_login_at());
        result.put("recent_devices", recentDevices);
        result.put("current_location", currentLocation);
        result.put("last_location", lastLocation);

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
    8. 아이디 찾기 (페이지 이동)
 ========================================================== */
    @GetMapping("/findId")
    public String findId() {
        return "user/findId";
    }

    /* ==========================================================
       8-1. 아이디 찾기 처리 (AJAX JSON)
    ========================================================== */
    @PostMapping("/findIdPro")
    @ResponseBody
    public Map<String, Object> findIdPro(
            @RequestParam String user_name,
            @RequestParam String user_email) {

        Map<String, Object> result = new HashMap<>();

        UserVO user = userService.findIdByNameAndEmail(user_name, user_email);

        if (user == null) {
            result.put("status", "fail");
            result.put("msg", "일치하는 회원 정보를 찾을 수 없습니다.");
        } else {
            result.put("status", "success");
            result.put("user_id", user.getUser_id());
        }

        return result;
    }

    /* ==========================================================
   9. 비밀번호 찾기 (AJAX)
========================================================== */
    @GetMapping("/findPw")
    public String findPwForm() {
        return "user/findPw";
    }

    @PostMapping("/findPwPro")
    @ResponseBody  // 🔥 AJAX 응답을 JSON으로 보냄 (핵심)
    public Map<String, Object> findPwPro(
            @RequestParam("user_id") String user_id,
            @RequestParam("user_email") String user_email) throws Exception {

        Map<String, Object> result = new HashMap<>();

        // 1️⃣ 사용자 조회
        UserVO user = userService.findUserByIdAndEmail(user_id, user_email);
        if (user == null) {
            result.put("status", "fail");
            result.put("msg", "아이디 또는 이메일이 일치하지 않습니다.");
            return result;
        }

        // 2️⃣ 임시 비밀번호 생성
        String tempPw = UUID.randomUUID().toString().substring(0, 8);

        // 3️⃣ DB 업데이트
        userService.updateTempPassword(user_id, tempPw);

        // 4️⃣ 이메일 전송
        sendTempPasswordMail(user_email, tempPw);

        // 5️⃣ 성공 응답
        result.put("status", "success");
        result.put("msg", "임시 비밀번호가 이메일로 전송되었습니다.");

        return result;  // 🔥 JSP로 이동하지 않고 JSON 리턴
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

    // ==========================================
// 🔥 User-Agent → OS / Browser 판별 함수
// ==========================================
    private String detectDevice(String userAgent) {

        String os = "Unknown OS";
        String browser = "Unknown Browser";

        if (userAgent.contains("Windows")) os = "Windows";
        else if (userAgent.contains("Mac")) os = "Mac OS";
        else if (userAgent.contains("Android")) os = "Android";
        else if (userAgent.contains("iPhone")) os = "iPhone";

        if (userAgent.contains("Chrome") && !userAgent.contains("Edg/")) browser = "Chrome";
        else if (userAgent.contains("Edg/")) browser = "Edge";
        else if (userAgent.contains("Safari") && !userAgent.contains("Chrome")) browser = "Safari";
        else if (userAgent.contains("Firefox")) browser = "Firefox";

        return browser + " / " + os;
    }

    // ==========================================
    // 🔥 여기! getLocationFromIP() 넣는 위치
    // ==========================================
    // 지역 상세 분석 함수 (서울특별시 강남구까지)
    private String getLocationFromIP(String ip) {

        try {
            URL url = new URL("https://ipapi.co/" + ip + "/json/");
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            br.close();
            String json = sb.toString();

            String country = extract(json, "country_name"); // 대한민국
            String region = extract(json, "region");        // Seoul → 서울특별시
            String city = extract(json, "city");            // Gangnam-gu

            if (country == null) country = "Unknown Country";
            if (region == null) region = "Unknown Region";
            if (city == null) city = "Unknown City";

            // 한국 지역 변환
            if (country.equals("South Korea")) {
                switch (region) {
                    case "Seoul":
                        region = "서울특별시";
                        break;
                    case "Busan":
                        region = "부산광역시";
                        break;
                    case "Daegu":
                        region = "대구광역시";
                        break;
                    case "Incheon":
                        region = "인천광역시";
                        break;
                    case "Gwangju":
                        region = "광주광역시";
                        break;
                    case "Daejeon":
                        region = "대전광역시";
                        break;
                    case "Ulsan":
                        region = "울산광역시";
                        break;
                }
            }

            return country + " " + region + " " + city;

        } catch (Exception e) {
            return "Unknown";
        }
    }

    // JSON 문자열에서 값 추출
    private String extract(String json, String key) {
        try {
            int index = json.indexOf("\"" + key + "\"");
            if (index == -1) return null;

            int start = json.indexOf(":", index) + 1;
            while (json.charAt(start) == ' ' || json.charAt(start) == '"') {
                start++;
            }

            int end = start;
            while (end < json.length() &&
                    json.charAt(end) != '"' &&
                    json.charAt(end) != ',' &&
                    json.charAt(end) != '}') {
                end++;
            }

            return json.substring(start, end).replace("\"", "").trim();

        } catch (Exception e) {
            return null;
        }
    }
}




