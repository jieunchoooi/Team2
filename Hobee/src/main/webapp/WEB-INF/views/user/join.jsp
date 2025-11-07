<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h2>회원가입</h2>
<form action="${pageContext.request.contextPath}/user/join" method="post">
	아이디: <input type="text" name="user_id"><br/>
	비밀번호: <input type="password" name="user_password"><br/>
	이름: <input type="text" name="user_name"><br/>
    전화번호: <input type="text" name="user_phone"><br/>
    이메일: <input type="email" name="user_email"><br/>
    주소: <input type="text" name="user_address"><br/>
    성별: <select name="user_gender">
    		<option value="male">남성</option>
    		<option value="female">여성</option>
        </select><br/>
        <button type="submit">가입하기</button>
</form>

</body>
</html>