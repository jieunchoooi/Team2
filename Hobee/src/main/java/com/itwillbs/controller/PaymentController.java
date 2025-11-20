	package com.itwillbs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession; // ✅ jakarta → javax 로 수정

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.GradeVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.PaymentService;

/**
 * PaymentController
 * -----------------------------
 * 결제 요청 → 검증 → DB 저장 → 완료 페이지 이동
 */
@Controller
@RequestMapping("/payment/*")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Value("${pay.API_KEY}")
    private String apiKey;

    @Value("${pay.API_SECRET}")
    private String apiSecret;
    
   
    // ✅ 결제 페이지 이동
    @GetMapping("/form")
    public String paymentForm() {
        return "payment/paymentForm";
    }

    @PostMapping("/verify")
    @ResponseBody
    public Map<String, Object> verifyPayment(@RequestParam("imp_uid") String impUid) {
        Map<String, Object> result = new HashMap<>();
        RestTemplate restTemplate = new RestTemplate();

        System.out.println("🟢 [verifyPayment] 결제 검증 시작");
        System.out.println("📦 imp_uid: " + impUid);
        System.out.println("🔑 PortOne API Key Loaded: " + safeKey(apiKey));
        System.out.println("🔒 PortOne API Secret Loaded: " + safeKey(apiSecret));

        try {
            // ✅ 1️⃣ Access Token 발급 (JSON 형식 보장)
            String tokenUrl = "https://api.iamport.kr/users/getToken";
            HttpHeaders tokenHeaders = new HttpHeaders();
            tokenHeaders.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> tokenBody = new HashMap<>();
            tokenBody.put("imp_key", apiKey);
            tokenBody.put("imp_secret", apiSecret);

            // 🔍 ObjectMapper로 강제 JSON 직렬화
            ObjectMapper mapper = new ObjectMapper();
            String jsonBody = mapper.writeValueAsString(tokenBody);
            System.out.println("📤 Token Request JSON: " + jsonBody);

            HttpEntity<String> tokenEntity = new HttpEntity<>(jsonBody, tokenHeaders);
            ResponseEntity<Map> tokenResp = restTemplate.postForEntity(tokenUrl, tokenEntity, Map.class);

            System.out.println("📡 Token Response Status: " + tokenResp.getStatusCode());
            System.out.println("📡 Token Response Body: " + tokenResp.getBody());

            if (tokenResp.getBody() == null) return fail(result, "토큰 응답이 비어있습니다.");

            Object codeObj = tokenResp.getBody().get("code");
            if (!(codeObj instanceof Number) || ((Number) codeObj).intValue() != 0) {
                return fail(result, "토큰 발급 실패: " + tokenResp.getBody().get("message"));
            }

            Map respMap = (Map) tokenResp.getBody().get("response");
            if (respMap == null || respMap.get("access_token") == null) return fail(result, "access_token 없음");

            String accessToken = String.valueOf(respMap.get("access_token"));
            System.out.println("✅ Access Token 발급 성공 (길이=" + accessToken.length() + "): " + safeKey(accessToken));

            // ✅ 2️⃣ 결제 정보 조회
            String paymentUrl = "https://api.iamport.kr/payments/" + impUid;
            HttpHeaders payHeaders = new HttpHeaders();
            payHeaders.set("Authorization", accessToken);

            HttpEntity<Void> payEntity = new HttpEntity<>(payHeaders);
            ResponseEntity<Map> payResp = restTemplate.exchange(paymentUrl, HttpMethod.GET, payEntity, Map.class);

            System.out.println("📡 Payment Response Status: " + payResp.getStatusCode());
            System.out.println("📡 Payment Response Body: " + payResp.getBody());

            if (payResp.getBody() == null) return fail(result, "결제 조회 응답이 비어있습니다.");

            Object pCodeObj = payResp.getBody().get("code");
            if (!(pCodeObj instanceof Number) || ((Number) pCodeObj).intValue() != 0) {
                return fail(result, "결제 조회 실패: " + payResp.getBody().get("message"));
            }

            Map payment = (Map) payResp.getBody().get("response");
            if (payment == null) return fail(result, "결제 조회 response 없음");

            int amount = ((Number) payment.get("amount")).intValue();
            String status = String.valueOf(payment.get("status"));
            String merchantUid = String.valueOf(payment.get("merchant_uid"));
            String impUidResp = String.valueOf(payment.get("imp_uid"));

            System.out.println("🧾 결제 금액: " + amount + ", 상태: " + status);
            System.out.println("🧾 merchant_uid=" + merchantUid + ", imp_uid=" + impUidResp);

            result.put("verify_result", "success");
            result.put("amount", amount);
            result.put("status", status);
            result.put("merchant_uid", merchantUid);
            result.put("imp_uid", impUidResp);

            System.out.println("🔚 [verifyPayment] 정상 종료");
            return result;

        } catch (HttpClientErrorException e) {
            System.out.println("❌ HTTP 오류: " + e.getStatusCode());
            System.out.println("❌ 응답 본문: " + e.getResponseBodyAsString());
            return fail(result, "HTTP 오류: " + e.getStatusCode() + " / " + e.getResponseBodyAsString());
        } catch (Exception e) {
            System.out.println("❌ 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return fail(result, "예외: " + e.getMessage());
        }
    }

    // 실패 처리 공통
    private Map<String, Object> fail(Map<String, Object> ret, String msg) {
        ret.put("verify_result", "fail");
        ret.put("message", msg);
        System.out.println("⚠️ [verifyPayment] " + msg);
        System.out.println("🔚 [verifyPayment] 종료");
        return ret;
    }

    // 키/토큰 일부만 출력
    private String safeKey(String s) {
        if (s == null) return "null";
        int n = s.length();
        if (n <= 6) return "***";
        return s.substring(0, Math.min(6, n)) + "...(" + n + ")";
    }



    /**
    * ✅ 결제 완료 처리 (검증 이후 호출)
    */
   @PostMapping("/payment/complete")
   @ResponseBody
   public Map<String, Object> completePayment(
           @ModelAttribute PaymentVO paymentVO,
           @ModelAttribute GradeVO gradeVO,
           @RequestParam("lectureNums") List<Integer> lectureNums) {

       Map<String, Object> result = new HashMap<>();

       System.out.println("🟢 [PaymentController] 결제 완료 요청 도착");
       System.out.println("📦 imp_uid=" + paymentVO.getImp_uid());
       System.out.println("📦 merchant_uid=" + paymentVO.getMerchant_uid());
       System.out.println("📦 amount=" + paymentVO.getAmount());
       System.out.println("📦 lectureNums=" + lectureNums);
       System.out.println("📦 grade 할인율=" + gradeVO.getDiscount_rate() + "%, 적립률=" + gradeVO.getReward_rate() + "%");

       try {
           // ✅ 서비스 호출 (중복 체크, 포인트 처리, 수강 등록 등)
           paymentService.processPayment(paymentVO, lectureNums, gradeVO);

           result.put("status", "success");
           result.put("message", "결제가 정상 처리되었습니다.");
           System.out.println("✅ [PaymentController] 결제 프로세스 완료");

       } catch (IllegalStateException e) {
           // 중복 결제 등 로직상 예외
           result.put("status", "duplicate");
           result.put("message", e.getMessage());
           System.out.println("⚠️ [PaymentController] " + e.getMessage());

       } catch (Exception e) {
           // 기타 오류
           result.put("status", "fail");
           result.put("message", "결제 처리 중 오류 발생: " + e.getMessage());
           e.printStackTrace();
       }

       return result;
   }
    
    // ✅ 결제 성공 페이지 이동
    @GetMapping("/success")
    public String paymentSuccess() {
        return "payment/paymentSuccess";
    }

    // ✅ 결제 실패 페이지 이동
    @GetMapping("/fail")
    public String paymentFail() {
        return "payment/paymentFail";
    }
    
    @GetMapping("/test/tx")
    public String txTest() {
        try {
            paymentService.testTransaction();
        } catch (Exception e) {
            System.out.println("💥 예외 발생 → 롤백 확인 필요");
        }
        return "redirect:/main/main";
    }
    
    
    @PostMapping("/refund")
    @ResponseBody
    public Map<String, Object> refundPayment(@ModelAttribute PaymentVO paymentVO) {

        Map<String, Object> result = new HashMap<>();

        try {

            System.out.println("🟣 환불 요청: payment_id = " + paymentVO.getPayment_id());

            // 1) 기존 결제 정보 조회 (created_at, imp_uid 등 필요)
            PaymentVO original = paymentService.getPayment(paymentVO.getPayment_id());
            if (original == null) {
                result.put("status", "fail");
                result.put("message", "결제 정보를 찾을 수 없습니다.");
                return result;
            }

            // 2) 3일 이내 환불 가능 여부 체크
            if (!paymentService.isRefundable(original.getCreated_at())) {
                result.put("status", "fail");
                result.put("message", "결제일 기준 3일이 지나 환불이 불가능합니다.");
                return result;
            }

            // 3) 포트원 Access Token 발급
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders tokenHeaders = new HttpHeaders();
            tokenHeaders.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> tokenReq = new HashMap<>();
            tokenReq.put("imp_key", apiKey);
            tokenReq.put("imp_secret", apiSecret);

            HttpEntity<Map<String, String>> tokenEntity = new HttpEntity<>(tokenReq, tokenHeaders);

            ResponseEntity<Map> tokenRes = restTemplate.postForEntity(
                    "https://api.iamport.kr/users/getToken",
                    tokenEntity,
                    Map.class	
            );

            String accessToken =
                (String)((Map)tokenRes.getBody().get("response")).get("access_token");

            // 4) 포트원 실제 환불 요청
            HttpHeaders refundHeaders = new HttpHeaders();
            refundHeaders.setContentType(MediaType.APPLICATION_JSON);
            refundHeaders.set("Authorization", accessToken);

            Map<String, Object> refundReq = new HashMap<>();
            refundReq.put("imp_uid", original.getImp_uid());
            refundReq.put("reason", "사용자 요청 환불");

            HttpEntity<Map<String, Object>> refundEntity =
                    new HttpEntity<>(refundReq, refundHeaders);

            ResponseEntity<Map> refundRes = restTemplate.postForEntity(
                    "https://api.iamport.kr/payments/cancel",
                    refundEntity,
                    Map.class
            );

            Map<String, Object> refundResponse = (Map<String, Object>) refundRes.getBody();

            int code = (int) refundResponse.get("code");

            if (code != 0) {
                result.put("status", "fail");
                result.put("message", "포트원 환불 실패: " + refundResponse.get("message"));
                return result;
            }

            System.out.println("🟢 포트원 환불 성공");

            // 5) 실제 DB 환불 처리 → 트랜잭션 적용됨
            paymentService.refundPayment(original);

            result.put("status", "success");
            result.put("message", "환불이 완료되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "fail");
            result.put("message", "서버 오류가 발생했습니다.");
        }

        return result;
    }
    
   
}
