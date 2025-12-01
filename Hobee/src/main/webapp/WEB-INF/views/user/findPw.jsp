<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인/회원가입 모달 포함 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/findPw.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<div class="findpw-container">

    <h2>비밀번호 찾기 🔑</h2>
    <p class="desc">
        가입 시 등록한 <b>아이디</b>와 <b>이메일 주소</b>를 입력해주세요.<br>
        일치하는 회원 정보가 있다면 임시 비밀번호를 이메일로 발송합니다.
    </p>

    <p id="pwMsg" class="msg"></p>

    <form id="findPwForm">

        <div class="form-group">
            <label for="user_id">아이디</label>
            <input type="text" id="user_id" name="user_id" placeholder="아이디 입력">
        </div>

        <div class="form-group">
            <label for="user_email">이메일</label>
            <input type="email" id="user_email" name="user_email" placeholder="example@naver.com">
        </div>

        <button type="submit" class="findpw-btn" id="findPwBtn">
            <span id="btnText">임시 비밀번호 발송</span>
            <div id="btnSpinner" class="spinner" style="display:none;"></div>
        </button>

    </form>

    <div class="bottom-link">
        <a href="${pageContext.request.contextPath}/user/findId">아이디 찾기 →</a>
    </div>

    <div class="bottom-link" style="margin-top:10px;">
        <a href="${pageContext.request.contextPath}/main/main?openLogin=true">로그인으로 돌아가기</a>
    </div>
</div>


<!-- ⭐ 비밀번호 찾기 성공 팝업 -->
<div id="emailSuccessPopup" class="join-success-popup" style="display:none;">
    <div class="join-success-box">
        <div class="checkmark-circle">
            <div class="checkmark draw"></div>
        </div>

        <h3 id="emailSuccessTitle">비밀번호 발송 완료!</h3>
        <p id="emailSuccessMsg">임시 비밀번호가 이메일로 발송되었습니다 😊</p>

        <button id="popupOkBtn" class="popup-ok-btn">확인</button>
    </div>
</div>


<script>
// ============================
// 🔥 비밀번호 찾기 AJAX
// ============================
$("#findPwForm").on("submit", function(e){
    e.preventDefault();

    const id = $("#user_id").val().trim();
    const email = $("#user_email").val().trim();

    if(id === ""){
        $("#pwMsg").text("아이디를 입력해주세요.").css("color","red");
        return;
    }

    if(email === ""){
        $("#pwMsg").text("이메일을 입력해주세요.").css("color","red");
        return;
    }

    const emailPattern=/^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,}$/;
    if(!emailPattern.test(email)){
        $("#pwMsg").text("이메일 형식이 올바르지 않습니다.").css("color","red");
        return;
    }

    /* 🔥 버튼 로딩 활성화 */
        $("#findPwBtn").addClass("loading");
        $("#btnText").hide();
        $("#btnSpinner").show();

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/user/findPwPro",
        data: { user_id: id, user_email: email },
        dataType: "json",

        success: function(res){

            /* 로딩 스피너 해제 */
            $("#findPwBtn").removeClass("loading");
            $("#btnText").show();
            $("#btnSpinner").hide();

            if(res.status === "success"){

                // 팝업 텍스트 변경
                $("#emailSuccessTitle").text("비밀번호 발송 완료!");
                $("#emailSuccessMsg").text(res.msg);

                // 팝업 열기
                $("#emailSuccessPopup").fadeIn(200);

                // confetti
                confetti({
                    particleCount: 140,
                    spread: 100,
                    origin: { y: 0.6 }
                });

            } else {
                $("#pwMsg").text(res.msg).css("color","red");
            }
        },

        error: function(){

            /* 로딩 스피너 해제 */
            $("#findPwBtn").removeClass("loading");
            $("#btnText").show();
            $("#btnSpinner").hide();

            $("#pwMsg").text("서버 오류가 발생했습니다.").css("color","red");
        }
    });
});


// ============================
// ✔ 확인 버튼 → 로그인 페이지로 이동
// ============================
$("#popupOkBtn").click(function () {
    $("#emailSuccessPopup").fadeOut(200);

    setTimeout(() => {
        location.href = "${pageContext.request.contextPath}/main/main?openLogin=true";
    }, 200);
});
</script>

</body>
</html>