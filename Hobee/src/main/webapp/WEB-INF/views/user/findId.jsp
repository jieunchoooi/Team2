<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/findId.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<div class="findid-container">

  <h2>아이디 찾기 🔍</h2>
  <p class="desc">
    가입 시 사용한 <b>이름</b>과 <b>이메일 주소</b>를 입력해주세요.<br>
    일치하는 계정이 있다면 아이디를 알려드립니다.
  </p>

  <!-- 메시지 -->
  <c:if test="${not empty msg}">
    <p class="msg">${msg}</p>
  </c:if>

  <form id="findIdForm" action="${pageContext.request.contextPath}/user/findIdPro" method="post">

    <!-- 이름 입력 -->
    <div class="form-group">
      <label for="user_name">이름</label>
      <input type="text" id="user_name" name="user_name" placeholder="이름을 입력하세요" required>
    </div>

    <!-- 이메일 입력 -->
    <div class="form-group">
      <label for="user_email">이메일 주소</label>
      <input type="email" id="user_email" name="user_email" placeholder="example@naver.com" required>
    </div>

    <button type="submit" class="findid-btn">아이디 찾기</button>
  </form>

  <div class="bottom-link">
    <!-- 🔥 로그인 페이지 이동 → 모달 열기로 변경 -->
    <a href="${pageContext.request.contextPath}/main/main?openLogin=true">
    로그인으로 돌아가기
	</a>

  </div>
</div>

<script>
$("#findIdForm").on("submit", function(e){
  
  const name = $("#user_name").val().trim();
  const email = $("#user_email").val().trim();

  if(name === ""){
    alert("이름을 입력해주세요.");
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

</script>

</body>
</html>
