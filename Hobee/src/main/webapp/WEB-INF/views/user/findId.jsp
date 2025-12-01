<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/findId.css">

  <!-- jQuery & confetti -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

</head>

<body>

<div class="findid-container">

    <h2>아이디 찾기 🔍</h2>
    <p class="desc">
        가입 시 사용한 <b>이름</b>과 <b>이메일 주소</b>를 입력해주세요.
    </p>

    <p id="findMsg" class="msg"></p>

    <form id="findIdForm">
        <div class="form-group">
            <label>이름</label>
            <input type="text" id="user_name" placeholder="이름 입력">
        </div>

        <div class="form-group">
            <label>이메일</label>
            <input type="email" id="user_email" placeholder="example@naver.com">
        </div>

        <button type="submit" class="findid-btn" id="findIdBtn">
            아이디 찾기
        </button>
    </form>

    <div class="bottom-link">
        <a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기 →</a>
    </div>
</div>


<!-- ⭐ 성공 팝업 -->
<div id="emailSuccessPopup" class="join-success-popup" style="display:none;">
    <div class="join-success-box">

        <div class="checkmark-circle">
            <div class="checkmark draw"></div>
        </div>

        <h3 id="emailSuccessTitle">아이디 찾기 완료!</h3>
        <p id="emailSuccessMsg">회원님의 아이디는 아래와 같습니다.</p>

        <!-- 찾은 아이디 -->
        <div id="foundUserId"
             style="font-size:20px; font-weight:700; color:#1e5eff; margin-top:10px;"></div>

        <!-- 복사 버튼 -->
        <button id="copyIdBtn" class="popup-ok-btn">📋 아이디 복사</button>

        <!-- 확인 버튼 -->
        <button id="popupOkBtn" class="popup-ok-btn">확인</button>
    </div>
</div>


<script>
/* ==========================
    아이디 찾기 AJAX
========================== */
$("#findIdForm").on("submit", function(e){
    e.preventDefault();

    const name = $("#user_name").val().trim();
    const email = $("#user_email").val().trim();

    if(name === ""){
        $("#findMsg").text("이름을 입력해주세요.").css("color","red");
        return;
    }
    if(email === ""){
        $("#findMsg").text("이메일을 입력해주세요.").css("color","red");
        return;
    }

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/user/findIdPro",
        data: { user_name: name, user_email: email },
        dataType: "json",

        success: function(res){
            if(res.status === "success") {

                $("#emailSuccessTitle").text("아이디 찾기 완료!");
                $("#emailSuccessMsg").text("회원님의 아이디는 아래와 같습니다.");
                $("#foundUserId").text(res.user_id);

                // 팝업 열기
                $("#emailSuccessPopup").fadeIn(200);

                // confetti
                confetti({
                    particleCount: 120,
                    spread: 80,
                    origin: { y: 0.6 }
                });

            } else {
                $("#findMsg").text(res.msg).css("color","red");
            }
        }
    })
});

/* ==========================
    아이디 복사 기능
========================== */
$(document).on("click", "#copyIdBtn", function () {
    const userId = $("#foundUserId").text();

    const temp = $("<textarea>");
    $("body").append(temp);
    temp.val(userId).select();
    document.execCommand("copy");
    temp.remove();

    $("#emailSuccessMsg")
        .text("아이디가 복사되었습니다! ✔")
        .css("color", "#27ae60");
});

/* ==========================
    확인 버튼 → 로그인 모달 열기
========================== */
$("#popupOkBtn").click(function(){
    $("#emailSuccessPopup").fadeOut(200);
    setTimeout(() => {
        location.href = "${pageContext.request.contextPath}/main/main?openLogin=true";
    }, 200);
});
</script>

</body>
</html>
