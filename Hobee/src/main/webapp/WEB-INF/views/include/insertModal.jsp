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
                <input type="text" id="ins_user_id" name="user_id" class="insert-input" placeholder="영문+숫자 8자 이내" />
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
            <input type="text" id="ins_user_name" name="user_name" class="insert-input" placeholder="이름을 입력하세요" />

            <!-- 이메일 -->
            <label>이메일</label>
            <div class="input-row">
                <input type="text" id="ins_user_email" name="user_email" class="insert-input" placeholder="예: example@naver.com" />
                <button type="button" id="ins_checkEmailBtn" class="check-btn">중복확인</button>
            </div>
            <div id="ins_emailCheckMsg" class="msg"></div>

            <!-- 전화번호 -->
            <label>전화번호</label>
            <input type="text" id="ins_user_phone" name="user_phone" class="insert-input" placeholder="예: 010-1234-5678" />

            <!-- 주소 -->
            <label>주소</label>

            <!-- 우편번호 + 검색 -->
            <div class="address-row">
                <input type="text" id="ins_user_zipcode" name="user_zipcode"
                       class="insert-input address-zip" placeholder="우편번호" readonly />
                <button type="button" id="btnFindAddress" class="check-btn address-btn">검색</button>
            </div>

            <!-- 기본주소 -->
            <input type="text" id="ins_user_address" name="user_address"
                   class="insert-input address-main" placeholder="도로명/지번 주소" readonly />

            <!-- 상세주소 -->
            <input type="text" id="ins_user_detail" name="user_detail"
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

                <!-- 이용약관 내용 -->
                <div id="term1" class="term-content">
본 서비스는 온라인 취미/클래스 예약 플랫폼입니다.
사용자는 회원가입 시 정확한 정보를 제공해야 합니다.
허위 정보 입력 또는 타인의 정보 도용 시 서비스 이용이 제한될 수 있습니다.
서비스 이용 과정에서 발생되는 콘텐츠(글/댓글/사진)는 운영정책을 준수해야 합니다.
운영정책 위반 시 게시물 삭제 또는 이용제한 조치가 이루어질 수 있습니다.
회사는 안정적인 서비스 제공을 위해 시스템 점검을 진행할 수 있습니다.
회원은 서비스 이용 시 관련 법령과 약관을 준수해야 합니다.
                </div>

                <!-- 개인정보방침 -->
                <div class="agree-item-row">
                    <label>
                        <input type="checkbox" class="ins-agree-item" required>
                        개인정보 수집 및 이용 동의(필수)
                    </label>
                    <button type="button" class="toggle-term-btn" data-target="#term2">보기 ▼</button>
                </div>

                <!-- 개인정보방침 내용 -->
                <div id="term2" class="term-content">
회사는 회원가입 및 서비스 제공을 위해 아래 개인정보를 수집합니다.
수집 항목: 아이디, 비밀번호, 이름, 이메일, 휴대전화번호, 주소
수집 목적: 회원 식별, 서비스 제공, 본인 인증, 고객 문의 응대
보유 기간: 회원 탈퇴 시 즉시 삭제 (관련 법령에 따른 보관기간 예외)
회사는 개인정보를 안전하게 보호하기 위해 보안조치를 시행합니다.
사용자는 정보 변경 시 즉시 수정해야 합니다.
개인정보는 명시된 목적 외에 사용되지 않습니다.
                </div>
            </div>

            <div id="insertError" class="error-msg"></div>
            <div id="insertSuccess" class="success-msg"></div>

            <!-- submit -->
            <button type="button" id="insertBtn" class="insert-submit-btn">회원가입</button>

        </form>

    </div>
</div>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/include/insertModal.css?v=20251120">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
