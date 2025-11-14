<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 🔹 로그인 모달 -->
<div id="loginModal" class="modal" style="display:none;">
  <div class="modal-overlay" onclick="closeLoginModal()"></div>

  <div class="modal-content">
    <span class="close-btn" onclick="closeLoginModal()">&times;</span>

    <h2 class="modal-title">로그인</h2>

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
      <a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기</a>
      |
      <a href="${pageContext.request.contextPath}/user/insert">회원가입</a>

    </div>
  </div>
</div>

<!-- ✅ 외부 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/loginModal.css">
