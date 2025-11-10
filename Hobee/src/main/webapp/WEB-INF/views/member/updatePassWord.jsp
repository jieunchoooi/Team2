<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>본인 확인 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/updatePassWord.css">
</head>
<body>
<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<!-- 메인 콘텐츠 -->
<main>
  <section class="verify-container">
    <div class="verify-box">
      <div class="verify-icon">
        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
        </svg>
      </div>
      
      <h1>본인 확인</h1>
      <p class="verify-description">회원정보 수정을 위해 비밀번호를 입력해주세요.</p>
      
      <form id="verifyForm" action="${pageContext.request.contextPath}/member/updatePasswordPro" method="post">
        <div class="form-group">
          <label for="user_id">아이디</label>
          <input type="text" id="user_id" name="user_id" value="${user.user_id}" readonly>
        </div>
        
        <div class="form-group">
          <label for="user_password">비밀번호</label>
          <input type="password" id="user_password" name="user_password" placeholder="비밀번호를 입력하세요" autofocus>
        </div>
        
        <c:if test="${not empty error}">
          <div class="error-message">
            ${error}
          </div>
        </c:if>
        
        <button type="submit" class="btn-verify">확인</button>
        <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
      </form>
    </div>
  </section>
</main>

<script>
// 폼 제출 전 유효성 검사
document.getElementById('verifyForm').addEventListener('submit', function(e) {
    const password = document.getElementById('user_password').value.trim();
    
    if (!password) {
        e.preventDefault();
        alert('비밀번호를 입력해주세요.');
        document.getElementById('user_password').focus();
        return false;
    }

});
</script>
</body>
</html>