<%@ page contentType="text/html; charset=UTF-8" %>

<!-- insertModal.jsp -->
<div id="insertModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="insert-modal-content">

        <span class="insert-close">×</span>

        <h2 class="insert-title">회원가입</h2>

        <form id="insertForm">

            <label>아이디</label>
            <div class="input-row">
                <input type="text" id="ins_user_id" name="user_id" class="insert-input">
                <button type="button" id="ins_checkIdBtn" class="check-btn">중복확인</button>
            </div>
            <div id="ins_idCheckMsg" class="msg"></div>

            <label>비밀번호</label>
            <input type="password" id="ins_user_password" name="user_password" class="insert-input">

            <label>비밀번호 확인</label>
            <input type="password" id="ins_user_password2" class="insert-input">

            <label>이름</label>
            <input type="text" id="ins_user_name" name="user_name" class="insert-input">

            <label>이메일</label>
            <div class="input-row">
                <input type="text" id="ins_user_email" name="user_email" class="insert-input">
                <button type="button" id="ins_checkEmailBtn" class="check-btn">중복확인</button>
            </div>
            <div id="ins_emailCheckMsg" class="msg"></div>

            <label>전화번호</label>
            <input type="text" id="ins_user_phone" name="user_phone" class="insert-input">

            <label>주소</label>
            <input type="text" id="ins_user_address" name="user_address" class="insert-input">

            <label>성별</label>
            <select id="ins_user_gender" name="user_gender" class="insert-input">
                <option value="">선택</option>
                <option value="Male">남성</option>
                <option value="Female">여성</option>
            </select>

            <!-- 약관 -->
            <div class="insert-agree-box">
                <label><input type="checkbox" id="ins_agreeAll"> 전체동의</label>
                <label><input type="checkbox" class="ins-agree-item" required> 이용약관 동의(필수)</label>
                <label><input type="checkbox" class="ins-agree-item" required> 개인정보동의(필수)</label>
            </div>

            <div id="insertError" class="error-msg"></div>
            <div id="insertSuccess" class="success-msg"></div>

            <button type="button" id="insertBtn" class="insert-submit-btn">회원가입</button>

        </form>

    </div>
</div>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/insertModal.css">
