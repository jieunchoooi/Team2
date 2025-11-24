<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<!-- 카카오 우편번호 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

                    <div class="mega-column">
                        <h3>ART</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=디지털드로잉">디지털드로잉</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=드로잉">드로잉</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=공예">공예</a></li>
                        </ul>
                    </div>

                    <div class="mega-column">
                        <h3>IT</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=AI 스킬업">AI 스킬업</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=프로그래밍">프로그래밍</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=데이터사이언스">데이터사이언스</a></li>
                        </ul>
                    </div>

                    <div class="mega-column">
                        <h3>외국어</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=영어">영어</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=제2외국어">제2외국어</a></li>
                            <li><a href="${pageContext.request.contextPath}/category/lectureList?category_detail=외국어 시험">외국어 시험</a></li>
                        </ul>
                    </div>

                </div>
            </div>

            <a href="${pageContext.request.contextPath}/board/comunityList">커뮤니티</a>
            <a href="${pageContext.request.contextPath}/recommend/recoList">베스트 & 추천강의</a>
        </div>

        <div class="nav-right">

            <c:choose>
              
                <c:when test="${empty sessionScope.user_id}">
                    <a href="#" id="openLoginModal" class="auth-link">로그인</a>
                    <a href="#" id="openInsertModal" class="auth-link">회원가입</a>
                    <a href="#" id="" class="auth-link">고객센터</a>
                </c:when>

              
                <c:otherwise>
                    <span class="welcome-text">${sessionScope.user_name}님</span>
                    <a href="${pageContext.request.contextPath}/member/mypage" class="auth-link">마이페이지</a>

                    <c:if test="${sessionScope.user_role eq 'admin' or sessionScope.user_role eq 'super_admin'}">
    				<a href="${pageContext.request.contextPath}/admin/adminCategory" class="auth-link">관리자페이지</a>
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


<!-- ===========================================
     SCRIPT (로그인 + 회원가입)
=========================================== -->
<script>
$(document).ready(function () {

    const contextPath = "${pageContext.request.contextPath}";

    /* --------------------------------------------------
       1) 로그인 모달 열기 / 닫기
    -------------------------------------------------- */
    $("#openLoginModal").click(function (e) {
        e.preventDefault();
        $("#loginModal").fadeIn().css("display", "flex");
    });

    $(document).on("click", ".login-close, #loginModal .modal-overlay", function () {
        $("#loginModal").fadeOut();
        $("#loginForm")[0].reset();
        $("#loginError").text("");
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

 function loginRequest() {
     $.ajax({
         type: "POST",
         url: contextPath + "/user/loginPro",
         data: $("#loginForm").serialize(),
         dataType: "json",

         success: function (res) {
             if (res.result === "success") {

                 $("#loginError")
                     .css("color", "#2ecc71")
                     .text(res.user_name + "님 환영합니다!").fadeIn(200);

                 $("#loginSpinner").fadeIn(150);

                 setTimeout(() => {
                     $("#loginModal").fadeOut();
                     location.href = contextPath + "/main/main";
                 }, 700);

                 return;
             }

             $("#loginError")
                 .text(res.message)
                 .css("color", "#e74c3c")
                 .fadeIn(200);

             $(".login-modal-content").addClass("shake");
             setTimeout(() => $(".login-modal-content").removeClass("shake"), 400);

             $("[name='user_password']").val("");
         },

         error: function () {
             $("#loginError")
                 .text("서버 오류가 발생했습니다.")
                 .css("color", "#e74c3c");
         }
     });
 }


    /* --------------------------------------------------
       4) 회원가입 — 아이디 중복 체크
    -------------------------------------------------- */
    let insIdOk = false;
    let insEmailOk = false;

    $("#ins_user_id").on("input", () => {
        insIdOk = false;
        $("#ins_idCheckMsg").text("");
    });

    $("#ins_checkIdBtn").click(() => {
        const id = $("#ins_user_id").val().trim();
        const pattern = /^[A-Za-z0-9]{1,8}$/;

        if (!pattern.test(id)) {
            $("#ins_idCheckMsg").text("영문+숫자 8자").css("color", "red");
            return;
        }

        $.ajax({
            url: contextPath + "/user/checkId",
            type: "GET",
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
       6) 비밀번호 강도 체크
    -------------------------------------------------- */
    $("#ins_user_password").on("keyup", function () {

        let pw = $(this).val();
        let msg = "";
        let color = "";

        // 1) 숫자로 시작하면 즉시 오류
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
            $("#pwCheckMsg").text("비밀번호가 일치합니다 😊").css("color", "#2e7d32");
        } else {
            $("#pwCheckMsg").text("비밀번호가 일치하지 않습니다 ❌").css("color", "#d9534f");
        }
    });


    /* --------------------------------------------------
       8) 전화번호 자동 하이픈 처리
    -------------------------------------------------- */
    $("#ins_user_phone").on("input", function () {

        let v = $(this).val().replace(/[^0-9]/g, "");

        if (v.length < 4) $(this).val(v);
        else if (v.length < 7) $(this).val(v.substring(0, 3) + "-" + v.substring(3));
        else if (v.length < 11) $(this).val(v.substring(0, 3) + "-" + v.substring(3, 6) + "-" + v.substring(6));
        else $(this).val(v.substring(0, 3) + "-" + v.substring(3, 7) + "-" + v.substring(7, 11));
    });


    /* --------------------------------------------------
       9) 카카오 주소검색
    -------------------------------------------------- */
    $(document).on("click", "#btnFindAddress", function () {

        new daum.Postcode({
            oncomplete: function (data) {

                // 우편번호
                $("#ins_user_zipcode").val(data.zonecode);

                // 기본주소
                const full = data.roadAddress ? data.roadAddress : data.jibunAddress;
                $("#ins_user_address1").val(full);

                // 상세주소 이동
                $("#ins_user_address2").focus();
            }
        }).open();
    });


    /* --------------------------------------------------
       10) 회원가입 실행
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

        $.ajax({
            type: "POST",
            url: contextPath + "/user/insertAjax",
            data: $("#insertForm").serialize(),
            dataType: "json",

            success: function (res) {
                if (res.result === "success") {
                    alert("회원가입 완료! 다시 로그인해주세요.");
                    $("#insertModal").fadeOut();
                    $("#loginModal").fadeIn().css("display", "flex");
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
    });

    $(".ins-agree-item").on("change", function () {
        const total = $(".ins-agree-item").length;
        const checked = $(".ins-agree-item:checked").length;
        $("#ins_agreeAll").prop("checked", total === checked);
    });


    /* --------------------------------------------------
       13) 특정 상황에서 로그인 모달 자동 오픈
    -------------------------------------------------- */
    const params = new URLSearchParams(window.location.search);
    if (params.get("openLogin") === "true") {
        $("#loginModal").fadeIn().css("display", "flex");
    }

});
</script>

</body>
</html>
