<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>취미 온라인 클래스 - Hobee</title>
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --text-color: #222;
  --subtext: #555;
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

/* 헤더 */
header {
	background: #fff;
	box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	padding: 16px 40px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	position: relative;
	z-index: 100;
}

header h1 {
	color: var(--primary);
	font-size: 1.5rem;
	font-weight: 700;
}

nav {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 100%;
}

.nav-left {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-left: 25px;
}

.nav-right {
	display: flex;
	align-items: center;
	gap: 12px;
}

nav a {
	text-decoration: none;
	color: #333;
	font-weight: 500;
	padding: 6px 10px;
	border-radius: 10px;
	transition: background 0.2s;
}

nav a:hover {
	background: var(--hover-bg);
	color: var(--primary);
}

.auth-link {
	font-size: 0.85rem;
	color: var(--gray);
	padding: 4px 8px;
	border-radius: 8px;
	transition: color 0.2s, background 0.2s;
}

.auth-link:hover {
	color: var(--primary);
	background: var(--hover-bg);
}

/* 드롭다운 */
.mega-dropdown {
	position: relative;
}
.mega-content {
	display: none;
	position: absolute;
	top: 100%;
	left: 50%;
	transform: translateX(-20%) translateY(22px);
	background: #fff;
	box-shadow: 0 4px 16px rgba(0,0,0,0.1);
	border-radius: 12px;
	padding: 30px 40px;
	z-index: 9999;
	white-space: nowrap;
	min-width: 900px;
	max-width: calc(100vw - 40px);
	overflow-x: auto;
}

.mega-column {
	flex: 1;
	min-width: 200px;
}

.mega-column h3 {
	color: var(--primary);
	margin-bottom: 12px;
	font-size: 1rem;
}

/* 메인 */
main {
	flex: 1;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 60px 20px;
}

main h2 {
	font-size: 2rem;
	font-weight: 700;
	margin-bottom: 10px;
}

main p {
	color: var(--subtext);
	max-width: 600px;
	line-height: 1.6;
	margin-bottom: 40px;
	text-align: center;
}

/* 강의 카드 영역 */
.course-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 24px;
	width: 100%;
	max-width: 1200px;
	margin-top: 20px;
}

.course-card {
	background: #fff;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
	transition: transform 0.2s, box-shadow 0.2s;
	cursor: pointer;
}

.course-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

.course-card img {
	width: 100%;
	height: 160px;
	object-fit: cover;
}

.course-info {
	padding: 16px;
	text-align: left;
}

.course-info h3 {
	font-size: 1.1rem;
	margin-bottom: 8px;
	color: #111;
}

.course-info p {
	color: var(--gray);
	font-size: 0.9rem;
	margin-bottom: 6px;
}

.course-price {
	font-weight: 700;
	color: var(--primary);
	font-size: 1rem;
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
	margin-top: 60px;
}

/* 반응형 */
@media (max-width: 768px) {
	header {
		flex-direction: column;
		align-items: flex-start;
		padding: 16px 20px;
	}
	.nav-left {
		flex-direction: column;
		align-items: flex-start;
		margin-left: 0;
	}
}
</style>
</head>
<body>

<header>
	<h1>Hobee</h1>
	<nav>
		<div class="nav-left">
			<a href="#">홈</a>
			<a href="#">강의</a>
			<a href="#">커뮤니티</a>
		</div>
		<div class="nav-right">
			<a href="#" class="auth-link">로그인</a>
			<a href="#" class="auth-link">회원가입</a>
		</div>
	</nav>
</header>

<main>
	<h2>지금 인기 있는 취미 클래스🔥</h2>
	<p>클래스101처럼 당신의 여가를 성장으로 바꿔보세요.</p>

	<div id="courseList" class="course-grid"></div>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
// 임시 하드코딩 데이터
const courses = [
  {
    id: 1,
    title: "디지털 드로잉으로 나만의 캐릭터 만들기",
    category: "예체능",
    instructor: "홍길동",
    price: 39000,
    image: "https://images.squarespace-cdn.com/content/v1/63d40fe2cbd65e16cb8098b6/7da763b6-1122-4c6f-9bfd-2c9c278dff10/image-asset%2B%2831%29.jpeg"

  },
  {
    id: 2,
    title: "Python으로 데이터 분석 입문",
    category: "IT",
    instructor: "이코딩",
    price: 59000,
    image: "https://images.squarespace-cdn.com/content/v1/63d40fe2cbd65e16cb8098b6/7da763b6-1122-4c6f-9bfd-2c9c278dff10/image-asset%2B%2831%29.jpeg"
  },
  {
    id: 3,
    title: "영어 회화 마스터클래스",
    category: "외국어",
    instructor: "Jane Kim",
    price: 49000,
    image: "https://images.unsplash.com/photo-1529070538774-1843cb3265df?auto=format&fit=crop&w=600&q=80"
  },
  {
    id: 4,
    title: "손으로 만드는 감성 도자기 공예",
    category: "예체능",
    instructor: "박예술",
    price: 65000,
    image: "https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?auto=format&fit=crop&w=600&q=80"
  },
  {
    id: 5,
    title: "HTML+CSS로 웹페이지 만들기",
    category: "IT",
    instructor: "최프론트",
    price: 45000,
    image: "https://images.squarespace-cdn.com/content/v1/63d40fe2cbd65e16cb8098b6/7da763b6-1122-4c6f-9bfd-2c9c278dff10/image-asset%2B%2831%29.jpeg"
  },
  {
    id: 6,
    title: "스페인어 입문 30일 완성",
    category: "외국어",
    instructor: "Carlos Lee",
    price: 39000,
    image: "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc?auto=format&fit=crop&w=600&q=80"
  }
];

// 강의 데이터 렌더링
function renderCourses() {
  const container = document.getElementById("courseList");
  container.innerHTML = courses.map(c => `
    <div class="course-card" onclick="alert('${c.title} 상세페이지로 이동 예정')">
      <img src="${c.image}" alt="${c.title}">
      <div class="course-info">
        <p>${c.category} · ${c.instructor}</p>
        <h3>${c.title}</h3>
        <div class="course-price">${c.price.toLocaleString()}원</div>
      </div>
    </div>
  `).join('');
}

document.addEventListener("DOMContentLoaded", renderCourses);
</script>

</body>
</html>
