package com.itwillbs.controller;

import java.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import javax.servlet.http.HttpSession;
import com.itwillbs.service.PaymentService;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.domain.LectureVO;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/payment/*")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    // 🔹 결제 테스트 페이지 이동
    @GetMapping("/form")
    public String paymentForm() {
        System.out.println("PaymentController paymentForm()");
        return "payment/paymentForm";  // /WEB-INF/views/payment/paymentForm.jsp
    }

  
    
    
    //키값 가져오기
    @Value("${pay.API_KEY}")
    private String apiKey;
    @Value("${pay.API_SECRET}")
    private String apiSecret;
    
    
    @PostMapping("/verify")
    @ResponseBody
    public Map<String, Object> verifyPayment(@RequestParam("imp_uid") String impUid) {
        System.out.println("✅ [verifyPayment] PortOne 결제 검증 시작");
        Map<String, Object> result = new HashMap<>();

        try {
            // ------------------------------
            // ① PortOne REST API 토큰 발급
            // ------------------------------
            RestTemplate restTemplate = new RestTemplate();
            String tokenUrl = "https://api.iamport.kr/users/getToken";

            Map<String, String> tokenParams = new HashMap<>();
            tokenParams.put("imp_key", apiKey);
            tokenParams.put("imp_secret", apiSecret);

            ResponseEntity<Map> tokenResponse =
                    restTemplate.postForEntity(tokenUrl, tokenParams, Map.class);
            String accessToken = (String) ((Map) tokenResponse.getBody().get("response")).get("access_token");

            // ------------------------------
            // ② 결제 정보 조회
            // ------------------------------
            String paymentUrl = "https://api.iamport.kr/payments/" + impUid;
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", accessToken);
            HttpEntity<Void> entity = new HttpEntity<>(headers);

            ResponseEntity<Map> paymentResponse =
                    restTemplate.exchange(paymentUrl, HttpMethod.GET, entity, Map.class);
            Map<String, Object> response = (Map<String, Object>) paymentResponse.getBody().get("response");

            // ------------------------------
            // ③ 필요한 정보 추출
            // ------------------------------
            int amount = (int) Double.parseDouble(response.get("amount").toString());
            String status = response.get("status").toString(); // "paid" | "ready" | "failed"

            System.out.println("💰 결제금액: " + amount);
            System.out.println("📦 상태: " + status);

            // ------------------------------
            // ④ 결과 반환
            // ------------------------------
            result.put("verify_result", "success");
            result.put("amount", amount);
            result.put("status", status);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("verify_result", "fail");
            result.put("message", e.getMessage());
        }

        return result;
    }

    // =========================================================
    // ✅ [2단계] 결제 완료 - 검증 성공 후 DB에 저장
    // =========================================================
    @PostMapping("/complete")
    @ResponseBody
    public Map<String, Object> completePayment(
            @RequestParam("imp_uid") String impUid,
            @RequestParam("merchant_uid") String merchantUid,
            @RequestParam("user_id") int userId,
            @SessionAttribute("lectureList") List<LectureVO> lectureList) {

        Map<String, Object> result = new HashMap<>();
        try {
            System.out.println("✅ completePayment() 실행");

            RestTemplate restTemplate = new RestTemplate();

            // 1️⃣ Access Token 발급
            HttpHeaders tokenHeaders = new HttpHeaders();
            tokenHeaders.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> tokenReq = new HashMap<>();
            tokenReq.put("imp_key", "7875022175504818");
            tokenReq.put("imp_secret", "E8qkSjLRXXjR7FQmSiyUfjt74HfkPQMZlSAf60ofV1sZaGRcNXiSOHlRrjDArletk89OAdTwSYKPuYNZ");

            HttpEntity<Map<String, String>> tokenEntity = new HttpEntity<>(tokenReq, tokenHeaders);
            ResponseEntity<Map> tokenRes = restTemplate.postForEntity(
                "https://api.iamport.kr/users/getToken", tokenEntity, Map.class);

            String accessToken = (String)((Map)tokenRes.getBody().get("response")).get("access_token");

            // 2️⃣ 결제 정보 조회
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", accessToken);
            HttpEntity<Void> entity = new HttpEntity<>(headers);

            ResponseEntity<Map> paymentRes = restTemplate.exchange(
                "https://api.iamport.kr/payments/" + impUid,
                HttpMethod.GET, entity, Map.class);

            Map<String, Object> response = (Map<String, Object>) paymentRes.getBody().get("response");

            int amount = ((Number) response.get("amount")).intValue();
            String status = (String) response.get("status");

            // 3️⃣ PaymentVO 세팅 (한 번 결제 전체)
            PaymentVO paymentVO = new PaymentVO();
            paymentVO.setUser_num(userId);
            paymentVO.setAmount(amount);          // ✅ 전체 금액
            paymentVO.setStatus(status);          // ✅ 결제 상태
            paymentVO.setImp_uid(impUid);
            paymentVO.setMerchant_uid(merchantUid);
            paymentVO.setUsed_points(0);
            paymentVO.setSaved_points(0);

            // 4️⃣ 결제 및 다중 수강등록
            paymentService.processPayment(paymentVO, lectureList);

            result.put("status", "success");
            result.put("amount", amount);
            result.put("payment_status", status);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "fail");
            result.put("message", e.getMessage());
        }

        return result;
    }

    
    
    // =========================================================
    // ✅ [3단계] 결제 완료 페이지 이동
    // =========================================================
    @GetMapping("/success")
    public String paymentSuccess() {
        return "payment/paymentSuccess";
    }

    // 결제 실패 시
    @GetMapping("/fail")
    public String paymentFail() {
        return "payment/paymentFail";
    }



}
