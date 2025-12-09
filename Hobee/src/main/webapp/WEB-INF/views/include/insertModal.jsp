<%@ page contentType="text/html; charset=UTF-8" %>

<!-- insertModal.jsp -->
<div id="insertModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="insert-modal-content">

        <span class="insert-close">×</span>

        <h2 class="insert-title">회원가입</h2>
<!--         	<button type="button" class="modal1">모달</button> -->
        
        <!-- 회원구분 -->
        <div class="signup-role-box">
            <button type="button" class="signup-role-tab active" data-role="user">일반회원</button>
            <button type="button" class="signup-role-tab" data-role="instructor">강사회원</button>
        </div>


        <form id="insertForm">

            <!-- 🔥 반드시 폼 안으로 이동 -->
            <input type="hidden" id="ins_role" name="user_role" value="user">
            
            <!-- 🔵 회원가입 진행 단계 표시 -->
            <div id="signupProgressBox" class="signup-progress-box">
                <div class="step-wrapper">
                    <div class="step-item" id="stepId">아이디</div>
                    <div class="step-item" id="stepPw">비밀번호</div>
                    <div class="step-item" id="stepPhone">연락처</div>
                    <div class="step-item" id="stepAddress">주소</div>
                    <div class="step-item" id="stepAgree">약관</div>
                </div>

                <div class="progress-bar">
                    <div class="progress-fill" id="progressFill"></div>
                </div>

                <div id="progressPercent" class="progress-percent">0%</div>
            </div>

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
             
             <!-- 연락처 -->
			 <label>연락처</label>
				<input type="text" id="ins_user_phone" name="user_phone"
       				   class="insert-input" placeholder="010-1234-5678" />
			<div id="phoneMsg" class="msg"></div>
             

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

<!-- 🔥 회원가입 성공 애니메이션 팝업 -->
<div id="joinSuccessPopup" class="join-success-popup" style="display:none;">
    <div class="join-success-box">
        <div class="checkmark-circle">
            <div class="checkmark draw"></div>
        </div>
        <h3>회원가입 완료!</h3>
        <p>Hobee에 오신 것을 환영합니다 😄</p>
    </div>
</div>

<!-- 🔍 Hobee 주소검색 레이어 -->
<div id="daumPostLayerWrapper"
     style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
            background:rgba(0,0,0,0.45); z-index:10000;">

    <div id="daumPostLayer"
         style="position:absolute; background:#fff; border-radius:16px;
                width:550px; height:620px; left:50%; top:50%;
                transform:translate(-50%, -50%);
                box-shadow:0 10px 40px rgba(0,0,0,0.25); overflow:hidden;">

        <!-- Header -->
        <div class="hobee-post-header"
             style="height:55px; background:#1e5eff; color:#fff;
                    padding:0 40px; display:flex; align-items:center;
                    justify-content:space-between; font-size:18px;
                    font-weight:700;">
            <span>🔍 주소 검색</span>
            <span id="btnCloseDaumPost"
                  style="cursor:pointer; font-size:22px; font-weight:600;">×</span>
        </div>

        <!-- 카카오 주소검색 embed 영역 -->
        <div id="daumPostEmbed"
             style="width:100%; height:500px; border-radius:0; overflow:hidden;"></div>

        <!-- Footer -->
        <div class="hobee-post-footer"
             style="height:65px; background:#f7f9fc; display:flex; align-items:center;
                    justify-content:center; font-size:14px; color:#666;">
            Hobee · Online Class Platform
        </div>

    </div>
</div>


<!-- CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/include/insertModal.css?v=20251120">

<!-- Daum 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
// ============================
// Daum 주소검색 (레이어 방식)
// ============================
//스크립트 마지막 부분 (document.ready 안쪽)에 추가

/* ===============================
   테스트용 모달 버튼
================================ */
// $(".modal1").click(function() {
//     $("#tagSelectionModal").fadeIn().css("display", "flex");
// });


// 레이어 닫기
function closeDaumPostLayer() {
    document.getElementById("daumPostLayerWrapper").style.display = "none";
}

// 닫기 버튼
document.getElementById("btnCloseDaumPost").onclick = closeDaumPostLayer;


// 레이어 열기
function openDaumPostLayer() {

    const wrapper = document.getElementById("daumPostLayerWrapper");
    const embed = document.getElementById("daumPostEmbed");

    new daum.Postcode({
        oncomplete: function(data) {

            // 값 채우기
            document.getElementById("ins_user_zipcode").value = data.zonecode;
            document.getElementById("ins_user_address1").value = data.roadAddress || data.jibunAddress;
            
            updateSignupProgress();
            
            document.getElementById("ins_user_address2").focus();

            closeDaumPostLayer();
        },
        width: "100%",
        height: "100%"
    }).embed(embed);

    wrapper.style.display = "block";
}

// 버튼 클릭 → 열기
document.getElementById("btnFindAddress").onclick = openDaumPostLayer;

/* ===============================
회원구분 선택 (일반 / 강사)
================================ */
$(document).on("click", ".signup-role-tab", function () {

 $(".signup-role-tab").removeClass("active");
 $(this).addClass("active");

 const role = $(this).data("role");
 $("#ins_role").val(role);   // user_role 값 변경

 console.log("선택된 회원타입:", role);
});

</script>
