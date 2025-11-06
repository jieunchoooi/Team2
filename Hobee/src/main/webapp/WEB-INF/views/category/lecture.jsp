<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hobee 강의 상세 - 디지털 드로잉으로 나만의 캐릭터 만들기</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --text-color: #222;
  --gray: #888;
  --bg: #f9fafc;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Pretendard', sans-serif;
}

body {
  background: var(--bg);
  color: var(--text-color);
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

/* header */
header {
  background: #fff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  padding: 16px 40px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

header h1 {
  color: var(--primary);
  font-size: 1.5rem;
  font-weight: 700;
  cursor: pointer;
}

nav a {
  text-decoration: none;
  color: #333;
  font-weight: 500;
  margin-left: 20px;
  border-radius: 10px;
  padding: 6px 10px;
  transition: background 0.2s;
}

nav a:hover {
  background: var(--hover-bg);
  color: var(--primary);
}

/* 메인 컨테이너 */
main {
  flex: 1;
  display: flex;
  justify-content: center;
  padding: 60px 20px;
}

.detail-container {
  display: flex;
  gap: 50px;
  width: 100%;
  max-width: 1200px;
}

/* 왼쪽 썸네일 */
.detail-left {
  flex: 1;
}

.detail-left img {
  width: 100%;
  border-radius: 16px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

/* 오른쪽 강의 정보 */
.detail-right {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.course-title {
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 10px;
}

.course-instructor {
  font-size: 1rem;
  color: var(--gray);
  margin-bottom: 20px;
}

.course-description {
  line-height: 1.6;
  color: #444;
  margin-bottom: 30px;
}

.price-box {
  background: #fff;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.price-box .price {
  font-size: 1.6rem;
  font-weight: 700;
  color: var(--primary);
  margin-bottom: 12px;
}

.btn-primary {
  background: var(--primary);
  color: #fff;
  border: none;
  width: 100%;
  padding: 14px 0;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-primary:hover {
  background: #1f65e0;
  transform: translateY(-2px);
}

/* 하단 상세 영역 */
.section-container {
  background: #fff;
  border-radius: 20px;
  padding: 50px 40px;
  max-width: 1100px;
  margin: 80px auto;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.section-container h3 {
  font-size: 1.4rem;
  color: var(--primary);
  margin-bottom: 20px;
}

.section-container p {
  color: #444;
  line-height: 1.7;
  margin-bottom: 20px;
}

.curriculum-list {
  list-style: none;
  padding-left: 20px;
}

.curriculum-list li {
  padding: 8px 0;
  border-bottom: 1px solid #eee;
  font-size: 0.95rem;
}

/* 푸터 */
footer {
  background: #fff;
  text-align: center;
  padding: 20px;
  font-size: 0.9rem;
  color: #777;
  border-radius: 20px 20px 0 0;
  box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
}

/* 반응형 */
@media (max-width: 900px) {
  .detail-container {
    flex-direction: column;
    align-items: center;
  }
  .detail-left, .detail-right {
    width: 100%;
  }
}
</style>
</head>
<body>

<header>
  <h1 onclick="location.href='index.html'">Hobee</h1>
  <nav>
    <a href="#">홈</a>
    <a href="#">강의</a>
    <a href="#">커뮤니티</a>
    <a href="#">로그인</a>
  </nav>
</header>

<main>
  <div class="detail-container">
    <div class="detail-left">
      <img src="https://images.squarespace-cdn.com/content/v1/63d40fe2cbd65e16cb8098b6/7da763b6-1122-4c6f-9bfd-2c9c278dff10/image-asset%2B%2831%29.jpeg" 
           alt="디지털 드로잉 클래스 이미지" />
    </div>

    <div class="detail-right">
      <div>
        <h2 class="course-title">디지털 드로잉으로 나만의 캐릭터 만들기</h2>
        <p class="course-instructor">홍길동 · 예체능</p>
        <p class="course-description">
          아이패드와 펜슬만 있다면 누구나 쉽게 시작할 수 있는 디지털 드로잉 입문 클래스!  
          캐릭터 디자인의 기본부터, 나만의 개성을 담은 일러스트 완성까지 함께 해요.
        </p>
      </div>

      <div class="price-box">
        <div class="price">₩39,000</div>
        <button class="btn-primary">수강 신청하기</button>
      </div>
    </div>
  </div>
</main>

<!-- 상세 내용 -->
<section class="section-container">
  <h3>클래스 소개</h3>
  <p>
    디지털 드로잉은 단순한 그림 그리기를 넘어, 자신만의 창의력과 감성을 표현할 수 있는 새로운 방식의 예술입니다.
    이 수업에서는 아이패드 Procreate를 중심으로 도구 사용법, 색감, 구성, 캐릭터 완성까지의 전 과정을 배웁니다.
  </p>

  <h3>커리큘럼</h3>
  <ul class="curriculum-list">
    <li>1강 - 디지털 드로잉 입문 및 도구 세팅</li>
    <li>2강 - 기본 선과 색 표현 배우기</li>
    <li>3강 - 얼굴 구조와 표정 그리기</li>
    <li>4강 - 의상과 포즈 디자인</li>
    <li>5강 - 완성작 만들기 & 피드백</li>
  </ul>

  <h3>수강 후기</h3>
  <p>💬 “그림을 처음 시작했는데 강사님 설명이 너무 쉽고 친절해서 완강했어요!”</p>
  <p>💬 “프로크리에이트 기초부터 실전까지 다뤄서 완전 만족입니다.”</p>
</section>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

</body>
</html>
