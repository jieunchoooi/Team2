<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 성공 | Hobee</title>

<style>
/* =========================================
   🔥 전체 화면을 뒤덮는 모달 오버레이
========================================= */
.modal-overlay {
  position: fixed;
  top: 0; 
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0,0,0,0.45);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

/* =========================================
   🔥 중앙 모달 박스
========================================= */
.success-box {
  width: 460px;
  background: #fff;
  padding: 50px 40px;
  border-radius: 20px;
  text-align: center;
  animation: fadeIn .5s ease;
  box-shadow: 0 8px 30px rgba(0,0,0,0.2);
}

/* 체크 아이콘 */
.checkmark {
  width: 85px;
  height: 85px;
  margin: 0 auto 25px auto;
  border-radius: 50%;
  background: #7d89f7;
  display: flex;
  justify-content: center;
  align-items: center;
  animation: scaleUp .4s ease;
  box-shadow: 0 6px 15px rgba(125,137,247,0.4);
}

.checkmark svg {
  width: 45px;
  height: 45px;
  color: #fff;
}

/* 텍스트 */
.success-box h1 {
  font-size: 1.7rem;
  font-weight: 700;
  margin-bottom: 12px;
  color: #333;
}

.success-box p {
  font-size: 1.05rem;
  color: #555;
  margin-bottom: 28px;
}

#countdown {
  color: #7d89f7;
  font-weight: 700;
}

/* 버튼 */
.success-box button {
  padding: 12px 25px;
  background: #7d89f7;
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1rem;
  cursor: pointer;
  transition: .2s;
}

.success-box button:hover {
  background: #636eea;
}

/* 애니메이션 */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes scaleUp {
  from { transform: scale(0.5); opacity: 0; }
  to   { transform: scale(1); opacity: 1; }
}
</style>

<script>
/* =========================================
   🔥 3초 카운트다운 후 자동 이동
========================================= */
let counter = 3;
window.onload = function() {
  const countdownElement = document.getElementById("countdown");

  const timer = setInterval(() => {
    counter--;
    countdownElement.innerText = counter;

    if (counter === 0) {
      clearInterval(timer);
      goMyClassroom();
    }
  }, 1000);
};

/* 즉시 이동 버튼 */
function goMyClassroom() {
  location.href = "${pageContext.request.contextPath}/member/my_classroom";
}
</script>

</head>

<body>

<%-- ======================================
     🔥 모달 형태의 결제 성공 박스
====================================== --%>
<div class="modal-overlay">

  <div class="success-box">

    <div class="checkmark">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor"
           stroke-width="3" viewBox="0 0 24 24">
        <path d="M20 6L9 17l-5-5"></path>
      </svg>
    </div>

    <h1>결제가 성공적으로 완료되었습니다!</h1>

    <p>
      <strong id="countdown">3</strong>초 후  
      <strong>내 강의실</strong>로 이동합니다.
    </p>

    <button onclick="goMyClassroom()">즉시 이동하기</button>

  </div>

</div>

</body>
</html>
