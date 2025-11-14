<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 🔹 로그인 모달 -->
<div id="loginModal" class="modal" style="display:none;">
  <div class="modal-overlay"></div>
  <div class="modal-content">
    <button type="button" class="close-btn">&times;</button>
    <h2>로그인</h2>
    <form id="loginForm">
      <div class="form-group">
        <input type="text" name="user_id" placeholder="아이디" required />
      </div>
      <div class="form-group">
        <input type="password" name="user_password" placeholder="비밀번호" required />
      </div>
      <div id="loginError" class="error-text"></div>
      <button type="button" id="loginBtn" class="btn-primary">로그인</button>
    </form>
    <div class="modal-footer">
      <p>아직 회원이 아니신가요?
        <a href="${pageContext.request.contextPath}/user/join">회원가입</a>
      </p>
    </div>
  </div>
</div>

<!-- ✅ 외부 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/loginModal.css">
