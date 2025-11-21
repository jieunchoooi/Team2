<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 성공 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">

<style>
/* =========================================
   Hobee Payment Success Style (Premium)
========================================= */
body {
  background: #f7f8fc;
  margin: 0;
  padding: 0;
  font-family: 'Pretendard', sans-serif;
}

.success-wrap {
  max-width: 560px;
  margin: 140px auto 60px auto;
  background: #ffffff;
  border-radius: 24px;
  padding: 60px 50px;
  text-align: center;
  box-shadow: 0 8px 30px rgba(0,0,0,0.07);
  animation: fadeIn 0.8s ease;
}

/* 체크 아이콘 애니메이션 */
.checkmark {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background: #7d89f7;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 30px auto;
  box-shadow: 0 6px 15px rgba(125,137,247,0.4);
  animation: scaleUp 0.4s ease forwards;
}

.checkmark svg {
  width: 48px;
  height: 48px;
  color: white;
}

.success-wrap h1 {
  font-size: 2rem;
  font-weight: 700;
  margin: 0 0 12px 0;
  color: #333;
}

.success-wrap p {
  font-size: 1.1rem;
  color: #555;
  margin-bottom: 35px;
}

.countdown {
  font-weight: 700;
  color: #7d89f7;
}

/* 즉시 이동 버튼 */
.success-wrap button {
  background: #7d89f7;
  color: white;
  padding: 14px 30px;
  border-radius: 12px;
  font-size: 1.05rem;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: 0.2s;
}

.success-wrap button:hover {
  background: #636eea;
}

/* 애니메이션 */
@keyframes fadeIn {
  from { opacity:0; transform: translateY(20px); }
  to   { opacity:1; transform: translateY(0); }
}

@keyframes scaleUp {
  from { transform: scale(0.5); opacity: 0; }
  to   { transform: scale(1); opacity: 1; }
}
</style>

<script>
// =======================================
//   3초 카운트다운 후 자동 이동
// =======================================
let counter = 3;

window.onload = function() {
  const countdownElement = document.getElementById("countdown");
  const interval = setInterval(() => {
    counter--;
    countdownElement.innerText = counter;

    if (counter === 0) {
      clearInterval(interval);
      location.href = "${pageContext.request.contextPath}/member/my_classroom";
    }
  }, 1000);
};

function goNow() {
  location.href = "${pageContext.request.contextPath}/member/my_classroom";
}
</script>
</head>

<body>

<jsp:include page="../include/header.jsp" />

<main>
  <div class="success-wrap">
    
    <%-- 🔵 체크마크 아이콘 (SVG) --%>
    <div class="checkmark">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
        <path d="M20 6L9 17l-5-5"></path>
      </svg>
    </div>

    <h1>결제가 성공적으로 완료되었습니다!</h1>

    <p>
      <strong id="countdown">3</strong>초 후 
      <strong>내 강의실</strong>로 이동합니다.
    </p>

    <button onclick="goNow()">즉시 이동하기</button>

  </div>
</main>

</body>
</html>
