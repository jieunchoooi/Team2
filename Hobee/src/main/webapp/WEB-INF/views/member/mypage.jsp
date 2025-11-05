<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/mypageCommon.css">

</head>
<body>

<!-- 상단 헤더 -->
<header>
  <h1><a href="${pageContext.request.contextPath }/main/main">Hobee</a></h1>
  <nav>
    <a href="${pageContext.request.contextPath }/main/main">홈</a>
    <a href="courses.html">카테고리</a>
    <a href="mypage.jsp">마이페이지</a>
    <a href="login.html" onclick="logout()">로그아웃</a>
  </nav>
</header>

<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<!-- 메인 영역 -->
<main class="main-content">
  <div class="main-header">
    <div class="profile-box">
      <div class="profile-pic">🐵</div>
      <div class="profile-info">
        <p>홍길동</p>
        <p>hong123</p>
      </div>
    </div>
    <h1>마이페이지</h1>
  </div>

  <div class="card-container">
    <div class="card">
      <h3>내 강의실</h3>
      <p>0개</p>
    </div>
    <div class="card">
      <h3>내가 쓴 리뷰</h3>
      <p>0건</p>
    </div>
    <div class="card">
      <h3>관심목록</h3>
      <p>2개</p>
    </div>
    <div class="card">
      <h3>문의내역</h3>
      <p>1건</p>
    </div>
  </div>
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "login.html";
}
</script>
</body>
</html>
