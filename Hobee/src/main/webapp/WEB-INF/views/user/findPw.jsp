<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인/회원가입 모달 포함 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/findPw.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<div class="findpw-container">

  <h2>비밀번호 찾기 🔐</h2>
  <p class="desc">
    가입하신 <b>아이디</b>와 <b>이메일</b>을 입력해주세요.<br>
    일치하는 계정이 확인되면 임시 비밀번호를 발송해드립니다.
  </p>

  <!-- 메시지 출력 -->
  <c:if test="${not empty msg}">
    <p class="msg">${msg}</p>
  </c:if>

  <form id="findPwForm" action="${pageContext.request.contextPath}/user/findPwPro" method="post">

    <!-- 아이디 입력 -->
    <div class="form-group">
      <label for="user_id">아이디</label>
      <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력하세요" required>
    </div>

    <!-- 이메일 입력 -->
    <div class="form-group">
      <label for="user_email">이메일 주소</label>
      <input type="email" id="user_email" name="user_email" placeholder="example@naver.com" required>
    </div>

    <button type="submit" class="findpw-btn">임시 비밀번호 발송하기</button>
  </form>

  <!-- 🔥 로그인 모달로 돌아가기 버튼 -->
  <div class="bottom-link">
    <a href="#" id="backToLoginModal">로그인으로 돌아가기</a>
  </div>

</div>

<script>
/* ======================
   유효성 검사
====================== */
$("#findPwForm").on("submit", function(e){

  const id = $("#user_id").val().trim();
  const email = $("#user_email").val().trim();

  if(id === ""){
    alert("아이디를 입력해주세요.");
    e.preventDefault();
    return;
  }

  if(email === ""){
    alert("이메일을 입력해주세요.");
    e.preventDefault();
    return;
  }

  const emailPattern=/^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,}$/;
  if(!emailPattern.test(email)){
    alert("이메일 형식이 올바르지 않습니다.");
    e.preventDefault();
  }
});


/* ======================
   로그인 모달 열기
====================== */
$("#backToLoginModal").click(function(e){
    e.preventDefault();
    $("#loginModal").fadeIn().css("display","flex");
});
</script>

</body>
</html>
