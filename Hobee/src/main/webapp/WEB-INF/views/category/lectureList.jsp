<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>디지털 드로잉 클래스 - Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
}

/* ------------------ 공통 ------------------ */
main {
	display: flex;
	width: 100%;
	max-width: 1280px;
	margin: 80px auto;
	padding: 0 20px;
	gap: 40px;
}

/* ------------------ 왼쪽 사이드 메뉴 ------------------ */
.sidebar {
	width: 220px;
	background: #fff;
	padding: 20px;
	border-radius: 16px;
	box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	height: fit-content;
}

.sidebar h4 {
	font-size: 1.1rem;
	font-weight: 700;
	margin-bottom: 14px;
	color: #222;
}

.sidebar ul {
	list-style: none;
}

.sidebar li {
	padding: 10px 0;
	cursor: pointer;
	color: #555;
	font-size: 0.95rem;
	transition: color 0.2s;
}

.sidebar li:hover,
.sidebar li.active {
	color: #2573ff;
	font-weight: 600;
}

/* ------------------ 메인 컨텐츠 ------------------ */
.content {
	flex: 1;
}

/* 상단 검색창 */
.search-bar {
	display: flex;
	align-items: center;
	position: relative;
	margin-bottom: 30px;
}

.search-bar i {
	position: absolute;
	left: 15px;
	color: var(--primary, #2573ff);
	font-size: 1rem;
}

.search-bar input {
	width: 100%;
	padding: 12px 16px 12px 40px;
	border: 1px solid #ddd;
	border-radius: 30px;
	font-size: 1rem;
	outline: none;
	transition: border-color 0.2s;
}
.search-bar input:focus {
	border-color: #2573ff;
}

/* ------------------ 섹션 ------------------ */
.section {
	margin-bottom: 60px;
}

.section h3 {
	font-size: 1.4rem;
	font-weight: 700;
	margin-bottom: 20px;
	color: #222;
}

/* ------------------ 카드 공통 ------------------ */
.card {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	overflow: hidden;
	cursor: pointer;
	transition: transform 0.2s, box-shadow 0.2s;
}

.card:hover {
	transform: translateY(-4px);
	box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

.card img {
	width: 100%;
	object-fit: cover;
}

.card-body {
	padding: 10px 12px;
}

.card-title {
	font-size: 1rem;
	font-weight: 600;
	margin-bottom: 6px;
	color: #222;
	line-height: 1.3;
}

.card-price {
	color: #2573ff;
	font-weight: 700;
	font-size: 0.95rem;
}

/* ------------------ Top10 전용 ------------------ */
.top10-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.top10-grid .card img {
	height: 150px; /* 썸네일 크게 */
}

/* ------------------ 전체 클래스 전용 ------------------ */
.all-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
}

.all-grid .card img {
	height: 120px;
}

/* ------------------ footer ------------------ */
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
</style>


</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<main>
	<!-- 왼쪽 사이드 메뉴 -->
	<aside class="sidebar">
	  <ul>
	    <li class="active" data-category="전체">전체</li>
	    <li data-category="디지털드로잉">디지털드로잉</li>
	    <li data-category="드로잉">드로잉</li>
	    <li data-category="공예">공예</li>
	    <li data-category="AI 스킬업">AI 스킬업</li>
	    <li data-category="프로그래밍">프로그래밍</li>
	    <li data-category="데이터사이언스">데이터사이언스</li>
	    <li data-category="영어">영어</li>
	    <li data-category="제2외국어">제2외국어</li>
	    <li data-category="외국어 시험">외국어 시험</li>
	  </ul>
	</aside>


	<!-- 메인 콘텐츠 -->
	<section class="content">
		<div class="search-bar">
			<i class="fa-solid fa-magnifying-glass"></i>
			<input type="text" placeholder="강의를 검색해보세요">
		</div>

		<!-- 🔹 디지털드로잉 Top 10 -->
		<div class="section">
			<h3 id="top10-title">디지털드로잉 Top 10</h3>
				<div class="top10-grid" id="top10-grid">
				    <% for (int i = 1; i <= 3; i++) { %>
				        <a href="${pageContext.request.contextPath}/category/lecture" style="text-decoration: none; color: inherit;">
				            <div class="card">
				                <img src="https://picsum.photos/400/250?random=<%= i %>" alt="강의<%= i %>">
				                <div class="card-body">
				                    <div class="card-title category-title">디지털드로잉 강의 <%= i %></div>
				                    <div class="card-price">₩<%= (45000 + i * 1000) %></div>
				                </div>
				            </div>
				        </a>
				    <% } %>
				</div>
		</div>

		<!-- 🔹 전체 클래스 -->
		<div class="section">
			<h3 id="all-title">전체 강의</h3>
				<div class="all-grid" id="all-grid">
				    <% for (int i = 11; i <= 25; i++) { %>
				        <a href="${pageContext.request.contextPath}/category/lecture" style="text-decoration: none; color: inherit;">
				            <div class="card">
				                <img src="https://picsum.photos/400/250?random=<%= i %>" alt="강의<%= i %>">
				                <div class="card-body">
				                    <div class="card-title category-title">디지털드로잉 강의 <%= i %></div>
				                    <div class="card-price">₩<%= (35000 + i * 900) %></div>
				                </div>
				            </div>
				        </a>
				    <% } %>
				</div>
		</div>
	</section>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
// ✅ 페이지 로드 시 localStorage에 저장된 카테고리 불러오기
window.addEventListener("DOMContentLoaded", () => {
    const savedCategory = localStorage.getItem("selectedCategory");
    if (savedCategory) {
        applyCategory(savedCategory);
        // 저장된 active 표시
        document.querySelectorAll('.sidebar li').forEach(li => {
            li.classList.toggle("active", li.getAttribute("data-category") === savedCategory);
        });
    }
});

// ✅ 카테고리 클릭 이벤트 등록
document.querySelectorAll('.sidebar li').forEach(item => {
    item.addEventListener('click', function() {
        // active 클래스 변경
        document.querySelectorAll('.sidebar li').forEach(li => li.classList.remove('active'));
        this.classList.add('active');

        // 선택된 카테고리 이름 가져오기
        const categoryName = this.getAttribute('data-category');

        // localStorage에 저장
        localStorage.setItem("selectedCategory", categoryName);

        // 카테고리 적용
        applyCategory(categoryName);

        // 🔹 1초 뒤 새로고침
        setTimeout(() => {
            location.reload();
        }, 100);
    });
});

// ✅ 카테고리별 텍스트 변경 함수
function applyCategory(categoryName) {
    // Top 10 제목 변경
    document.getElementById('top10-title').textContent = categoryName + ' Top 10';
    
    // 전체 클래스 제목 변경
    document.getElementById('all-title').textContent =
        categoryName === '전체' ? '전체 강의' : categoryName + ' 강의';
    
    // 카드 제목 변경
    document.querySelectorAll('.category-title').forEach((title, index) => {
        title.textContent = categoryName + ' 강의 ' + (index + 1);
    });
}
</script>



</body>
</html>