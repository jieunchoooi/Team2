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

  // ================================
  // 1) 아이디 중복확인 체크 여부
  // ================================
  let isIdChecked = false;  // 🔥 아이디 중복확인 통과 여부

  // ================================
  // 2) 아이디 입력 시 패턴 검사 + 중복확인 초기화
  // ================================
  $("#user_id").on("input", function(){
    const id = $(this).val();
    const idPattern = /^[A-Za-z0-9]{1,8}$/;
    const msg = $("#idCheckMsg");

    // 입력이 바뀌면 다시 중복확인 해야 함!
    isIdChecked = false;

    if (!idPattern.test(id)) {
      msg.text("❌ 영문 + 숫자 8자 이내로 입력해주세요.").css("color","#dc3545");
    } else {
      msg.text("");
    }
  });

  // ================================
  // 3) 중복확인 버튼 클릭 시
  // ================================
  $("#checkIdBtn").on("click", function(){
    const userId = $("#user_id").val().trim();
    const msg = $("#idCheckMsg");
    const idPattern = /^[A-Za-z0-9]{1,8}$/;

    if(userId === ""){
      msg.text("아이디를 입력해주세요.").css("color","#dc3545");
      return;
    }

    if(!idPattern.test(userId)){
      msg.text("❌ 영문+숫자 조합 8자 이내로 입력해주세요.").css("color","#dc3545");
      return;
    }

    $.ajax({
      type: "GET",
      url: "${pageContext.request.contextPath}/user/checkId",
      data: { user_id: userId },
      success: function(result){
        if(result === "available"){
          msg.text("✅ 사용 가능한 아이디입니다.").css("color","#198754");
          isIdChecked = true;   // 🔥 성공 처리
        } else {
          msg.text("❌ 이미 존재하는 아이디입니다.").css("color","#dc3545");
          isIdChecked = false;
        }
      },
      error: function(){
        msg.text("서버 통신 오류").css("color","#dc3545");
      }
    });
  });

  // ================================
  // 4) 회원가입 submit 검증 (최종 방어)
  // ================================
  $("form").on("submit", function(e){

    // (1) 아이디 중복확인 했는지 체크
    if (!isIdChecked) {
      alert("아이디 중복확인을 먼저 해주세요!");
      $("#user_id").focus();
      e.preventDefault();
      return false;
    }

    // (2) 비밀번호 패턴 검사
    const pw = $("#user_password").val();
    const pw2 = $("#user_password2").val();
    const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;

    if(!pwPattern.test(pw)){
      alert("비밀번호는 영문+숫자+특수문자 포함 8~12자입니다.");
      e.preventDefault();
      return false;
    }

    if(pw !== pw2){
      alert("비밀번호가 일치하지 않습니다.");
      e.preventDefault();
      return false;
    }

    // (3) 전화번호 검사
    const phonePattern = /^010-\d{4}-\d{4}$/;
    if(!phonePattern.test($("#user_phone").val())){
      alert("전화번호 형식은 010-0000-0000 입니다.");
      e.preventDefault();
      return false;
    }

    // (4) 약관 체크
    const checked = $(".agree-item[required]").toArray().every(chk => chk.checked);
    if(!checked){
      alert("약관 동의(필수)를 체크해주세요.");
      e.preventDefault();
      return false;
    }

  });

  // ================================
  // 전화번호 자동 하이픈
  // ================================
  $("#user_phone").on("input", function(){
    let value = $(this).val().replace(/[^0-9]/g, "");
    if (value.length < 4) $(this).val(value);
    else if (value.length < 8) $(this).val(value.slice(0,3)+"-"+value.slice(3));
    else $(this).val(value.slice(0,3)+"-"+value.slice(3,7)+"-"+value.slice(7,11));
  });

  // ================================
  // 약관 전체동의
  // ================================
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
