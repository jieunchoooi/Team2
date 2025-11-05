<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-family: 'Pretendard', sans-serif;
}

body {
  display: flex;
  height: 100vh;
  background-color: #f4f6fa;
  overflow: hidden;
}

/* ===========================
   상단 헤더 (고정)
=========================== */
header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 64px; /* 헤더 높이 */
  z-index: 1000;
  background-color: #ffffff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  padding: 0 32px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

header h1 {
  color: #2573ff;
  font-size: 1.5rem;
  font-weight: 700;
}

nav a {
  margin-left: 20px;
  text-decoration: none;
  color: #333;
  font-weight: 500;
  padding: 6px 10px;
  border-radius: 10px;
  transition: color 0.2s, background 0.2s;
}

nav a:hover {
  background-color: #eef5ff;
  color: #2573ff;
}

/* ===========================
   왼쪽 사이드바 (고정)
=========================== */
.sidebar {
  width: 250px;
  background-color: #fff;
  box-shadow: 2px 0 10px rgba(0,0,0,0.05);
  display: flex;
  flex-direction: column;
  padding: 30px 20px;
  position: fixed;
  top: 64px; /* 헤더 높이만큼 아래로 */
  height: calc(100vh - 64px);
}

.sidebar h2 {
  color: #2573ff;
  font-weight: 700;
  font-size: 1.4rem;
  margin-bottom: 40px;
  text-align: center;
}

.menu {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 12px 15px;
  border-radius: 10px;
  font-weight: 500;
  color: #333;
  cursor: pointer;
  transition: background 0.2s, color 0.2s;
}

.menu-item:hover, .menu-item.active {
  background-color: #eef5ff;
  color: #2573ff;
}

.menu-item span {
  margin-left: 10px;
}

.logout-btn {
  background-color: #ff4d4f;
  color: #fff;
  border: none;
  border-radius: 30px;
  padding: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s;
  box-shadow: 0 4px 10px rgba(255,77,79,0.25);
}

.logout-btn:hover {
  background-color: #e04344;
}

/* ===========================
   메인 콘텐츠
=========================== */
.main-content {
  margin-left: 250px; /* 사이드바 폭 */
  padding: 40px 60px;
  padding-top: 104px; /* 헤더(64px) + 여유 공간 40px */
  height: calc(100vh - 64px);
  overflow-y: auto;
}

.main-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.main-header h1 {
  font-size: 1.8rem;
  font-weight: 700;
  color: #333;
}

.card-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* 2열로 고정 */
  row-gap: 30px;
  column-gap: 40px;
}


.card {
  background-color: #fff;
  border-radius: 16px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.05);
  padding: 25px;
  transition: transform 0.2s;
  width: 350px;
  height: 150px;
}

.card:hover {
  transform: translateY(-3px);
}

.card h3 {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 10px;
  color: #2573ff;
}

.card p {
  color: #555;
  font-size: 0.95rem;
}

/* ===========================
   프로필 영역
=========================== */
.profile-box {
  display: flex;
  align-items: center;
  gap: 15px;
}

.profile-pic {
  width: 60px;
  height: 60px;
  background-color: #d3ddff;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 30px;
}

.profile-info p:first-child {
  font-weight: 600;
}
.profile-info p:last-child {
  font-size: 0.9rem;
  color: #777;
}
</style>
</head>
<body>

<!-- 상단 헤더 -->
<header>
  <h1>Hobee</h1>
  <nav>
    <a href="index.html">홈</a>
    <a href="courses.html">강의</a>
    <a href="mypage.jsp">마이페이지</a>
    <a href="login.html" onclick="logout()">로그아웃</a>
  </nav>
</header>

<!-- 사이드바 -->
<aside class="sidebar">
  <h2></h2>
  <div class="menu">
    <div class="menu-item active" onclick="location.href='mypage.jsp'">🏠 <span>MY 홈</span></div>
    <div class="menu-item" onclick="location.href='resume.jsp'">📄 <span>내 강의실</span></div>
    <div class="menu-item" onclick="location.href='scrap.jsp'">⭐ <span>스크랩 / 관심</span></div>
    <div class="menu-item" onclick="location.href='offer.jsp'">💌 <span>내가 쓴 리뷰</span></div>
    <div class="menu-item" onclick="location.href='benefit.jsp'">💳 <span>결제 내역</span></div>
    <div class="menu-item" onclick="location.href='memberEdit.jsp'">👤 <span>회원정보 수정</span></div>
  </div>

  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>

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
