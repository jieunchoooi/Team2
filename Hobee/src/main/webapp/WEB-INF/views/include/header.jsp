<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hobee Header</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/loginModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/insertModal.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- jQuery UI 추가 -->
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <!-- 카카오 우편번호 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- confetti -->
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

<header>
    <h1><a href="${pageContext.request.contextPath}/main/main">Hobee</a></h1>

    <nav>
        <div class="nav-left">

		<!-- 카테고리 -->
		<div class="mega-dropdown">
        	<a href="${pageContext.request.contextPath}/category/lectureList?category_detail=전체">카테고리 ▾</a>
                <div class="mega-content">
                    <c:forEach var="mainCategory" items="${cateMainList}">
                        <div class="mega-column">
                            <h3>${mainCategory.category_main_name}</h3>
                            <ul>
                                <c:forEach var="category" items="${cateList}">
                                    <c:if test="${category.category_main_name eq mainCategory.category_main_name}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=${category.category_detail}">
                                                ${category.category_detail}
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>

                </div>
            </div>

            <a href="${pageContext.request.contextPath}/community/list">커뮤니티</a>
            <a href="${pageContext.request.contextPath}/category/recommendList">맞춤 추천 강의</a>
        </div>

        <div class="nav-right">

            <c:choose>
                <c:when test="${empty sessionScope.user_id}">
                    <a href="#" id="openLoginModal" class="auth-link">로그인</a>
                    <a href="#" id="openInsertModal" class="auth-link">회원가입</a>
                </c:when>

                <c:otherwise>
                    <!-- 로그인한 사용자 이름 (클릭 시 로그인 로그 팝업) -->
                    <span class="welcome-text" id="openLoginLog">${sessionScope.user_name}님</span>

                    <a href="${pageContext.request.contextPath}/member/mypage" class="auth-link">마이페이지</a>

                    <c:if test="${sessionScope.user_role eq 'admin' or sessionScope.user_role eq 'super_admin'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="auth-link">관리자페이지</a>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/user/logout" class="auth-link">로그아웃</a>
                </c:otherwise>
            </c:choose>

        </div>
    </nav>

</header>

<!-- 로그인 모달 include -->
<jsp:include page="/WEB-INF/views/include/loginModal.jsp"/>

<!-- 회원가입 모달 include -->
<jsp:include page="/WEB-INF/views/include/insertModal.jsp"/>

<!-- 태그 선택 모달 include -->
<jsp:include page="/WEB-INF/views/include/interestModal.jsp"/>

<!-- ===========================
     🔵 회원가입 Progress 전역 함수
=========================== -->
<script>

function updateSignupProgress() {
    let progress = 0;

    const id = $("#ins_user_id").val().trim();
    const idValid = /^[a-z][a-z0-9]{5,7}$/.test(id);
    if (idValid) {
        $("#stepId").removeClass().addClass("step-item complete");
        progress += 20;
    } else {
        $("#stepId").removeClass().addClass("step-item active");
    }

    const pw = $("#ins_user_password").val();
    const pwValid = pw.length >= 8;
    if (pwValid) {
        $("#stepPw").removeClass().addClass("step-item complete");
        progress += 20;
    } else {
        $("#stepPw").removeClass().addClass("step-item active");
    }

    const phone = $("#ins_user_phone").val();
    const phoneValid = /^010-\d{4}-\d{4}$/.test(phone);
    if (phoneValid) {
        $("#stepPhone").removeClass().addClass("step-item complete");
        progress += 20;
    } else {
        $("#stepPhone").removeClass().addClass("step-item active");
    }

    const addr = $("#ins_user_address1").val();
    const addrValid = addr.trim() !== "";
    if (addrValid) {
        $("#stepAddress").removeClass().addClass("step-item complete");
        progress += 20;
    } else {
        $("#stepAddress").removeClass().addClass("step-item active");
    }

    const agreeValid = $(".ins-agree-item:checked").length === $(".ins-agree-item").length;
    if (agreeValid) {
        $("#stepAgree").removeClass().addClass("step-item complete");
        progress += 20;
    } else {
        $("#stepAgree").removeClass().addClass("step-item active");
    }

    $("#progressFill").css("width", progress + "%");
    $("#progressPercent").text(progress + "%");
}
</script>

<!-- ===========================================
     SCRIPT (로그인 + 회원가입 + 로그인 로그)
=========================================== -->
<script>
$(document).ready(function () {

    const contextPath = "${pageContext.request.contextPath}";

    /* --------------------------------------------------
       1) 로그인 모달 열기 / 닫기
    -------------------------------------------------- */
    $("#openLoginModal").click(function(e) {
        e.preventDefault();
		console.log("클릭테스트")
        openLoginModal();
    });

    // 로그인 모달 열기
    window.openLoginModal = function() {
    	console.log("로그인 모달 오픈 테스트")
        $("#loginModal").fadeIn().css("display", "flex");
        $("#loginForm input[name='user_id']").focus();
    }

    // 로그인 모달 닫기
    window.closeLoginModal = function() {
        $("#loginModal").fadeOut();
        $("#loginForm")[0].reset();
        $("#loginError").text("");
    }

    // 닫기 버튼이나 배경 클릭 이벤트
    $(document).on("click", ".login-close, #loginModal .modal-overlay", function() {
        closeLoginModal();
    });

    // 로그인 모달 내부의 "회원가입" 버튼 클릭 시
    $(document).on("click", ".openInsertFromLogin", function(e) {
        e.preventDefault();
        closeLoginModal();
        $("#insertModal").fadeIn().css("display", "flex");
    });

    /* --------------------------------------------------
       2) 회원가입 모달 열기 / 닫기
    -------------------------------------------------- */
    $("#openInsertModal").click(function (e) {
        e.preventDefault();
        $("#insertModal").fadeIn().css("display", "flex");
    });

    $(document).on("click", ".insert-close, #insertModal .modal-overlay", function () {
        $("#insertModal").fadeOut();
        $("#insertForm")[0].reset();
        $("#insertError").text("");
        $("#insertSuccess").text("");
    });

    /* --------------------------------------------------
       3) 로그인 AJAX
    -------------------------------------------------- */
    $("#loginBtn").click(function () {
        loginRequest();
    });

    // 엔터키 로그인
    $("#loginForm input").keypress(function(e) {
        if (e.which === 13) {
            e.preventDefault();
            loginRequest();
        }
    });

    function loginRequest() {
        $.ajax({
            type: "POST",
            url: contextPath + "/user/loginPro",
            data: $("#loginForm").serialize(),
            dataType: "json",

            success: function (res) {

                // 1) 계정 잠금
                if (res.result === "locked") {
                    $("#loginError")
                        .removeClass("success")
                        .addClass("error")
                        .html("⚠ 비밀번호 5회 실패로 로그인 제한 상태입니다.<br>30분 후 다시 시도해주세요.")
                        .fadeIn(200);
                    return;
                }

                // 2) 로그인 성공
                if (res.result === "success") {

                    if (res.pw_change_alert) {
                        Swal.fire({
                            icon: "warning",
                            title: "비밀번호 변경 권장",
                            text: res.pw_change_alert,
                            confirmButtonColor: "#4a74ff"
                        });
                    }

                    $("#loginModal").fadeOut(0);

                    Swal.fire({
                        icon: "success",
                        title: res.user_name + "님 환영합니다! 😊",
                        html: `
                            <div style="margin-top:8px; font-size:15px; color:#555;">
                                로그인에 성공했습니다.
                            </div>
                        `,
                        confirmButtonColor: "#4a74ff",
                        timer: 1800,
                        timerProgressBar: true,
                        showConfirmButton: false
                    });

                    console.log("========== [ 로그인 정보 LOG ] ==========");
                    console.log("✔ 사용자:", res.user_name);
                    console.log("✔ 마지막 로그인:", res.last_login_at || "첫 로그인");
                    console.log("✔ 현재 접속 지역:", res.current_location);
                    console.log("✔ 이전 접속 지역:", res.last_location);
                    console.log("✔ 최근 로그인 기기:");
                    if (res.recent_devices) {
                        res.recent_devices.forEach(d => console.log("   - " + d));
                    }
                    console.log("==========================================");

                    setTimeout(() => {
                        $("#loginModal").fadeOut();

                        if (res.redirect) {
//                             location.href = contextPath + res.redirect;
                            location.reload(); // 🔥 로그인 상태 반영 위해 새로고침 (선택)
                        } 
                        else {
//                             location.href = contextPath + "/main/main";
                        	 location.reload();
                        }
                    }, 1500);

                    return;
                }

                // 3) 일반 실패
                $("#loginError")
                    .removeClass("success")
                    .addClass("error")
                    .html(res.message.replace(/\n/g, "<br>"))
                    .fadeIn(200);

                $(".login-modal-content").addClass("shake");
                setTimeout(() => $(".login-modal-content").removeClass("shake"), 400);

                $("[name='user_password']").val("");
            },

            error: function () {
                $("#loginError")
                    .removeClass("success")
                    .addClass("error")
                    .text("서버 오류가 발생했습니다.")
                    .fadeIn(200);
            }
            
            
//             // 테스트 모달
//             $(".modal1").click(function() {
//                 $("#tagSelectionModal").fadeIn().css("display", "flex");
//             });
        });
    }

    /* --------------------------------------------------
       3-1) 로그인 비밀번호 보기 / 숨기기
    -------------------------------------------------- */
//     $(document).on("click", "#togglePw", function () {
//         const $pw = $("#login_pw");
//         const nowType = $pw.attr("type");
//         const newType = nowType === "password" ? "text" : "password";

//         $pw.attr("type", newType);
//         $(this).text(newType === "text" ? "🙈" : "👁");
//     });

    /* --------------------------------------------------
       4) 회원가입 — 아이디 중복 체크
    -------------------------------------------------- */
    let insIdOk = false;
    let insEmailOk = false;

    $("#ins_checkIdBtn").click(() => {
        const id = $("#ins_user_id").val().trim();

        const pattern = /^(?=.*\d)[a-z][a-z\d]{5,7}$/;

        if (!pattern.test(id)) {
            $("#ins_idCheckMsg")
                .text("아이디는 소문자로 시작하고 숫자를 포함한 6~8자리여야 합니다.")
                .css("color", "red");
            return;
        }

        $.ajax({
            url: contextPath + "/user/checkId",  // ← URL 변경
            type: "POST",
            data: { user_id: id },
            success: function (res) {
                if (res === "available") {
                    $("#ins_idCheckMsg").text("사용 가능").css("color", "green");
                    insIdOk = true;
                } else {
                    $("#ins_idCheckMsg").text("이미 사용중").css("color", "red");
                    insIdOk = false;
                }
            }
        });
    });

    /* --------------------------------------------------
       5) 회원가입 — 이메일 중복 체크
    -------------------------------------------------- */
    $("#ins_user_email").on("input", () => {
        insEmailOk = false;
        $("#ins_emailCheckMsg").text("");
    });

    $("#ins_checkEmailBtn").click(() => {
        const email = $("#ins_user_email").val();
        const pattern = /^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,}$/;

        if (!pattern.test(email)) {
            $("#ins_emailCheckMsg").text("이메일 형식 오류").css("color", "red");
            return;
        }

        $.ajax({
            url: contextPath + "/user/checkEmail",
            type: "GET",
            data: { user_email: email },
            success: function (res) {
                if (res === "available") {
                    $("#ins_emailCheckMsg").text("사용 가능").css("color", "green");
                    insEmailOk = true;
                } else {
                    $("#ins_emailCheckMsg").text("이미 사용중").css("color", "red");
                    insEmailOk = false;
                }
            }
        });
    });

    /* --------------------------------------------------
       6) 비밀번호 강도 체크 (메시지)
    -------------------------------------------------- */
    $("#ins_user_password").on("keyup", function () {

        let pw = $(this).val();
        let msg = "";
        let color = "";

        if (/^[0-9]/.test(pw)) {
            $("#pwStrengthMsg")
                .text("❌ 비밀번호는 숫자로 시작할 수 없습니다.")
                .css("color", "#e74c3c");
            return;
        }

        const hasLetter = /[A-Za-z]/.test(pw);
        const hasNumber = /[0-9]/.test(pw);
        const hasSpecial = /[!@#$%^*]/.test(pw);

        if (pw.length === 0) {
            msg = "";
        }
        else if (pw.length < 8) {
            msg = "🔴 너무 약함 (8자 이상 입력)";
            color = "#e74c3c";
        }
        else {
            let strength = hasLetter + hasNumber + hasSpecial;

            if (strength === 1) {
                msg = "🟡 보통 (문자 종류가 부족해요)";
                color = "#f1c40f";
            }
            else if (strength === 2) {
                msg = "🔵 강함!";
                color = "#3498db";
            }
            else if (strength === 3) {
                if (pw.length >= 10) {
                    msg = "🟢 매우 강함!";
                    color = "#2ecc71";
                } else {
                    msg = "🔵 강함!";
                    color = "#3498db";
                }
            }
        }

        $("#pwStrengthMsg").text(msg).css("color", color);
    });

    /* --------------------------------------------------
       7) 비밀번호 일치 체크
    -------------------------------------------------- */
    $("#ins_user_password, #ins_user_password2").on("keyup", function () {

        let pw = $("#ins_user_password").val();
        let pw2 = $("#ins_user_password2").val();

        if (pw === "" || pw2 === "") {
            $("#pwCheckMsg").text("");
            return;
        }

        if (pw === pw2) {
            $("#pwCheckMsg").text("비밀번호가 일치합니다.").css("color", "#2e7d32");
        } else {
            $("#pwCheckMsg").text("비밀번호가 일치하지 않습니다.").css("color", "#d9534f");
        }
    });

    /* ================================
       전화번호 실시간 유효성 검사
    ================================ */
    $("#ins_user_phone").on("input", function () {

        let v = $(this).val().replace(/[^0-9]/g, "");

        if (v.length < 4) {
            $(this).val(v);
        } else if (v.length < 7) {
            $(this).val(v.substring(0, 3) + "-" + v.substring(3));
        } else if (v.length <= 11) {
            $(this).val(
                v.substring(0, 3) + "-" +
                v.substring(3, 7) + "-" +
                v.substring(7)
            );
        }

        const phoneFormatted = $(this).val();
        const phonePattern = /^010-\d{4}-\d{4}$/;

        if (phoneFormatted.length === 0) {
            $("#phoneMsg").text("");
            return;
        }

        if (!phonePattern.test(phoneFormatted)) {
            $("#phoneMsg")
                .text("휴대폰 번호를 정확히 입력해주세요.")
                .css("color", "#e74c3c");
        } else {
            $("#phoneMsg")
                .text("사용 가능한 전화번호입니다.")
                .css("color", "#008000");
        }

        updateSignupProgress();
    });

    /* --------------------------------------------------
       9) 카카오 주소검색 (버튼 클릭)
    -------------------------------------------------- */
    $(document).on("click", "#btnFindAddress", function () {
        new daum.Postcode({
            oncomplete: function (data) {

                $("#ins_user_zipcode").val(data.zonecode);

                const full = data.roadAddress ? data.roadAddress : data.jibunAddress;
                $("#ins_user_address1").val(full);

                updateSignupProgress();

                $("#ins_user_address2").focus();
            }
        });
    });

//     /* --------------------------------------------------
//        10) 회원가입 실행 및 관심사 모달창 연결
//     -------------------------------------------------- */
//     $("#insertBtn").click(function () { //여기

//         $("#insertError").text("");

//         if (!insIdOk) {
//             $("#insertError").text("아이디 중복확인을 해주세요.");
//             return;
//         }

//         if (!insEmailOk) {
//             $("#insertError").text("이메일 중복확인을 해주세요.");
//             return;
//         }

//         const pw = $("#ins_user_password").val();
//         const pw2 = $("#ins_user_password2").val();

//         const regex = /^(?![0-9])(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;

//         if (!regex.test(pw)) {
//             $("#insertError").text("비밀번호는 숫자로 시작할 수 없으며, 영문/숫자/특수문자 포함 8~12자여야 합니다.");
//             return;
//         }

//         if (pw !== pw2) {
//             $("#insertError").text("비밀번호가 일치하지 않습니다.");
//             return;
//         }

//         if (!$("#ins_user_zipcode").val().trim()) {
//             $("#insertError").text("우편번호를 입력해주세요.");
//             return;
//         }

//         if (!$("#ins_user_address1").val().trim()) {
//             $("#insertError").text("주소를 입력해주세요.");
//             return;
//         }

//         if (!$("#ins_user_address2").val().trim()) {
//             $("#insertError").text("상세주소를 입력해주세요.");
//             return;
//         }

//         const phonePattern = /^010-\d{4}-\d{4}$/;

//         if (!phonePattern.test($("#ins_user_phone").val())) {
//             $("#insertError").text("전화번호를 정확히 입력해주세요. (예: 010-1234-5678)");
//             return;
//         }

//         $.ajax({
//             type: "POST",
//             url: contextPath + "/user/insertAjax",
//             data: $("#insertForm").serialize(),
//             dataType: "json",

//             success: function (res) {
//                 if (res.result === "success") {
//                 	// 회원가입 성공 팝업
//                     $("#joinSuccessPopup").fadeIn(200);

//                     confetti({
//                         particleCount: 120,
//                         spread: 90,
//                         origin: { y: 0.6 }
//                     });

//                     // 1.5초후 태그 선택 모달로 화면전환
//                     setTimeout(() => {
//                         $("#joinSuccessPopup").fadeOut(300);
//                         $("#insertModal").fadeOut(200);
                        
//                         // 태그 선택 모달 열기
//                         $("#tagSelectionModal").fadeIn().css("display", "flex");
//                         // user_id를 태그 모달에 전달
//                         $("#tag_user_id").val(res.user_id);
                        
//                         $(".checkmark").removeClass("draw");
                        
//                         openTagModal(res.user_id);
//                     }, 1500);

//                     $(".checkmark").addClass("draw");

//                 } else {
//                     $("#insertError").text(res.message);
//                 }
//             },

//             error: function () {
//                 $("#insertError").text("회원가입 중 오류가 발생했습니다.");
//             }
//         });
//     });

/* --------------------------------------------------
   10) 회원가입 실행 및 관심사 모달창 연결
-------------------------------------------------- */
$("#insertBtn").click(function () {

    $("#insertError").text("");

    if (!insIdOk) {
        $("#insertError").text("아이디 중복확인을 해주세요.");
        return;
    }

    if (!insEmailOk) {
        $("#insertError").text("이메일 중복확인을 해주세요.");
        return;
    }

    const pw = $("#ins_user_password").val();
    const pw2 = $("#ins_user_password2").val();

    const regex = /^(?![0-9])(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;

    if (!regex.test(pw)) {
        $("#insertError").text("비밀번호는 숫자로 시작할 수 없으며, 영문/숫자/특수문자 포함 8~12자여야 합니다.");
        return;
    }

    if (pw !== pw2) {
        $("#insertError").text("비밀번호가 일치하지 않습니다.");
        return;
    }

    if (!$("#ins_user_zipcode").val().trim()) {
        $("#insertError").text("우편번호를 입력해주세요.");
        return;
    }

    if (!$("#ins_user_address1").val().trim()) {
        $("#insertError").text("주소를 입력해주세요.");
        return;
    }

    if (!$("#ins_user_address2").val().trim()) {
        $("#insertError").text("상세주소를 입력해주세요.");
        return;
    }

    const phonePattern = /^010-\d{4}-\d{4}$/;

    if (!phonePattern.test($("#ins_user_phone").val())) {
        $("#insertError").text("전화번호를 정확히 입력해주세요. (예: 010-1234-5678)");
        return;
    }

    $.ajax({
        type: "POST",
        url: contextPath + "/user/insertAjax",
        data: $("#insertForm").serialize(),
        dataType: "json",

        success: function (res) {
            if (res.result === "success") {
                // 회원가입 성공 팝업
                $("#joinSuccessPopup").fadeIn(200);

                confetti({
                    particleCount: 120,
                    spread: 90,
                    origin: { y: 0.6 }
                });

                $(".checkmark").addClass("draw");

                // 1.5초 후 팝업 닫고 관심사 모달 열기
                setTimeout(() => {
                    $("#joinSuccessPopup").fadeOut(300);
                    $("#insertModal").fadeOut(200);

                    // ✅ 기존 tagSelectionModal.jsp의 openTagModal() 호출
                    openTagModal(res.user_id);

                    $(".checkmark").removeClass("draw");

                }, 1500);

            } else {
                $("#insertError").text(res.message);
            }
        },

        error: function () {
            $("#insertError").text("회원가입 중 오류가 발생했습니다.");
        }
    });
});


    /* --------------------------------------------------
       11) 약관 펼치기 / 접기
    -------------------------------------------------- */
    $(document).on("click", ".toggle-term-btn", function () {

        const target = $(this).data("target");
        const box = $(target);

        if (box.is(":visible")) {
            box.slideUp(200);
            $(this).text("보기 ▼");
        } else {
            box.slideDown(200);
            $(this).text("닫기 ▲");
        }
    });

    /* --------------------------------------------------
       12) 약관 전체 동의
    -------------------------------------------------- */
    $("#ins_agreeAll").on("change", function () {
        $(".ins-agree-item").prop("checked", $(this).prop("checked"));
        updateSignupProgress();
    });

    $(".ins-agree-item").on("change", function () {
        const total = $(".ins-agree-item").length;
        const checked = $(".ins-agree-item:checked").length;
        $("#ins_agreeAll").prop("checked", total === checked);
        updateSignupProgress();
    });

    /* --------------------------------------------------
       13) 특정 상황에서 로그인 모달 자동 오픈
    -------------------------------------------------- */
    const params = new URLSearchParams(window.location.search);
    if (params.get("openLogin") === "true") {
        $("#loginModal").fadeIn().css("display", "flex");
    }

    /* ================================
       CapsLock 감지
    ================================ */
    $("#ins_user_password").on("keydown keyup", function (e) {

        const isCapsOn = e.originalEvent.getModifierState &&
                         e.originalEvent.getModifierState("CapsLock");

        if (isCapsOn) {
            $("#capsLockMsg")
                .text("⚠ CapsLock이 켜져 있습니다.")
                .show();
        } else {
            $("#capsLockMsg").hide();
        }
    });

    /* =====================================================
       비밀번호 체크리스트 (실시간 만족도 체크)
    ===================================================== */
    $("#ins_user_password").on("keyup", function () {

        const pw = $(this).val();

        const hasLetter = /[A-Za-z]/.test(pw);
        const hasNumber = /[0-9]/.test(pw);
        const hasSpecial = /[!@#$%^*]/.test(pw);
        const isLength = pw.length >= 8 && pw.length <= 12;
        const notStartNumber = pw.length > 0 && !/^[0-9]/.test(pw);

        function setRule(ruleId, ok, label) {
            const el = $(ruleId);
            el.text(label);
            if (ok) {
                el.addClass("valid");
            } else {
                el.removeClass("valid");
            }
        }

        setRule("#ruleLength", isLength, "8~12자");
        setRule("#ruleLetter", hasLetter, "영문 포함");
        setRule("#ruleNumber", hasNumber, "숫자 포함");
        setRule("#ruleSpecial", hasSpecial, "특수문자 포함");
        setRule("#ruleStart", notStartNumber, "숫자로 시작 금지");
    });

    /* ===========================
       비밀번호 강도 게이지
    =========================== */
    $("#ins_user_password").on("keyup", function () {

        const pw = $(this).val();

        let strength = 0;

        const hasLetter = /[A-Za-z]/.test(pw);
        const hasNumber = /[0-9]/.test(pw);
        const hasSpecial = /[!@#$%^*]/.test(pw);

        if (pw.length >= 8) strength++;
        if (hasLetter) strength++;
        if (hasNumber) strength++;
        if (hasSpecial) strength++;
        if (pw.length >= 10) strength++;

        const bar = $("#pwMeterBar");
        const text = $("#pwStrengthText");

        switch (strength) {
            case 0:
            case 1:
                bar.css({ width: "25%", background: "#e74c3c" });
                text.text("약함").css("color", "#e74c3c");
                break;

            case 2:
                bar.css({ width: "50%", background: "#f39c12" });
                text.text("보통").css("color", "#f39c12");
                break;

            case 3:
            case 4:
                bar.css({ width: "75%", background: "#3498db" });
                text.text("강함").css("color", "#3498db");
                break;

            case 5:
                bar.css({ width: "100%", background: "#2ecc71" });
                text.text("매우 강함").css("color", "#2ecc71");
                break;
        }

        if (pw.length === 0) {
            bar.css({ width: "0%" });
            text.text("");
        }
    });

    /* ===========================
       회원가입 Progress Step 감시
    =========================== */
    $("#ins_user_id, #ins_user_password, #ins_user_phone, #ins_user_address1, #ins_user_zipcode")
        .on("input change", updateSignupProgress);

    $(".ins-agree-item").on("change", updateSignupProgress);
    
    /* ===============================
    회원구분 선택 (일반 / 강사)
 ================================ */
 $(document).on("click", ".signup-role-tab", function () {

     $(".signup-role-tab").removeClass("active");
     $(this).addClass("active");

     const role = $(this).data("role");
     $("#ins_role").val(role);

     console.log("선택된 회원타입:", role);
 });


 /* =======================================================
 ✅ 헤더에서 로그인 상세 정보 보기 (이름 클릭)
======================================================= */
 $(document).on("click", "#openLoginLog", function () {

	  $.ajax({
	      url: contextPath + "/user/loginInfo",
	      method: "GET",
	      dataType: "json",

	      success: function (res) {

	          console.log("로그인 상세 응답:", res);

	          let userName = res.user_name || "정보 없음";
	          let lastLogin = res.last_login_at || "첫 로그인";
	          let currentLocation = res.current_location || "정보 없음";
	          let lastLocation = res.last_location || "기록 없음";

	          /* ================================
	             📌 최근 로그인 기기 리스트 구성
	          ================================ */
	          let deviceList = "";
	          if (res.recent_devices && res.recent_devices.length > 0) {

	              res.recent_devices.forEach(d => {
	                  deviceList +=
	                      "<li>" +
	                      d.login_time + " | " +
	                      d.device + " | " +
	                      d.location +
	                      "</li>";
	              });

	          } else {
	              deviceList = "<li>기록 없음</li>";
	          }

	          /* ================================
	             📌 SweetAlert HTML 문자열 조립
	             (백틱 X → JSP EL 충돌 제거)
	          ================================ */
	          let htmlContent =
	              "<div style='text-align:left; font-size:15px; line-height:1.6; color:#333;'>" +
	              "<b>✔ 사용자:</b> " + userName + "<br>" +
	              "<b>✔ 마지막 로그인:</b> " + lastLogin + "<br>" +
	              "<b>✔ 현재 접속 지역:</b> " + currentLocation + "<br>" +
	              "<b>✔ 이전 접속 지역:</b> " + lastLocation + "<br>" +
	              "<b>✔ 최근 로그인 기기:</b>" +
	              "<ul style='padding-left:18px; margin-top:6px;'>" +
	                  deviceList +
	              "</ul>" +
	              "</div>";

	          Swal.fire({
	              title: "로그인 상세 정보 🔍",
	              html: htmlContent,
	              width: "450px",
	              confirmButtonText: "닫기",
	              confirmButtonColor: "#4a74ff"
	          });
	      },

	      error: function () {
	          Swal.fire("오류", "로그인 기록을 불러올 수 없습니다.", "error");
	      }
	  });

	});

}); // document.ready 끝
</script>


</body>
</html>
