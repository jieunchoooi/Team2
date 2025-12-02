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
	font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
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

/* ====== 사이드바 스타일 ====== */
.sidebar {
	width: 220px;
	background: #fff;
	padding: 24px;
	border-radius: 16px;
	box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	height: fit-content;
}

.sidebar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding-bottom: 16px;
	border-bottom: 1px solid #f0f0f0;
}

.sidebar-header h3 {
	font-size: 1.1rem;
	font-weight: 700;
	color: #222;
}

.reset-btn {
	background: transparent;
	border: none;
	color: #666;
	font-size: 0.85rem;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 4px;
	padding: 4px 8px;
	border-radius: 4px;
	transition: all 0.2s;
}

.reset-btn:hover {
	background: #f5f5f5;
	color: #2573ff;
}

.filter-category {
	margin-bottom: 24px;
}

.filter-category-title {
	font-size: 0.9rem;
	font-weight: 600;
	color: #333;
	margin-bottom: 12px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.filter-category-title i {
	font-size: 0.85rem;
	color: #2573ff;
}

.tag-container {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.tag-btn {
	padding: 4px 11px;
	border: 1px solid #e0e0e0;
	background: #fff;
	color: #666;
	border-radius: 20px;
	font-size: 0.75rem;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
}

.tag-btn:hover {
	border-color: #2573ff;
	color: #2573ff;
	background: #f0f7ff;
}

.tag-btn.active {
	border-color: #2573ff;
	background: #2573ff;
	color: #fff;
	font-weight: 600;
}

/* 선택된 태그 카운트 */
.selected-count {
	display: inline-block;
	background: #2573ff;
	color: white;
	font-size: 0.75rem;
	padding: 2px 6px;
	border-radius: 10px;
	margin-left: 4px;
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

/* 이미지 북마크 래퍼 */
.card-img-wrapper {
	position: relative;
	display: block;
	overflow: hidden;
}

.card img {
	width: 100%;
	object-fit: cover;
}

/* 북마크 버튼 */
.bookmark-btn {
	position: absolute;
	top: 12px;
	right: 12px;
	width: 36px;
	height: 36px;
	background-color: transparent;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s ease;
	box-shadow: none;
	filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.3));
	z-index: 10;
}

.bookmark-btn i {
	font-size: 17px;
	color: #ededed;
	filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.3));
	transition: all 0.2s ease;
	font-weight: 300;
}

.bookmark-btn:hover {
	background-color: transparent;
	transform: scale(1.1);
}

.bookmark-btn:hover i {
	color: white;
	filter: drop-shadow(0 1px 3px rgba(0, 0, 0, 0.4));
}

/* 북마크 활성화 상태 */
.bookmark-btn.active i {
	color: white;
	font-weight: 900;
	filter: drop-shadow(0 1px 3px rgba(0, 0, 0, 0.4));
}

.card-body {
	padding: 14px;
}

.card-title { 
	font-size: 1rem; 
	font-weight: 600; 
	color: #222; 
	line-height: 1.4; 
	margin-bottom: 6px; 
	overflow: hidden; 
	text-overflow: ellipsis; 
	display: -webkit-box; 
	-webkit-line-clamp: 1; 
	-webkit-box-orient: vertical; 
} 

.card-instructor {
	font-size: 0.85rem;
	color: #666;
	margin-bottom: 10px;
}
.card-meta {
	display: flex;
	flex-direction: column;
	gap: 8px;
}
.card-stats {
	display: flex;
	align-items: center;
	gap: 12px;
	font-size: 0.85rem;
}
.rating {
	display: flex;
	align-items: center;
	gap: 4px;
	color: #333;
	font-weight: 600;
}
.rating i {
	color: #ffa41b;
	font-size: 0.9rem;
}
.review-count {
	color: #999;
	font-weight: 400;
}
.student-count {
	display: flex;
	align-items: center;
	gap: 4px;
	color: #666;
}
.student-count i {
	font-size: 0.85rem;
}
.card-price {
	color: #2573ff;
	font-weight: 700;
	font-size: 1rem;
	margin-top: 4px;
}

/* ====== 전체 강의 ====== */
.all-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
}
.all-grid .card img {
	height: 160px;
}
.all-grid .card-body {
	padding: 14px;
}
.all-grid .card-title {
	font-size: 0.95rem;
}
.all-grid .card-instructor {
	font-size: 0.8rem;
}
.all-grid .card-stats {
	font-size: 0.8rem;
	gap: 10px;
}
.all-grid .card-price {
	font-size: 0.95rem;
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
	<!-- ✅ 태그 필터 사이드바 -->
	<aside class="sidebar">
		<div class="sidebar-header">
			<h3>카테고리</h3>
			<button class="reset-btn" onclick="resetFilters()">
				<i class="fas fa-redo"></i> 초기화
			</button>
		</div>
		
		<!-- 크리에이티브 카테고리 -->
		<div class="filter-category">
			<div class="filter-category-title">
				ART
			</div>
			<div class="tag-container">
				<button class="tag-btn" data-tag="디지털드로잉" onclick="toggleTag(this)">디지털 드로잉</button>
				<button class="tag-btn" data-tag="드로잉" onclick="toggleTag(this)">드로잉</button>
				<button class="tag-btn" data-tag="공예" onclick="toggleTag(this)">공예</button>
			</div>
		</div>
		
		<!-- 요리 카테고리 -->
		<div class="filter-category">
			<div class="filter-category-title">
				요리
			</div>
			<div class="tag-container">
				<button class="tag-btn" data-tag="베이킹" onclick="toggleTag(this)">한식</button>
				<button class="tag-btn" data-tag="창업" onclick="toggleTag(this)">일식 & 중식 </button>
				<button class="tag-btn" data-tag="창업" onclick="toggleTag(this)">양식</button>
				<button class="tag-btn" data-tag="창업" onclick="toggleTag(this)">베이킹</button>
			</div>
		</div>
		
		<!-- 디지털 스킬 카테고리 -->
		<div class="filter-category">
			<div class="filter-category-title">
				IT
			</div>
			<div class="tag-container">
				<button class="tag-btn" data-tag="AI스킬업" onclick="toggleTag(this)">AI스킬업</button>
				<button class="tag-btn" data-tag="프로그래밍" onclick="toggleTag(this)">프로그래밍</button>
				<button class="tag-btn" data-tag="데이터사이언스" onclick="toggleTag(this)">데이터사이언스</button>
			</div>
		</div>
		
		
		<!-- IT 카테고리 -->
<!-- 		<div class="filter-category"> -->
<!-- 			<div class="filter-category-title"> -->
<!-- 				IT 개발 -->
<!-- 			</div> -->
<!-- 			<div class="tag-container"> -->
<!-- 				<button class="tag-btn" data-tag="프로그래밍" onclick="toggleTag(this)">프로그래밍</button> -->
<!-- 				<button class="tag-btn" data-tag="AI스킬업" onclick="toggleTag(this)">AI 스킬업</button> -->
<!-- 				<button class="tag-btn" data-tag="데이터사이언스" onclick="toggleTag(this)">데이터사이언스</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		<!-- 외국어 카테고리 -->
		<div class="filter-category">
			<div class="filter-category-title">
				외국어
			</div>
			<div class="tag-container">
				<button class="tag-btn" data-tag="영어" onclick="toggleTag(this)">영어</button>
				<button class="tag-btn" data-tag="제2외국어" onclick="toggleTag(this)">제2 외국어</button>
				<button class="tag-btn" data-tag="외국어시험" onclick="toggleTag(this)">외국어 시험</button>
			</div>
		</div>
	</aside>

	<!-- ✅ 메인 콘텐츠 -->
	<section class="content">
		<div class="search-bar">
			<i class="fa-solid fa-magnifying-glass"></i>
			<input type="text" id="searchInput" placeholder="원하는 강의를 검색해보세요" onkeydown="if(event.key === 'Enter'){ searchLecture(); }"/>
		</div>
		
		<!-- 🔹 전체 강의 -->
		<div class="section">
		    <h3 id="all-title">
		    	<span id="filter-title">'${sessionScope.user_name}' 님 맞춤 추천 강의</span>
		    	<span id="selected-count" class="selected-count" style="display:none;">0</span>
		    </h3>
		    <div class="all-grid" id="lectureGrid">
		        <c:forEach var="lec" items="${lectureList}">
		            <div class="card" data-category="${lec.category_detail}">
		                <a href="${pageContext.request.contextPath}/category/lecture?no=${lec.lecture_num}" class="card-img-wrapper" style="text-decoration:none;color:inherit;">
		                    <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lec.lecture_img}" alt="${lec.lecture_title}">
		                    <button class="bookmark-btn ${lec.bookmark ? 'active' : ''}" 
		                    		data-lecture-num="${lec.lecture_num}"
		                    		onclick="event.preventDefault(); toggleBookmark(${lec.lecture_num}, this);">
		                        <i class="far fa-bookmark"></i>
		                    </button>
		                </a>
		                <a href="${pageContext.request.contextPath}/category/lecture?no=${lec.lecture_num}" style="text-decoration:none;color:inherit;">
		                    <div class="card-body">
		                        <div class="card-title">${lec.lecture_title}</div>
		                        <div class="card-instructor">${lec.lecture_author}</div>
		                        <div class="card-meta">
		                            <div class="card-price">
		                                <fmt:formatNumber value="${lec.lecture_price}" type="number" />원
		                            </div>
		                            <div class="card-stats">
		                                <span class="rating">
		                                    <i class="fas fa-star"></i> ${lec.avg_score}
		                                    <span class="review-count">(${lec.review_count})</span>
		                                </span>
		                                <span class="student-count">
		                                    <i class="fas fa-user"></i> ${lec.student_count}+
		                                </span>
		                            </div>
		                        </div>
		                    </div>
		                </a>
		            </div>
		        </c:forEach>
		        <c:if test="${empty lectureList}">
		            <p>등록된 강의가 없습니다.</p>
		        </c:if>
		    </div>
		</div>
	</section>
</main>

<script>
// 선택된 태그들을 저장하는 Set
let selectedTags = new Set();

// 태그 토글 함수
function toggleTag(button) {
	const tag = button.dataset.tag;
	
	if(button.classList.contains('active')) {
		// 이미 선택된 태그 -> 제거
		button.classList.remove('active');
		selectedTags.delete(tag);
	} else {
		// 새로운 태그 선택 -> 추가
		button.classList.add('active');
		selectedTags.add(tag);
	}
	
	// 필터 적용
	applyFilter();
}

// 필터 초기화
function resetFilters() {
	// 모든 태그 버튼 비활성화
	document.querySelectorAll('.tag-btn').forEach(btn => {
		btn.classList.remove('active');
	});
	
	selectedTags.clear();
	applyFilter();
}

// 필터 적용 함수
function applyFilter() {
	const cards = document.querySelectorAll('.all-grid .card');
	const countBadge = document.getElementById('selected-count');
	const filterTitle = document.getElementById('filter-title');
	
	// 선택된 태그 개수 업데이트
	if(selectedTags.size > 0) {
		countBadge.textContent = selectedTags.size;
		countBadge.style.display = 'inline-block';
		filterTitle.textContent = '선택한 카테고리 강의';
	} else {
		countBadge.style.display = 'none';
		filterTitle.textContent = "'${sessionScope.user_name}' 님 맞춤 추천 강의";
	}
	
	// 필터링 로직
	cards.forEach(card => {
		const category = card.dataset.category;
		
		if(selectedTags.size === 0) {
			// 선택된 태그가 없으면 모두 표시
			card.style.display = 'block';
		} else {
			// 선택된 태그 중 하나라도 일치하면 표시
			if(selectedTags.has(category)) {
				card.style.display = 'block';
			} else {
				card.style.display = 'none';
			}
		}
	});
}

function searchLecture(){
	const search = document.getElementById('searchInput').value.trim();
	if(search === ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	window.location.href='${pageContext.request.contextPath}/main/search?search=' + encodeURIComponent(search);
}

//북마크 토글 로직
function toggleBookmark(lectureNum, btn) {
	
	const isLogin = "${not empty sessionScope.user_id}" === "true";
     
	if(!isLogin){
    	 openLoginModal();
        return;
     }
	
     $.ajax({
        url: '${pageContext.request.contextPath}/main/bookmark',
        method: 'POST',
        data: { lecture_num: lectureNum },
        success: function(response) {
            if(response.success) {
         	   const allButtons = document.querySelectorAll('[data-lecture-num="' + lectureNum + '"]');
         	   
         	   if(response.bookmarked){
         		   allButtons.forEach(button => {
         			   button.classList.add('active'); //북마크 ON
         		   });
         	   } else {
         		   allButtons.forEach(button =>{
         			   button.classList.remove('active'); //북마크 OFF
         		   });
         	   }
            }
         }
     });
}
</script>

<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>