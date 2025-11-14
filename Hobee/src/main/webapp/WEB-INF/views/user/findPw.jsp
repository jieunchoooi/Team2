<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/findPw.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="findpw-container">
  <h2>비밀번호 찾기 🔐</h2>
  <p class="desc">가입 시 등록한 이메일 주소를 입력해주세요.<br>임시 비밀번호를 이메일로 보내드립니다.</p>

  <form id="findPwForm" action="${pageContext.request.contextPath}/user/findPwPro" method="post">
    <div class="form-group">
      <label for="user_email">이메일 주소</label>
      <input type="email" id="user_email" name="user_email" placeholder="example@naver.com" required>
    </div>

    <button type="submit" class="findpw-btn">임시 비밀번호 발송</button>
  </form>

  <div class="bottom-link">
    <a href="${pageContext.request.contextPath}/user/login">로그인으로 돌아가기</a>
  </div>
</div>

<script>
$("#findPwForm").on("submit", function(e){
  const email = $("#user_email").val().trim();
  if(email === ""){
    alert("이메일을 입력해주세요.");
    e.preventDefault();
  }
});
</script>

</body>
</html>
_