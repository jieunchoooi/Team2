<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
  <h2>로그인 페이지</h2>
  <form action="/user/login" method="post">
    ID: <input type="text" name="userId"><br>
    PW: <input type="password" name="userPassword"><br>
    <input type="submit" value="로그인">
  </form>
</body>
</html>
