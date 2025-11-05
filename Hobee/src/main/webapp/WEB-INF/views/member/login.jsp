<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | Hobee</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Noto Sans KR', sans-serif; }

        body {
            background: linear-gradient(180deg, #f7f9fc 0%, #eaf1f9 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #fff;
            width: 400px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 40px 35px;
            text-align: center;
        }

        h2 {
            color: #0066ff;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        label {
            display: block;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            margin: 12px 0 6px 4px;
            color: #333;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #dcdcdc;
            border-radius: 10px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s;
        }

        input:focus {
            border-color: #0066ff;
            box-shadow: 0 0 0 2px rgba(0,102,255,0.15);
        }

        /* ✅ 자동 로그인 + 비밀번호 찾기 정렬 */
        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 12px 0 20px;
            font-size: 13px;
        }

        .options-left {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .options a {
            color: #0066ff;
            text-decoration: none;
        }

        .options a:hover {
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 13px;
            background-color: #0066ff;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .login-btn:hover {
            background-color: #004edb;
        }

        .bottom-text {
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }

        .bottom-text a {
            color: #0066ff;
            text-decoration: none;
            font-weight: 500;
        }

        .bottom-text a:hover {
            text-decoration: underline;
        }

        /* ✅ 에러 메시지 */
        .error-message {
            color: #ff3333;
            font-size: 13px;
            margin-top: 5px;
            height: 16px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>

        <form onsubmit="return validateLogin(event)"
        action="${ pageContext.request.contextPath }/member/loginPro" class="appForm" method="post" id="appForm">
            <label for="email">이메일</label>
            <input type="text" id="user_email" name="user_email" placeholder="이메일을 입력하세요">

            <label for="password">비밀번호</label>
            <input type="password" id="user_password" name="user_password" placeholder="비밀번호를 입력하세요">

            <div class="error-message" id="errorMsg"></div>

            <div class="options">
                <div class="options-left">
                    <input type="checkbox" id="autoLogin">
                    <label for="autoLogin">자동 로그인</label>
                </div>
                <a href="#">비밀번호 찾기</a>
            </div>

            <button type="submit" class="login-btn">로그인</button>
        </form>

        <div class="bottom-text">
            아직 계정이 없으신가요? <a href="insert.html">회원가입</a>
        </div>
    </div>

    <script>
        // ✅ 자동 로그인 저장된 이메일 불러오기
        window.onload = function() {
            const savedEmail = localStorage.getItem("savedEmail");
            if (savedEmail) {
                document.getElementById("email").value = savedEmail;
                document.getElementById("autoLogin").checked = true;
            }
        }

        // ✅ 로그인 검증 및 이동
        function validateLogin(event) {
            event.preventDefault(); // 🚫 새로고침 방지

            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();
            const errorMsg = document.getElementById("errorMsg");

            errorMsg.textContent = ""; // 초기화

            if (!email || !password) {
                errorMsg.textContent = "이메일과 비밀번호를 모두 입력해주세요.";
                return false;
            }

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                errorMsg.textContent = "올바른 이메일 형식을 입력해주세요.";
                return false;
            }

            // ✅ 테스트용 계정
            const testEmail = "test@hobee.com";
            const testPassword = "1234";

            if (email !== testEmail || password !== testPassword) {
                errorMsg.textContent = "이메일 또는 비밀번호가 올바르지 않습니다.";
                return false;
            }

            // ✅ 자동 로그인 저장
            const autoLogin = document.getElementById("autoLogin").checked;
            if (autoLogin) {
                localStorage.setItem("savedEmail", email);
            } else {
                localStorage.removeItem("savedEmail");
            }

            alert("로그인 성공!");

            // ✅ index.html로 이동
            window.location.href = "index.html";
            return true;
        }
    </script>
</body>
</html>
