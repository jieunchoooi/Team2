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
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Pretendard', sans-serif;
}

body {
	background: #f9fafc;
	color: #222;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

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
	color: #2573ff;
	font-size: 1.5rem;
	font-weight: 700;
}

/* h1 안의 a태그 밑줄 제거 + 색상 상속 */
header h1 a {
	text-decoration: none;
	color: inherit;
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
	background: #eef5ff;
	color: #2573ff;
}

.auth-link {
	font-size: 0.85rem;
	color: #888;
	padding: 4px 8px;
	border-radius: 8px;
	transition: color 0.2s, background 0.2s;
}

.auth-link:hover {
	color: #2573ff;
	background: #eef5ff;
}

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

.mega-dropdown:hover .mega-content {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.mega-column {
	flex: 1;
	min-width: 200px;
}

.mega-column h3 {
	color: #2573ff;
	margin-bottom: 12px;
	font-size: 1rem;
}

.mega-column ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.mega-column ul li {
	margin-bottom: 8px;
}

.mega-column ul li a {
	text-decoration: none;
	color: #333;
	font-size: 0.95rem;
	transition: color 0.2s;
}

.mega-column ul li a:hover {
	color: #2573ff;
}

/* 메인 컨텐츠 */
main {
	flex: 1;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 80px 20px;
	text-align: center;
}

main h2 {
	font-size: 2rem;
	font-weight: 700;
	margin-bottom: 16px;
}

main p {
	color: #555;
	max-width: 500px;
	line-height: 1.6;
	margin-bottom: 30px;
}

.btn {
	background: #2573ff;
	color: white;
	border: none;
	padding: 14px 28px;
	border-radius: 30px;
	font-size: 1rem;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(37,115,255,0.25);
	transition: background 0.2s, transform 0.1s;
}

.btn:hover {
	background: #1f65e0;
	transform: translateY(-2px);
}

/* 🔥 강의 카드 슬라이드 섹션 */
.course-section {
	width: 100%;
	max-width: 1200px;
	margin: 60px auto;
	overflow: hidden;
}

.course-section h3 {
	font-size: 1.6rem;
	font-weight: 700;
	text-align: left;
	margin-bottom: 24px;
	padding-left: 10px;
	color: #222;
}

.course-slider {
	display: flex;
	flex-direction: column;
	gap: 30px;
}

.course-row {
	display: flex;
	gap: 20px;
	transition: transform 1s ease;
}

.course-card {
	flex: 0 0 calc(20% - 20px);
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	overflow: hidden;
	text-align: left;
	transition: transform 0.2s, box-shadow 0.2s;
	cursor: pointer;
	min-width: 200px;
}

.course-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

.course-thumb {
	width: 100%;
	height: 160px;
	object-fit: cover;
}

.course-info {
	padding: 16px;
}

.course-title {
	font-size: 1rem;
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
}

.course-price {
	color: #2573ff;
	font-weight: 700;
}

/* 검색폼 스타일 */
.search-form {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.search-form input {
	padding: 12px 16px;
	font-size: 1rem;
	border: 1px solid #ccc;
	border-radius: 30px;
	width: 350px;
	outline: none;
	transition: border-color 0.2s;
}

.search-form input:focus {
	border-color: #2573ff;
}

footer {
	background: #fff;
	text-align: center;
	padding: 20px;
	font-size: 0.9rem;
	color: #777;
	border-radius: 20px 20px 0 0;
	box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
}
</style>
</head>
<body>

<header>
	<h1><a href="/">Hobee</a></h1>
	<nav>
		<div class="nav-left">
			<div class="mega-dropdown">
				<a href="#">카테고리 ▾</a>
				<div class="mega-content">
					<div class="mega-column">
						<h3>예체능</h3>
						<ul>
							<li><a href="#">디지털 드로잉</a></li>
							<li><a href="#">드로잉</a></li>
							<li><a href="#">공예</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>IT</h3>
						<ul>
							<li><a href="#">AI 스킬업</a></li>
							<li><a href="#">프로그래밍</a></li>
							<li><a href="#">데이터사이언스</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>외국어</h3>
						<ul>
							<li><a href="#">영어</a></li>
							<li><a href="#">외국어 시험</a></li>
							<li><a href="#">제2 외국어</a></li>
						</ul>
					</div>
				</div>
			</div>
			<a href="#">홈</a>
			<a href="#">강의</a>
		</div>

		<div class="nav-right">
			<a href="#" class="auth-link">로그인</a>
			<a href="#" class="auth-link">회원가입</a>
		</div>
	</nav>
</header>

<main>
	<h2>디지털 드로잉 페이지 🎨</h2>

	<form class="search-form" onsubmit="searchLecture(event)">
		<input type="text" id="searchInput" placeholder="강의를 검색해보세요" />
		<button type="submit" class="btn">검색</button>
	</form>

	<!-- 🔥 강의 슬라이드 섹션 -->
	<section class="course-section">
		<h3>인기 강의 🔥</h3>
		<div class="course-slider" id="courseSlider">
			<% for (int r = 0; r < 4; r++) { %>
			<div class="course-row">
				<% for (int i = 1; i <= 5; i++) { %>
				<div class="course-card">
					<img src="https://picsum.photos/400/250?random=<%= (r*5+i) %>" class="course-thumb" alt="강의<%= (r*5+i) %>">
					<div class="course-info">
						<div class="course-title">강의 제목 <%= (r*5+i) %></div>
						<div class="course-price">₩<%= (40000 + (r*5+i)*1000) %></div>
					</div>
				</div>
				<% } %>
			</div>
			<% } %>
		</div>
	</section>
</main>

<script>
function searchLecture(event) {
	event.preventDefault();
	const query = document.getElementById('searchInput').value.trim();
	if (!query) {
		alert('검색어를 입력해주세요!');
		return;
	}
	window.location.href = '/search?query=' + encodeURIComponent(query);
}

// 🔥 2초마다 한 줄씩 슬라이드
let currentIndex = 0;
const rows = document.querySelectorAll(".course-row");
function slideRows() {
	rows.forEach((row, i) => {
		const offset = (i - currentIndex) * 100;
		row.style.transform = `translateY(${offset}%)`;
	});
	currentIndex = (currentIndex + 1) % rows.length;
}
setInterval(slideRows, 2000);
</script>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>
</body>
</html>
