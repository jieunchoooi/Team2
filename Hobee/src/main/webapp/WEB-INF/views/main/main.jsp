<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>취미 온라인 클래스 - HobbyPrep</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 메인 히어로 섹션 -->
	<main class="main-hero">
		<div class="hero-text">
			<h2>당신의 취미, 더 깊게 즐기세요 🎨</h2>
		</div>
		<form class="search-form" onsubmit="searchLecture(event)">
			<input type="text" id="searchInput" placeholder="원하는 강의를 검색해보세요" />
			<button type="submit" class="btn">검색</button>
		</form>
	</main>
	
	<!-- 카테고리 메뉴 -->
<section class="inflearn-category">
    <div class="category-list">

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=전체" class="category-item active">
            <i class="fa-solid fa-layer-group"></i>
            <span>전체</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=디지털드로잉" class="category-item">
            <i class="fa-solid fa-palette"></i>
            <span>디지털드로잉</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=드로잉" class="category-item">
            <i class="fa-solid fa-paintbrush"></i>
            <span>드로잉</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=공예" class="category-item">
            <i class="fa-solid fa-brush"></i>
            <span>공예</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=AI" class="category-item">
            <i class="fa-solid fa-gamepad"></i>
            <span>AI스킬업</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=프로그래밍" class="category-item">
            <i class="fa-solid fa-code"></i>
            <span>프로그래밍</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=데이터사이언스" class="category-item">
            <i class="fa-solid fa-database"></i>
            <span>데이터사이언스</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=영어" class="category-item">
            <i class="fa-solid fa-language"></i>
            <span>영어</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=제2외국어" class="category-item">
            <i class="fa-solid fa-chart-line"></i>
            <span>제2외국어</span>
        </a>

        <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=외국어" class="category-item">
            <i class="fa-solid fa-graduation-cap"></i>
            <span>외국어시험</span>
        </a>

    </div>
</section>
	
	
	
	<!-- 인기 강의 섹션 -->
	<section class="course-section">
		<h3>인기 강의 🔥</h3>
		<div class="course-grid">
			<c:choose>
				<c:when test="${not empty bestList}">
					<c:forEach var="lecture" items="${bestList}" varStatus="status">
						<c:if test="${status.index < 8}">
							<div class="course-card">
								<a
									href="${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}">
									<img
									src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}"
									class="course-thumb" alt="${lecture.lecture_title}">
								</a>
								<div class="course-info">
									<div class="course-title">${lecture.lecture_title}</div>
									<div class="course-price">
										<fmt:formatNumber value="${lecture.lecture_price}" type="number" />원
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>인기강의가 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
	</section>
	<!-- 할인 강의 섹션 -->
	<section class="course-section">
		<h3>할인 중인 강의 💸</h3>
		<div class="course-grid">
			<div class="course-card">
				<a href="${pageContext.request.contextPath}/category/lecture"> <img
					src="https://picsum.photos/400/250?random=5" class="course-thumb"
					alt="강의5">
				</a>
				<div class="course-info">
					<div class="course-title">캘리그라피 디자인</div>
					<div class="course-price">
						<del>₩60,000</del>
						₩42,000
					</div>
				</div>
			</div>
			<div class="course-card">
				<a href="${pageContext.request.contextPath}/category/lecture"> <img
					src="https://picsum.photos/400/250?random=6" class="course-thumb"
					alt="강의6">
				</a>
				<div class="course-info">
					<div class="course-title">웹 퍼블리싱 완성반</div>
					<div class="course-price">
						<del>₩80,000</del>
						₩56,000
					</div>
				</div>
			</div>
			<div class="course-card">
				<a href="${pageContext.request.contextPath}/category/lecture"> <img
					src="https://picsum.photos/400/250?random=7" class="course-thumb"
					alt="강의7">
				</a>
				<div class="course-info">
					<div class="course-title">기초 일본어 회화</div>
					<div class="course-price">
						<del>₩65,000</del>
						₩45,000
					</div>
				</div>
			</div>
			<div class="course-card">
				<a href="${pageContext.request.contextPath}/category/lecture"> <img
					src="https://picsum.photos/400/250?random=8" class="course-thumb"
					alt="강의8">
				</a>
				<div class="course-info">
					<div class="course-title">도예 취미 클래스</div>
					<div class="course-price">
						<del>₩70,000</del>
						₩49,000
					</div>
				</div>
			</div>
		</div>
	</section>
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