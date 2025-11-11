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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

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
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=1" class="course-thumb" alt="강의1">
			</a>
			<div class="course-info">
				<div class="course-title">드로잉 기초 클래스</div>
				<div class="course-price">₩49,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=2" class="course-thumb" alt="강의2">
			</a>
			<div class="course-info">
				<div class="course-title">파이썬으로 배우는 코딩</div>
				<div class="course-price">₩69,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=3" class="course-thumb" alt="강의3">
			</a>
			<div class="course-info">
				<div class="course-title">영어 회화 마스터</div>
				<div class="course-price">₩59,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=4" class="course-thumb" alt="강의4">
			</a>
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
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=5" class="course-thumb" alt="강의5">
			</a>
			<div class="course-info">
				<div class="course-title">캘리그라피 디자인</div>
				<div class="course-price"><del>₩60,000</del> ₩42,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=6" class="course-thumb" alt="강의6">
			</a>
			<div class="course-info">
				<div class="course-title">웹 퍼블리싱 완성반</div>
				<div class="course-price"><del>₩80,000</del> ₩56,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=7" class="course-thumb" alt="강의7">
			</a>
			<div class="course-info">
				<div class="course-title">기초 일본어 회화</div>
				<div class="course-price"><del>₩65,000</del> ₩45,000</div>
			</div>
		</div>

		<div class="course-card">
			<a href="${pageContext.request.contextPath}/category/lecture">
				<img src="https://picsum.photos/400/250?random=8" class="course-thumb" alt="강의8">
			</a>
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
