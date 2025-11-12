<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <!-- ✅ CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/insert.css">

    <!-- ✅ jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="login-container">
    <h2>회원가입</h2>

    <form action="${pageContext.request.contextPath}/user/insertPro" method="post" enctype="multipart/form-data">

        <!-- 아이디 -->
        <div class="form-group">
            <label for="user_id">아이디</label>
            <div style="display:flex; gap:8px;">
                <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력하세요" required>
                <button type="button" id="checkIdBtn"
                    style="width:120px; background:#0d6efd; color:white; border:none; border-radius:8px; cursor:pointer;">
                    중복확인
                </button>
            </div>
            <p id="idCheckMsg" style="margin-top:8px; font-size:14px;"></p>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group">
            <label for="user_password">비밀번호</label>
            <input type="password" id="user_password" name="user_password"
                   placeholder="영문+숫자+특수문자 포함 8~12자" required>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="user_password2">비밀번호 확인</label>
            <input type="password" id="user_password2" placeholder="비밀번호를 다시 입력하세요" required>
            <p id="pwMsg" style="font-size:13px; margin-top:4px;"></p>
        </div>

        <!-- 이름 -->
        <div class="form-group">
            <label for="user_name">이름</label>
            <input type="text" id="user_name" name="user_name" placeholder="이름을 입력하세요" required>
        </div>

        <!-- 이메일 -->
        <div class="form-group">
            <label for="user_email">이메일</label>
            <input type="email" id="user_email" name="user_email" placeholder="이메일을 입력하세요" required>
        </div>

        <!-- 전화번호 -->
        <div class="form-group">
            <label for="user_phone">전화번호</label>
            <input type="text" id="user_phone" name="user_phone" maxlength="13"
                   placeholder="010-0000-0000" required>
            <p id="phoneMsg" style="font-size:13px; margin-top:4px;"></p>
        </div>

        <!-- 주소 -->
        <div class="form-group">
            <label for="user_address">주소</label>
            <input type="text" id="user_address" name="user_address" placeholder="주소를 입력하세요" required>
            <p id="addrMsg" style="font-size:13px; margin-top:4px;"></p>
        </div>

        <!-- 성별 -->
        <div class="form-group">
            <label for="user_gender">성별</label>
            <select id="user_gender" name="user_gender" required>
                <option value="">선택</option>
                <option value="Male">남</option>
                <option value="Female">여</option>
            </select>
        </div>

        <!-- 파일 -->
        <div class="form-group">
            <label for="user_file">프로필 이미지</label>
            <input type="file" id="user_file" name="user_file" accept="image/*" required>
            <p id="fileMsg" style="font-size:13px; margin-top:4px;"></p>
        </div>

        <!-- 회원가입 버튼 -->
        <button type="submit" class="login-btn">회원가입</button>
    </form>

    <div class="bottom-text">
        이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/user/login">로그인</a>
    </div>
</div>

<!-- ✅ 아이디 중복확인 + 유효성검사 통합 스크립트 -->
<script>
$(document).ready(function(){

  /* ------------------------------ *
     아이디 중복확인
  * ------------------------------ */
  $("#checkIdBtn").on("click", function(){
    const userId = $("#user_id").val().trim();
    const msg = $("#idCheckMsg");

    if(userId === "") {
        msg.text("아이디를 입력해주세요.").css("color", "#dc3545");
        return;
    }

    $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/user/checkId",
        data: { user_id: userId },
        success: function(result) {
            if(result === "available") {
                msg.text("✅ 사용 가능한 아이디입니다.").css("color", "#198754");
            } else if(result === "duplicate") {
                msg.text("❌ 이미 존재하는 아이디입니다.").css("color", "#dc3545");
            } else {
                msg.text("⚠ 오류가 발생했습니다. 다시 시도해주세요.").css("color", "#dc3545");
            }
        },
        error: function() {
            msg.text("서버 통신 오류가 발생했습니다.").css("color", "#dc3545");
        }
    });
  });

  /* ------------------------------ *
     유효성검사 + 전화번호 하이픈 + 파일 검사
  * ------------------------------ */
  const pw = $("#user_password");
  const pw2 = $("#user_password2");
  const pwMsg = $("#pwMsg");
  const phone = $("#user_phone");
  const phoneMsg = $("#phoneMsg");
  const addr = $("#user_address");
  const addrMsg = $("#addrMsg");
  const file = $("#user_file");
  const fileMsg = $("#fileMsg");

  $("form").on("submit", function(e){
    let valid = true;

    // ✅ 비밀번호 형식검사
    const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;
    if (!pwPattern.test(pw.val())) {
      pwMsg.text("비밀번호는 영문+숫자+특수문자(!@#$%^*) 포함 8~12자여야 합니다.").css("color", "red");
      valid = false;
    } else {
      pwMsg.text("");
    }

    // ✅ 비밀번호 재확인
    if (pw.val() !== pw2.val()) {
      pwMsg.text("비밀번호가 일치하지 않습니다.").css("color", "red");
      valid = false;
    }

    // ✅ 전화번호 유효성검사
    const phonePattern = /^010-\d{4}-\d{4}$/;
    if (!phonePattern.test(phone.val())) {
      phoneMsg.text("전화번호 형식은 010-0000-0000 입니다.").css("color", "red");
      valid = false;
    } else {
      phoneMsg.text("");
    }

    // ✅ 주소 필수 입력
    if (addr.val().trim() === "") {
      addrMsg.text("주소를 입력해주세요.").css("color", "red");
      valid = false;
    } else {
      addrMsg.text("");
    }

    // ✅ 파일 업로드 필수 검사
    if (file.val().trim() === "") {
      fileMsg.text("프로필 이미지를 업로드해주세요.").css("color", "red");
      valid = false;
    } else {
      fileMsg.text("");
    }

    if (!valid) e.preventDefault();
  });

  // ✅ 전화번호 자동 하이픈
  phone.on("input", function(){
    let value = $(this).val().replace(/[^0-9]/g, "");
    if (value.length < 4) {
      $(this).val(value);
    } else if (value.length < 8) {
      $(this).val(value.slice(0, 3) + "-" + value.slice(3));
    } else {
      $(this).val(value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, 11));
    }
  });

});
</script>
</body>
</html>
