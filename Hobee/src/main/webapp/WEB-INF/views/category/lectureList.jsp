<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${param.category == null ? "전체" : param.category} 클래스 - Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ====== 기본 스타일 ====== */
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
main {
	display: flex;
	width: 100%;
	max-width: 1280px;
	margin: 80px auto;
	padding: 0 20px;
	gap: 40px;
}
.sidebar {
	width: 220px;
	background: #fff;
	padding: 20px;
	border-radius: 16px;
	box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	height: fit-content;
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
.content {
	flex: 1;
}
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
.section {
	margin-bottom: 60px;
}
.section h3 {
	font-size: 1.4rem;
	font-weight: 700;
	margin-bottom: 20px;
	color: #222;
}
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

/* ====== Top10 슬라이더 ====== */
.top10-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}
.top10-header h3 {
	margin: 0;
}
.slider-controls {
	display: flex;
	gap: 15px;
	align-items: center;
}
.top10-slider-container {
	overflow: hidden;
}
.top10-slide {
	display: none;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
	width: 100%;
}
.top10-slide.active {
	display: grid;
}
.top10-slide .card {
	width: 100%;
}
.top10-slide .card img {
	height: 200px;
}
.top10-slide .card-body {
	padding: 14px;
}
.top10-slide .card-title {
	font-size: 1.05rem;
	margin-bottom: 8px;
}
.top10-slide .card-price {
	font-size: 1rem;
}
/* 화살표 버튼 */
.slider-btn {
	background: transparent;
	border: none;
	cursor: pointer;
	font-size: 1.5rem;
	color: #2573ff;
	transition: color 0.2s;
	padding: 0;
	width: 35px;
	height: 35px;
	display: flex;
	align-items: center;
	justify-content: center;
}
.slider-btn:hover {
	color: #0056d6;
}
.slider-dots {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 25px;
}
.dot {
	width: 10px;
	height: 10px;
	border-radius: 50%;
	background: #ddd;
	cursor: pointer;
	transition: all 0.3s;
}
.dot:hover {
	background: #999;
}
.dot.active {
	background: #2573ff;
	width: 24px;
	border-radius: 5px;
}

/* ====== 전체 강의 ====== */
.all-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
}
.all-grid .card img {
	height: 120px;
}

/* ====== 푸터 ====== */
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

<jsp:include page="../include/header.jsp"></jsp:include>

<main>
	<!-- ✅ 사이드 메뉴 (category_detail 기준 active 처리 포함) -->
	<aside class="sidebar">
	  <ul>
	    <li class="${param.category_detail == null || param.category_detail == '전체' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=전체" style="text-decoration:none; color:inherit;">전체</a>
	    </li>
	    <li class="${param.category_detail == '디지털드로잉' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=디지털드로잉" style="text-decoration:none; color:inherit;">디지털드로잉</a>
	    </li>
	    <li class="${param.category_detail == '드로잉' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=드로잉" style="text-decoration:none; color:inherit;">드로잉</a>
	    </li>
	    <li class="${param.category_detail == '공예' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=공예" style="text-decoration:none; color:inherit;">공예</a>
	    </li>
	    <li class="${param.category_detail == 'AI 스킬업' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=AI 스킬업" style="text-decoration:none; color:inherit;">AI 스킬업</a>
	    </li>
	    <li class="${param.category_detail == '프로그래밍' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=프로그래밍" style="text-decoration:none; color:inherit;">프로그래밍</a>
	    </li>
	    <li class="${param.category_detail == '데이터사이언스' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=데이터사이언스" style="text-decoration:none; color:inherit;">데이터사이언스</a>
	    </li>
	    <li class="${param.category_detail == '영어' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=영어" style="text-decoration:none; color:inherit;">영어</a>
	    </li>
	    <li class="${param.category_detail == '제2외국어' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=제2외국어" style="text-decoration:none; color:inherit;">제2외국어</a>
	    </li>
	    <li class="${param.category_detail == '외국어 시험' ? 'active' : ''}">
	      <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=외국어 시험" style="text-decoration:none; color:inherit;">외국어 시험</a>
	    </li>
	  </ul>
	</aside>



	<!-- ✅ 메인 콘텐츠 -->
	<section class="content">
		<div class="search-bar">
			<i class="fa-solid fa-magnifying-glass"></i>
			<input type="text" placeholder="강의를 검색해보세요">
		</div>

	<!-- 🔹 Top10 슬라이더 -->
	<div class="section">
	    <div class="top10-header">
	        <h3 id="top10-title">${param.category_detail == null ? '전체' : param.category_detail} Top 10</h3>
	        <div class="slider-controls">
	            <button class="slider-btn prev" onclick="moveSlide(-1)">
	                <i class="fa-solid fa-chevron-left"></i>
	            </button>
	            <button class="slider-btn next" onclick="moveSlide(1)">
	                <i class="fa-solid fa-chevron-right"></i>
	            </button>
	        </div>
	    </div>
	    
	    <div class="top10-slider-container">
	        <div class="top10-grid" id="top10Slider">
	            <c:forEach var="top" items="${top10List}" varStatus="status">
	                <c:if test="${status.index % 3 == 0}">
	                    <div class="top10-slide ${status.index == 0 ? 'active' : ''}">
	                </c:if>
	                
	                <a href="${pageContext.request.contextPath}/category/lecture?no=${top.lecture_num}" style="text-decoration:none;color:inherit;">
	                    <div class="card">
	                        <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${top.lecture_img}" alt="${top.lecture_title}">
	                        <div class="card-body">
	                            <div class="card-title">${top.lecture_title}</div>
	                            <div class="card-price">₩<fmt:formatNumber value="${top.lecture_price}" pattern="#,###" /></div>
	                        </div>
	                    </div>
	                </a>
	                
	                <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
	                    </div>
	                </c:if>
	            </c:forEach>
	        </div>
	    </div>
	    
	    <div class="slider-dots" id="sliderDots"></div>
	    
	    <c:if test="${empty top10List}">
	        <p>Top10 강의가 없습니다.</p>
	    </c:if>
	</div>
	
	<!-- 🔹 전체 강의 -->
	<div class="section">
	    <h3 id="all-title">${param.category_detail == null ? '전체' : param.category_detail} 전체 강의</h3>
	    <div class="all-grid">
	        <c:forEach var="lec" items="${lectureList}">
	            <a href="${pageContext.request.contextPath}/category/lecture?no=${lec.lecture_num}" style="text-decoration:none;color:inherit;">
	                <div class="card">
	                    <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lec.lecture_img}" alt="${lec.lecture_title}">
	                    <div class="card-body">
	                        <div class="card-title">${lec.lecture_title}</div>
	                        <div class="card-price">₩<fmt:formatNumber value="${lec.lecture_price}" pattern="#,###" /></div>
	                    </div>
	                </div>
	            </a>
	        </c:forEach>
	        <c:if test="${empty lectureList}">
	            <p>등록된 강의가 없습니다.</p>
	        </c:if>
	    </div>
	</div>
	</section>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
let currentSlide = 0;
const slides = document.querySelectorAll('.top10-slide');
const totalSlides = slides.length;

// 닷 생성
function createDots() {
    const dotsContainer = document.getElementById('sliderDots');
    dotsContainer.innerHTML = '';
    for (let i = 0; i < totalSlides; i++) {
        const dot = document.createElement('span');
        dot.className = 'dot' + (i === 0 ? ' active' : '');
        dot.onclick = () => goToSlide(i);
        dotsContainer.appendChild(dot);
    }
}

// 슬라이드 이동
function moveSlide(direction) {
    currentSlide += direction;
    if (currentSlide < 0) currentSlide = totalSlides - 1;
    if (currentSlide >= totalSlides) currentSlide = 0;
    showSlide(currentSlide);
}

// 특정 슬라이드로 이동
function goToSlide(index) {
    currentSlide = index;
    showSlide(currentSlide);
}

// 슬라이드 표시
function showSlide(index) {
    slides.forEach((slide, i) => {
        slide.classList.remove('active');
        if (i === index) slide.classList.add('active');
    });
    
    const dots = document.querySelectorAll('.dot');
    dots.forEach((dot, i) => {
        dot.classList.remove('active');
        if (i === index) dot.classList.add('active');
    });
}

// 초기화
if (totalSlides > 0) {
    createDots();
}
</script>

</body>
</html>