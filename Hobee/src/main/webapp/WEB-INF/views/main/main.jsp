<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>취미 온라인 클래스 - HobbyPrep</title>
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

/* 강의 카드 섹션 */
.course-section {
	width: 100%;
	max-width: 1200px;
	margin: 60px auto;
}

.course-section h3 {
	font-size: 1.6rem;
	font-weight: 700;
	text-align: left;
	margin-bottom: 24px;
	padding-left: 10px;
	color: #222;
}

.course-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 24px;
}

.course-card {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	overflow: hidden;
	transition: transform 0.2s, box-shadow 0.2s;
	cursor: pointer;
	text-align: left;
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

.course-price del {
	color: #aaa;
	margin-right: 8px;
	font-weight: 400;
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

<!-- header -->
<jsp:include page="../include/menu.jsp"></jsp:include>


<main>
	<h2>당신의 취미, 더 깊게 즐기세요 🎨</h2>
	<p>다양한 취미 강의로 나만의 여가를 만들어보세요.</p>

	<form class="search-form" onsubmit="searchLecture(event)">
		<input type="text" id="searchInput" placeholder="강의를 검색해보세요" />
		<button type="submit" class="btn">검색</button>
	</form>

	<section class="course-section">
		<h3>인기 강의 🔥</h3>
		<div class="course-grid">
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=1" class="course-thumb" alt="강의1">
				<div class="course-info">
					<div class="course-title">드로잉 기초 클래스</div>
					<div class="course-price">₩49,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=2" class="course-thumb" alt="강의2">
				<div class="course-info">
					<div class="course-title">파이썬으로 배우는 코딩</div>
					<div class="course-price">₩69,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=3" class="course-thumb" alt="강의3">
				<div class="course-info">
					<div class="course-title">영어 회화 마스터</div>
					<div class="course-price">₩59,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=4" class="course-thumb" alt="강의4">
				<div class="course-info">
					<div class="course-title">공예로 힐링하기</div>
					<div class="course-price">₩55,000</div>
				</div>
			</div>
		</div>
	</section>

	<section class="course-section">
		<h3>할인 중인 강의 💸</h3>
		<div class="course-grid">
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=5" class="course-thumb" alt="강의5">
				<div class="course-info">
					<div class="course-title">캘리그라피 디자인</div>
					<div class="course-price"><del>₩60,000</del> ₩42,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=6" class="course-thumb" alt="강의6">
				<div class="course-info">
					<div class="course-title">웹 퍼블리싱 완성반</div>
					<div class="course-price"><del>₩80,000</del> ₩56,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=7" class="course-thumb" alt="강의7">
				<div class="course-info">
					<div class="course-title">기초 일본어 회화</div>
					<div class="course-price"><del>₩65,000</del> ₩45,000</div>
				</div>
			</div>
			<div class="course-card">
				<img src="https://picsum.photos/400/250?random=8" class="course-thumb" alt="강의8">
				<div class="course-info">
					<div class="course-title">도예 취미 클래스</div>
					<div class="course-price"><del>₩70,000</del> ₩49,000</div>
				</div>
			</div>
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
</script>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

</body>
</html>
