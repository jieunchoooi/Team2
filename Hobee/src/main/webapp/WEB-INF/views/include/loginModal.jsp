<%@ page contentType="text/html; charset=UTF-8" %>

<!-- loginModal.jsp -->
<div id="loginModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="login-modal-content">

        <span class="login-close">×</span>

        <h2 class="login-title">로그인</h2>

        <form id="loginForm">

            <input type="text" name="user_id" class="login-input" placeholder="아이디">
            <input type="password" name="user_password" class="login-input" placeholder="비밀번호">

            <button type="button" id="loginBtn" class="login-submit-btn">로그인</button>

            <div id="loginError" class="error-msg"></div>

            <div class="login-links">
                <a href="${pageContext.request.contextPath}/user/findId">아이디 찾기</a> |
                <a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기</a> |
                <a href="#" class="openInsertFromLogin">회원가입</a>
            </div>

        </form>

    </div>
</div>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/loginModal.css">
