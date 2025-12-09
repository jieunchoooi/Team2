<%@ page contentType="text/html; charset=UTF-8" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<!-- loginModal.jsp -->
<div id="loginModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="login-modal-content">

        <span class="login-close">×</span>

        <h2 class="login-title">로그인</h2>

        <form id="loginForm">

            <input type="text" name="user_id" class="login-input" placeholder="아이디">
         <div class="pw-row">
   			<input type="password" name="user_password" id="login_pw" class="login-input" placeholder="비밀번호">
<!--     		<span id="togglePw" class="pw-icon">👁</span> -->
		</div>


            <button type="button" id="loginBtn" class="login-submit-btn">로그인</button>
            
            <div id="loginSpinner" class="spinner" style="display:none;"></div>

            <div id="loginError" class="error-msg"></div>

            <div class="login-links">
   				 <a href="${pageContext.request.contextPath}/user/findId" class="login-link-item">🔍 아이디 찾기</a>
    			 <span class="sep">|</span>
    			 <a href="${pageContext.request.contextPath}/user/findPw" class="login-link-item">🔐 비밀번호 찾기</a>
    			 <span class="sep">|</span>
    			 <a href="#" class="openInsertFromLogin login-link-item">📝 회원가입</a>
			</div>


        </form>

    </div>
</div>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/loginModal.css">