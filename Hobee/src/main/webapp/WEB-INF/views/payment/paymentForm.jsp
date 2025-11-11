<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hobee 결제 테스트 (카카오페이)</title>

  <!-- jQuery & PortOne SDK -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #f9fafc;
      color: #333;
      text-align: center;
      padding-top: 100px;
    }
    button {
      padding: 12px 30px;
      border: none;
      border-radius: 6px;
      background-color: #ffb400;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s;
    }
    button:hover { background-color: #ffa000; }
  </style>
</head>
<body>

  <h2>💳 Hobee 포트원 결제 테스트 (카카오페이)</h2>
  <p>테스트 결제 금액: <strong>10,000원</strong></p>
  <button id="payBtn">카카오페이로 결제하기</button>

  <script>
    // ✅ PortOne 초기화
    IMP.init("imp77215860"); // PortOne 가맹점 식별코드

    $("#payBtn").click(function() {
      IMP.request_pay({
        pg: "kakaopay.TC0ONETIME",   // ✅ 카카오페이 테스트용 PG코드
        pay_method: "kakaopay",
        merchant_uid: "mid_" + new Date().getTime(), // 주문번호(고유값)
        name: "Hobee 온라인 클래스 결제",
        amount: 10000,
        buyer_email: "test@hobee.com",
        buyer_name: "홍길동",
        buyer_tel: "010-1111-2222"
      }, function (rsp) {
        console.log("✅ PortOne 응답:", rsp);

        if (rsp.success) {
          // ✅ 서버 검증 요청
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/payment/verify",  // ✅ 동적 contextPath 적용
            data: { 
              imp_uid: rsp.imp_uid,
              merchant_uid: rsp.merchant_uid,
              user_id: 1 // 🔹 테스트용 사용자 ID
            },
            success: function(res) {
              console.log("✅ 서버 검증 결과:", res);
              if (res.status === "success") {
                alert("결제 완료: " + res.amount + "원");
                location.href = "${pageContext.request.contextPath}/payment/success";  // ✅ 동적 경로
              } else {
                alert("결제 검증 실패\n사유: " + (res.message || "서버 검증 실패"));
                location.href = "${pageContext.request.contextPath}/payment/fail";     // ✅ 동적 경로
              }
            },
            error: function(xhr, status, error) {
              console.error("❌ 서버 검증 오류:", status, error);
              alert("서버 검증 실패 (응답 없음 또는 오류)");
              location.href = "${pageContext.request.contextPath}/payment/fail";       // ✅ 동적 경로
            }
          });
        } else {
          alert("결제 실패: " + rsp.error_msg);
        }
      });
    });
  </script>

</body>
</html>
