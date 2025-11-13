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

    <!-- ✅ 파일 업로드 제거 -->
    <form id="joinForm" action="${pageContext.request.contextPath}/user/insertPro" method="post">

        <!-- ✅ 아이디 -->
        <div class="form-group" id="id-group">
            <label for="user_id">아이디</label>
            <input type="text" id="user_id" name="user_id" maxlength="8" placeholder="아이디를 입력하세요" required>
            <button type="button" id="checkIdBtn">중복확인</button>
        </div>
        <p id="idCheckMsg" class="msg"></p>

        <!-- ✅ 비밀번호 -->
        <div class="form-group">
            <label for="user_password">비밀번호</label>
            <input type="password" id="user_password" name="user_password"
                   placeholder="영문+숫자+특수문자 포함 8~12자" required>
        </div>

        <!-- ✅ 비밀번호 확인 -->
        <div class="form-group">
            <label for="user_password2">비밀번호 확인</label>
            <input type="password" id="user_password2" placeholder="비밀번호를 다시 입력하세요" required>
            <p id="pwMsg" class="msg"></p>
        </div>

        <!-- ✅ 이름 -->
        <div class="form-group">
            <label for="user_name">이름</label>
            <input type="text" id="user_name" name="user_name" placeholder="이름을 입력하세요" required>
        </div>

        <!-- ✅ 이메일 -->
        <div class="form-group">
            <label for="user_email">이메일</label>
            <input type="email" id="user_email" name="user_email" placeholder="이메일을 입력하세요" required>
        </div>

        <!-- ✅ 전화번호 -->
        <div class="form-group">
            <label for="user_phone">전화번호</label>
            <input type="text" id="user_phone" name="user_phone" maxlength="13" placeholder="010-0000-0000" required>
        </div>

        <!-- ✅ 주소 -->
        <div class="form-group">
            <label for="user_address">주소</label>
            <input type="text" id="user_address" name="user_address" placeholder="주소를 입력하세요" required>
        </div>

        <!-- ✅ 성별 -->
        <div class="form-group">
            <label for="user_gender">성별</label>
            <select id="user_gender" name="user_gender" required>
                <option value="">선택</option>
                <option value="Male">남</option>
                <option value="Female">여</option>
            </select>
        </div>

        <!-- ✅ 약관 동의 -->
        <div class="form-group terms">
            <h4>약관 동의</h4>
            <div class="terms-box">
                <label><input type="checkbox" id="agreeAll"> <strong>모두 동의합니다</strong></label>
                <hr>
                <label><input type="checkbox" class="agree-item" required> 이용약관에 동의합니다 (필수)</label><br>
                <label><input type="checkbox" class="agree-item" required> 개인정보 수집 및 이용에 동의합니다 (필수)</label>
            </div>
        </div>

        <!-- ✅ 회원가입 버튼 -->
        <button type="submit" class="login-btn">회원가입</button>
    </form>

    <div class="bottom-text">
        이미 계정이 있으신가요?
        <a href="${pageContext.request.contextPath}/user/login">로그인</a>
    </div>
</div>

<!-- ✅ 유효성 검사 스크립트 -->
<script>
$(document).ready(function(){

  // ✅ 아이디 입력 시: 영문+숫자만, 8자리 이내
  $("#user_id").on("input", function(){
    const id = $(this).val();
    const idPattern = /^[A-Za-z0-9]{1,8}$/; // 영문+숫자, 최대 8자
    const msg = $("#idCheckMsg");

    if (!idPattern.test(id)) {
      msg.text("❌ 아이디는 영문과 숫자 조합, 8자 이내로 입력해주세요.").css("color", "#dc3545");
    } else {
      msg.text("");
    }
  });

  // ✅ 아이디 중복확인
  $("#checkIdBtn").on("click", function(){
    const userId = $("#user_id").val().trim();
    const msg = $("#idCheckMsg");
    const idPattern = /^[A-Za-z0-9]{1,8}$/;

    if(userId === ""){
      msg.text("아이디를 입력해주세요.").css("color","#dc3545");
      return;
    }

    if(!idPattern.test(userId)){
      msg.text("❌ 아이디는 영문과 숫자 조합, 8자 이내로 입력해주세요.").css("color","#dc3545");
      return;
    }

    $.ajax({
      type: "GET",
      url: "${pageContext.request.contextPath}/user/checkId",
      data: { user_id: userId },
      success: function(result){
        if(result === "available"){
          msg.text("✅ 사용 가능한 아이디입니다.").css("color","#198754");
        } else if(result === "duplicate"){
          msg.text("❌ 이미 존재하는 아이디입니다.").css("color","#dc3545");
        } else {
          msg.text("⚠ 오류가 발생했습니다. 다시 시도해주세요.").css("color","#dc3545");
        }
      },
      error: function(){
        msg.text("서버 통신 오류가 발생했습니다.").css("color","#dc3545");
      }
    });
  });

  // ✅ 비밀번호 / 전화번호 / 약관 검사
  $("form").on("submit", function(e){
    let valid = true;

    const pw = $("#user_password").val();
    const pw2 = $("#user_password2").val();
    const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;
    const phonePattern = /^010-\d{4}-\d{4}$/;

    if (!pwPattern.test(pw)) {
      alert("비밀번호는 영문+숫자+특수문자 포함 8~12자여야 합니다.");
      valid = false;
    } else if (pw !== pw2) {
      alert("비밀번호가 일치하지 않습니다.");
      valid = false;
    }

    if (!phonePattern.test($("#user_phone").val())) {
      alert("전화번호 형식은 010-0000-0000 입니다.");
      valid = false;
    }

    const allChecked = $(".agree-item[required]").toArray().every(chk => chk.checked);
    if(!allChecked){
      alert("약관 및 개인정보 수집에 모두 동의해야 합니다.");
      valid = false;
    }

    if (!valid) e.preventDefault();
  });

  // ✅ 전화번호 자동 하이픈
  $("#user_phone").on("input", function(){
    let value = $(this).val().replace(/[^0-9]/g, "");
    if (value.length < 4) $(this).val(value);
    else if (value.length < 8) $(this).val(value.slice(0,3)+"-"+value.slice(3));
    else $(this).val(value.slice(0,3)+"-"+value.slice(3,7)+"-"+value.slice(7,11));
  });

  // ✅ 약관 전체 동의
  $("#agreeAll").on("change", function(){
      $(".agree-item").prop("checked", $(this).is(":checked"));
  });
  $(".agree-item").on("change", function(){
      if(!$(this).is(":checked")){
          $("#agreeAll").prop("checked", false);
      }
  });

});
</script>
</body>
</html>
