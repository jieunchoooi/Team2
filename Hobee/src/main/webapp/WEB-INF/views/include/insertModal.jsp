<%@ page contentType="text/html; charset=UTF-8" %>

<!-- insertModal.jsp -->
<div id="insertModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="insert-modal-content">

        <span class="insert-close">×</span>

        <h2 class="insert-title">회원가입</h2>

        <form id="insertForm">

            <!-- 아이디 -->
            <label>아이디</label>
            <div class="input-row">
                <input type="text" id="ins_user_id" name="user_id" 
                       class="insert-input" placeholder="영문+숫자 8자 이내" />
                <button type="button" id="ins_checkIdBtn" class="check-btn">중복확인</button>
            </div>
            <div id="ins_idCheckMsg" class="msg"></div>

            <!-- 비밀번호 -->
            <label>비밀번호</label>
            <input type="password" id="ins_user_password" name="user_password"
                   class="insert-input" placeholder="영문/숫자/특수문자 포함 8~12자" />
            <div id="pwStrengthMsg" class="msg"></div>

            <!-- 비밀번호 확인 -->
            <label>비밀번호 확인</label>
            <input type="password" id="ins_user_password2" class="insert-input"
                   placeholder="비밀번호를 한번 더 입력해주세요" />
            <div id="pwCheckMsg" class="msg"></div>

            <!-- 이름 -->
            <label>이름</label>
            <input type="text" id="ins_user_name" name="user_name"
                   class="insert-input" placeholder="이름을 입력하세요" />

            <!-- 이메일 -->
            <label>이메일</label>
            <div class="input-row">
                <input type="text" id="ins_user_email" name="user_email"
                       class="insert-input" placeholder="예: example@naver.com" />
                <button type="button" id="ins_checkEmailBtn" class="check-btn">중복확인</button>
            </div>
            <div id="ins_emailCheckMsg" class="msg"></div>

            <!-- 전화번호 -->
            <label>전화번호</label>
            <input type="text" id="ins_user_phone" name="user_phone"
                   class="insert-input" placeholder="예: 010-1234-5678" />

            <!-- 주소 -->
            <label>주소</label>

            <!-- 우편번호 -->
            <div class="address-row">
                <input type="text" id="ins_user_zipcode" name="user_zipcode"
                       class="insert-input address-zip" placeholder="우편번호" readonly />
                <button type="button" id="btnFindAddress" class="check-btn address-btn">검색</button>
            </div>

            <!-- 기본 주소 -->
            <input type="text" id="ins_user_address1" name="user_address1"
                   class="insert-input address-main" placeholder="도로명/지번 주소" readonly />

            <!-- 상세 주소 -->
            <input type="text" id="ins_user_address2" name="user_address2"
                   class="insert-input address-detail" placeholder="상세주소를 입력하세요" />

            <!-- 성별 -->
            <label>성별</label>
            <select id="ins_user_gender" name="user_gender" class="insert-input">
                <option value="">선택</option>
                <option value="Male">남성</option>
                <option value="Female">여성</option>
            </select>

            <!-- 약관 영역 -->
            <div class="insert-agree-box">

                <!-- 전체동의 -->
                <label><input type="checkbox" id="ins_agreeAll"> 전체동의</label>

                <!-- 이용약관 -->
                <div class="agree-item-row">
                    <label>
                        <input type="checkbox" class="ins-agree-item" required>
                        이용약관 동의(필수)
                    </label>
                    <button type="button" class="toggle-term-btn" data-target="#term1">보기 ▼</button>
                </div>

                <div id="term1" class="term-content">
                    본 서비스는 온라인 취미/클래스 예약 플랫폼입니다.<br>
                    허위 정보 입력 또는 타인의 정보 도용 시 이용 제한될 수 있습니다.<br>
                    게시물 작성 시 운영정책을 반드시 준수해야 합니다.
                </div>

                <!-- 개인정보방침 -->
                <div class="agree-item-row">
                    <label>
                        <input type="checkbox" class="ins-agree-item" required>
                        개인정보 수집 및 이용 동의(필수)
                    </label>
                    <button type="button" class="toggle-term-btn" data-target="#term2">보기 ▼</button>
                </div>

                <div id="term2" class="term-content">
                    수집 항목: 아이디, 비밀번호, 이름, 이메일, 휴대전화번호, 주소<br>
                    목적: 회원 식별, 본인 인증, 서비스 제공<br>
                    보유 기간: 회원 탈퇴 후 즉시 삭제
                </div>
            </div>

            <div id="insertError" class="error-msg"></div>
            <div id="insertSuccess" class="success-msg"></div>

            <!-- submit -->
            <button type="button" id="insertBtn" class="insert-submit-btn">회원가입</button>

        </form>
    </div>
</div>

<!-- CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/include/insertModal.css?v=20251120">

<!-- Daum 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
// ============================
// 주소 검색 기능
// ============================
document.getElementById("btnFindAddress").onclick = function() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("ins_user_zipcode").value = data.zonecode;
            document.getElementById("ins_user_address1").value = data.roadAddress || data.jibunAddress;
            document.getElementById("ins_user_address2").focus();
        }
    }).open();
};
</script>
