<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		$('#submitBtn').click(function(){
			
		}
		
		

</script>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-family: 'Pretendard', sans-serif;
}

body {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #f4f6fa;
}

/* ===========================
   상단 헤더
=========================== */
header {
  background-color: #ffffff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  padding: 16px 32px;
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
  transition: color 0.2s, background 0.2s;
  padding: 6px 10px;
  border-radius: 10px;
}

nav a:hover {
  background-color: #eef5ff;
  color: #2573ff;
}

/* ===========================
   레이아웃
=========================== */
main {
  display: flex;
  flex: 1;
  overflow-y: auto;
}

/* ===========================
   왼쪽 사이드바 
=========================== */
.sidebar {
  width: 250px;
  background-color: #fff;
  box-shadow: 2px 0 10px rgba(0,0,0,0.05);
  display: flex;
  flex-direction: column;
  padding: 30px 20px;
  border-top-right-radius: 0;   /* 위쪽 모서리 제거 */
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
  flex: 1;
  padding: 40px 60px;
  overflow-y: auto;
  margin: 0 auto;
  width: 1000px;
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

/* ===========================
   정보수정 폼 
=========================== */
.form-container {
  background-color: #fff;
  padding: 30px 40px;
  border-radius: 20px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.05);
  max-width: 700px;
    /* ✅ 추가 */
  margin: 0 auto; /* 가운데 정렬 */
  
}

.profile-edit {
  text-align: center;
  margin-bottom: 25px;
}

.profile-edit .profile-pic {
  width: 100px;
  height: 100px;
  font-size: 50px;
  margin: 0 auto 10px;
}

.file-input-label {
  display: inline-block;
  margin-top: 8px;
  padding: 6px 12px;
  background-color: #2573ff;
  color: white;
  border-radius: 20px;
  cursor: pointer;
  font-size: 0.9rem;
}

.file-input {
  display: none;
}

.form-group {
  margin-bottom: 18px;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: #333;
  margin-bottom: 6px;
}

.form-group input {
  width: 100%;
  padding: 12px 14px;
  border: 1px solid #d3ddff;
  border-radius: 12px;
  outline: none;
  font-size: 1rem;
  transition: border-color 0.2s;
}

.form-group input:focus {
  border-color: #2573ff;
}

.btn {
  background-color: #2573ff;
  color: white;
  border: none;
  border-radius: 30px;
  padding: 12px 20px;
  font-size: 1rem;
  cursor: pointer;
  box-shadow: 0 4px 10px rgba(37,115,255,0.25);
  transition: background-color 0.2s, transform 0.1s;
  width: 100%;
  font-weight: 600;
  margin-top: 10px;
}

.btn:hover {
  background-color: #1f65e0;
  transform: translateY(-2px);
}

.btn-delete {
  background-color: #ff4d4f;
}

.btn-delete:hover {
  background-color: #e04344;
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

<!-- 메인 콘텐츠 -->
<main>
  <!-- 왼쪽 사이드바 -->
  <aside class="sidebar">
    <h2></h2>
    <div class="menu">
      <div class="menu-item" onclick="location.href='mypage.jsp'">🏠 <span>MY 홈</span></div>
      <div class="menu-item" onclick="location.href='resume.jsp'">📄 <span>내 강의실</span></div>
      <div class="menu-item" onclick="location.href='scrap.jsp'">⭐ <span>스크랩 / 관심</span></div>
      <div class="menu-item" onclick="location.href='offer.jsp'">💌 <span>내가 쓴 리뷰</span></div>
      <div class="menu-item" onclick="location.href='benefit.jsp'">💳 <span>결제 내역</span></div>
      <!-- ✅ 현재 페이지 -->
      <div class="menu-item active" onclick="location.href='memberEdit.jsp'">👤 <span>회원정보 수정</span></div>
    </div>
    <button class="logout-btn" onclick="logout()">로그아웃</button>
  </aside>

  <!-- 오른쪽 정보 수정 폼 -->
  <form action="${pageContext.request.contextPath}/member/update" method="post">
  <section class="main-content">
    <div class="main-header">
      <div class="profile-box">
        <div class="profile-pic">🐵</div>
        <div class="profile-info">
          <p>홍길동</p>
          <p>hong123</p>
        </div>
      </div>
      <h1>회원정보 수정</h1>
    </div>

    <div class="form-container">
      <div class="profile-edit">
        <div class="profile-pic">🐵</div>
        <label class="file-input-label" for="profilePic">사진 변경</label>
        <input type="file" id="profilePic" class="file-input">
      </div>

      <div class="form-group">
        <label for="userId">아이디</label>
        <input type="text" name="user_id" id="user_id" value="${memberVO.user_id}" readonly>
      </div>

      <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" id="user_password" placeholder="새 비밀번호 입력">
      </div>

      <div class="form-group">
        <label for="nickname">닉네임</label>
        <input type="text" id="user_name" name="user_name" value="${memberVO.user_name}">
      </div>

      <div class="form-group">
        <label for="phone">휴대폰 번호</label>
        <input type="tel" id="user_phone" placeholder="010-1234-5678">
      </div>

      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="user_email" value="hong@hobbyprep.com">
      </div>

      <button class="btn" id="submitBtn">정보 수정</button>
      
      <button class="btn btn-delete">회원 탈퇴</button>
    </div>
  </section>
    </form>
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "login.html";
}
</script>
</body>
</html>
