<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/login.css">
</head>
<body>
<div class="login-container">
    <h2>로그인</h2>

    <form action="${pageContext.request.contextPath}/user/loginPro" method="post" onsubmit="return validateLogin(event)">
        <div class="form-group">
            <label for="user_id">아이디</label>
            <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력하세요" required>
        </div>

        <div class="form-group">
            <label for="user_password">비밀번호</label>
            <input type="password" id="user_password" name="user_password" placeholder="비밀번호를 입력하세요" required>
        </div>

        <div class="form-options">
            <label><input type="checkbox" name="remember"> 자동 로그인</label>
            <a href="#" class="link">비밀번호 찾기</a>
        </div>

        <button type="submit" class="login-btn">로그인</button>
    </form>

    <div class="bottom-text">
        아직 계정이 없으신가요?
        <a href="${pageContext.request.contextPath}/user/insert">회원가입</a>
    </div>
</div>

<script>
function validateLogin(event) {
    const userId = document.getElementById("user_id").value.trim();
    const password = document.getElementById("user_password").value.trim();

    if (userId === "") {
        alert("아이디를 입력해주세요.");
        event.preventDefault();
        return false;
    }
    if (password === "") {
        alert("비밀번호를 입력해주세요.");
        event.preventDefault();
        return false;
    }
    return true;
}
</script>

</body>
</html>

