<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내 정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/infoUser.css">
</head>
<body>
 <div class="profile-box">
    <h2>${user.user_name}님 정보</h2>

    <div class="profile-item"><span class="label">아이디</span> ${user.user_id}</div>
    <div class="profile-item"><span class="label">이메일</span> ${user.user_email}</div>
    <div class="profile-item"><span class="label">전화번호</span> ${user.user_phone}</div>
    <div class="profile-item"><span class="label">주소</span> ${user.user_address}</div>
    <div class="profile-item"><span class="label">성별</span> ${user.user_gender}</div>

    <c:if test="${not empty user.user_file}">
      <div class="profile-item">
        <span class="label">프로필사진</span><br>
        <img src="/resources/upload/${user.user_file}" width="150" style="border-radius: 10px;">
      </div>
    </c:if>

    <a href="/user/logout" class="logout-btn">로그아웃</a>
  </div>
</body>
</html>
