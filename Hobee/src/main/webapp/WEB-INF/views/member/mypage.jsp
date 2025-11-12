<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/mypage.css">
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<!-- 메인 영역 -->
<main class="main-content">
 <h1>마이페이지</h1>
 <div class="content-wrapper">
  <div class="main-header">
    <div class="profile-box">
   	    <div class="profile-pic"> 
        	<img src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}" alt="프로필 사진">
        </div>
      <div class="profile-info">
        <p>${user.user_name}</p>
        <p>${user.user_email}</p>
        <p>포인트 &nbsp;${user.points}</p>
      </div>
    </div>
  </div>
  
  <div class="form-container">
      <div class="form-group">
        <label for="userId">아이디</label>
        <span class="form-value">${user.user_id}</span>
      </div>
      
      <div class="form-group">
        <label for="password">비밀번호</label>
        <span class="form-value">${user.user_password}</span>
      </div>
      <div class="form-group">
        <label for="adress">주소</label>
        <span class="form-value">${user.user_address}</span>
      </div>
      <div class="form-group">
        <label for="tel">휴대폰 번호</label>
        <span class="form-value">${user.user_phone}</span>
      </div>
      <div class="form-group">
        <label for="email">이메일</label>
        <span class="form-value">${user.user_email}</span>
      </div>
      <div class="form-group">
        <label for="gender">성별</label>
        <span class="form-value">${user.user_gender}</span>
      </div>
     </div> 
    </div>
  </section>
  
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "login.html";
}
</script>
</body>
</html>
