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
import com.itwillbs.domain.PaymentDetailVO;
import com.itwillbs.domain.PaymentResultVO;
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
     * ✅ 결제 완료 처리 (검증 이후 AJAX로 호출)
     */
    @PostMapping("/complete")
    @ResponseBody
    public Map<String, Object> completePayment(
            @ModelAttribute PaymentVO paymentVO,
            @ModelAttribute GradeVO gradeVO,
            @RequestParam("lectureNums") List<Integer> lectureNums,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();

        UserVO userVO = (UserVO) session.getAttribute("userVO");
        if (userVO == null) {
            res.put("status", "fail");
            res.put("message", "로그인이 필요합니다.");
            return res;
        }

        paymentVO.setUser_num(userVO.getUser_num());

        PaymentResultVO paymentResultVO = paymentService.processPayment(paymentVO, lectureNums, gradeVO);

        // 🔥 최신 userVO 세션에 저장 (Controller는 DB 몰라도 됨)
        session.setAttribute("userVO", paymentResultVO.getUpdatedUserVO());

        res.put("status", paymentResultVO.isSuccess() ? "success" : "fail");
        res.put("message", paymentResultVO.getMessage());

        if (paymentResultVO.isGradeChanged()) {
            String msg = paymentResultVO.isGradeUp()
                    ? "🎉 축하합니다! [" + paymentResultVO.getNewGradeName() + "] 등급으로 승급되었습니다!"
                    : "⚠️ 등급이 [" + paymentResultVO.getNewGradeName() + "] 등급으로 조정되었습니다.";

            res.put("gradeMessage", msg);
        }

        return res;
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
    
    
    @PostMapping("/refund/verify")
    @ResponseBody
    public Map<String, Object> verifyRefund(
            @RequestParam("payment_id") int paymentId,
            @RequestParam(value = "lecture_num", required = false) Integer lectureNum) {

        Map<String, Object> result = new HashMap<>();

        System.out.println("🟣 [RefundVerify] 요청 도착 payment_id=" + paymentId + ", lecture_num=" + lectureNum);

        try {
            // 1️⃣ 기본 결제 정보 조회
            PaymentVO paymentVO = paymentService.getPayment(paymentId);
            if (paymentVO == null) {
                result.put("verify_result", "fail");
                result.put("message", "결제 정보를 찾을 수 없습니다.");
                return result;
            }

            // 2️⃣ 3일 환불 제한 검사
            if (!paymentService.isRefundable(paymentVO.getCreated_at())) {
                result.put("verify_result", "fail");
                result.put("message", "결제일 기준 3일이 지나 환불이 불가능합니다.");
                return result;
            }

            // 디폴트는 전체 환불
            String refundType = "full";
            int refundAmount = paymentVO.getAmount();
            PaymentDetailVO detail = null;

            // 🔥 부분 환불인 경우
            if (lectureNum != null) {
                refundType = "partial";
                int ln = lectureNum; // ✔ null 아님 → auto-unboxing 안전
                // 해당 강의의 결제 상세 조회
                detail = paymentService.getPaymentDetailByPaymentAndLecture(paymentId, ln);
             
              

                if (detail == null) {
                    result.put("verify_result", "fail");
                    result.put("message", "부분 환불 대상 강의를 찾을 수 없습니다.");
                    return result;
                }

                if (!"PAID".equalsIgnoreCase(detail.getStatus())) {
                    result.put("verify_result", "fail");
                    result.put("message", "이미 환불 처리된 강의입니다.");
                    return result;
                }

                refundAmount = detail.getSale_price();
            }

            // 3️⃣ 포트원 Access Token 발급
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders tokenHeaders = new HttpHeaders();
            tokenHeaders.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> tokenBody = new HashMap<>();
            tokenBody.put("imp_key", apiKey);
            tokenBody.put("imp_secret", apiSecret);

            HttpEntity<Map<String, String>> tokenEntity = new HttpEntity<>(tokenBody, tokenHeaders);
            ResponseEntity<Map> tokenResponse = restTemplate.postForEntity(
                    "https://api.iamport.kr/users/getToken",
                    tokenEntity,
                    Map.class
            );

            if (tokenResponse.getBody() == null || tokenResponse.getBody().get("response") == null) {
                return fail(result, "포트원 토큰 발급 실패");
            }

            Map tokenResp = (Map) tokenResponse.getBody().get("response");
            String accessToken = (String) tokenResp.get("access_token");

            // 4️⃣ 포트원 결제 상태 조회
            HttpHeaders payHeaders = new HttpHeaders();
            payHeaders.set("Authorization", accessToken);

            HttpEntity<Void> payEntity = new HttpEntity<>(payHeaders);
            ResponseEntity<Map> payResponse = restTemplate.exchange(
                    "https://api.iamport.kr/payments/" + paymentVO.getImp_uid(),
                    HttpMethod.GET,
                    payEntity,
                    Map.class
            );

            if (payResponse.getBody() == null || payResponse.getBody().get("response") == null) {
                return fail(result, "포트원 결제 상태 조회 실패");
            }

            Map payResp = (Map) payResponse.getBody().get("response");
            String paymentStatus = (String) payResp.get("status");

            if (!"paid".equalsIgnoreCase(paymentStatus)) {
                result.put("verify_result", "fail");
                result.put("message", "이미 취소되었거나 환불된 결제입니다.");
                return result;
            }

            // 🎉 모두 통과 → 환불 가능
            result.put("verify_result", "success");
            result.put("refund_type", refundType);
            result.put("refund_amount", refundAmount);
            result.put("message", "환불 가능");

            System.out.println("✅ [RefundVerify] 환불 가능 확인 완료");

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            result.put("verify_result", "fail");
            result.put("message", "환불 검증 중 오류: " + e.getMessage());
            return result;
        }
    }

    
    /**
     * ✅ 환불 완료 처리 (포트원 refund/verify 성공 이후 AJAX로 호출)
     */
    @PostMapping("/refund/complete")
    @ResponseBody
    public Map<String, Object> completeRefund(
            @RequestParam("payment_id") int paymentId,
            @RequestParam("type") String type,              // full / partial
            @RequestParam(value = "lecture_num", required = false) Integer lectureNum,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();

        UserVO userVO = (UserVO) session.getAttribute("userVO");
        if (userVO == null) {
            res.put("status", "fail");
            res.put("message", "로그인이 필요합니다.");
            return res;
        }

        int userNum = userVO.getUser_num();

        PaymentResultVO resultVO;

        try {
            // 🔥 내부 정산 로직은 Service로만 위임
            if ("full".equalsIgnoreCase(type)) {
                resultVO = paymentService.refundFull(userNum, paymentId);
            } else if ("partial".equalsIgnoreCase(type)) {
                if (lectureNum == null) {
                    res.put("status", "fail");
                    res.put("message", "부분 환불에 필요한 강의 정보가 없습니다.");
                    return res;
                }
                resultVO = paymentService.refundPartial(userNum, paymentId, lectureNum);
            } else {
                res.put("status", "fail");
                res.put("message", "알 수 없는 환불 타입입니다.");
                return res;
            }

        } catch (IllegalStateException e) {
            // 비즈니스 로직에서 던진 예외
            res.put("status", "fail");
            res.put("message", e.getMessage());
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            res.put("status", "fail");
            res.put("message", "환불 처리 중 오류가 발생했습니다.");
            return res;
        }

        // 🔥 내부 로직 자체에서 실패 처리한 경우
        if (!resultVO.isSuccess()) {
            res.put("status", "fail");
            res.put("message", resultVO.getMessage());
            return res;
        }

        // 🔥 최신 userVO 세션에 저장 (결제 complete와 동일)
        session.setAttribute("userVO", resultVO.getUpdatedUserVO());

        res.put("status", "success");
        res.put("message", resultVO.getMessage());

        // 등급 메시지 구성 (결제 complete와 동일 패턴)
        if (resultVO.isGradeChanged()) {
            String msg = resultVO.isGradeUp()
                    ? "🎉 환불 이후에도 [" + resultVO.getNewGradeName() + "] 등급으로 유지/승급되었습니다."
                    : "⚠️ 환불 처리로 등급이 [" + resultVO.getNewGradeName() + "] 등급으로 조정되었습니다.";

            res.put("gradeMessage", msg);
        }

        return res;
    }


    
   
}
