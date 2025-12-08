<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 강의 구매이력 세션에서 조회 -->
<c:set var="purchasedLectures" value="${sessionScope.purchasedLectures}" />

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
   padding: 8px 0;
   cursor: pointer;
   color: #555;
   font-size: 0.95rem;
   transition: color 0.2s;
}
/* 대분류 스타일 */
.sidebar li.category-main {
   color: #222;
   font-weight: 700;
   font-size: 1rem;
   cursor: default;
}
.sidebar li.category-main:first-child {
   margin-top: 0;
}
/* 소분류 스타일 */
.sidebar li.category-sub {
   padding-left: 12px;
   font-size: 0.9rem;
}
.sidebar li:hover,
.sidebar li.active {
   color: #2573ff;
   font-weight: 600;
}
/* 대분류는 hover 효과 없음 */
.sidebar li.category-main:hover {
   color: #222;
   font-weight: 700;
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
/*강의제목 말줄임표 1줄로 제한 */
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

/*강의제목 말줄임표 2줄로 제한 */
/* .card-title { */
/*    font-size: 1rem; */
/*    font-weight: 600; */
/*    color: #222; */
/*    line-height: 1.4; */
/*    margin-bottom: 6px; */
/*    overflow: hidden; */
/*    text-overflow: ellipsis; */
/*    display: -webkit-box; */
/*    -webkit-line-clamp: 2; */
/*    -webkit-box-orient: vertical; */
/* } */

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
   padding: 16px;
}
.top10-slide .card-title {
   font-size: 1.05rem;
   margin-bottom: 6px;
}
.top10-slide .card-instructor {
   font-size: 0.9rem;
   margin-bottom: 10px;
}
.top10-slide .card-price {
   font-size: 1.1rem;
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

/* 구매한 강의 북마크 스타일 */
.bookmark-btn.purchased {
    opacity: 0.7;
}

.bookmark-btn.purchased i {
    color: white !important;  
    font-weight: 900;
}

.bookmark-btn.purchased:hover {
    background-color: transparent;
    transform: scale(1); 
}

.bookmark-btn.purchased:hover i {
    color: white !important;  
}

</style>

</head>

<body>

<jsp:include page="../include/header.jsp"></jsp:include>

<main>
   <aside class="sidebar">
     <ul>
     	<!-- 카테고리 : 전체 -->
       <li class="category-main ${param.category_detail == null || param.category_detail == '전체' ? 'active' : ''}">
         <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=전체" style="text-decoration:none; color:inherit;">전체</a>
       </li>
       
       <!-- 카테고리 -->
       <c:forEach var="mainCategory" items="${cateMainList}">
	       <li class="category-main">${mainCategory.category_main_name}</li>
	       <c:forEach var="category" items="${cateList}">
	       	   <c:if test="${category.category_main_name eq mainCategory.category_main_name}">			
			       <li class="category-sub ${param.category_detail == category.category_detail ? 'active' : ''}">
			         <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=${category.category_detail}" 
			            style="text-decoration:none; color:inherit;">${category.category_detail}
			         </a>
			       </li>
		       </c:if>
	       </c:forEach>
       </c:forEach>
     </ul>
   </aside>

   <!-- ✅ 메인 콘텐츠 -->
   <section class="content">
      <div class="search-bar">
         <i class="fa-solid fa-magnifying-glass"></i>
         <input type="text" id="searchInput" placeholder="원하는 강의를 검색해보세요" onkeydown="if(event.key === 'Enter'){ searchLecture(); }"/>
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
         
                     <!-- 0,3,6,... 3개마다 새로운 slide 열기 -->
                     <c:if test="${status.index % 3 == 0}">
                         <div class="top10-slide ${status.index == 0 ? 'active' : ''}">
                     </c:if>
         
                     <!-- 개별 카드 -->
                     <div class="card">
                         <a href="${pageContext.request.contextPath}/category/lecture?no=${top.lecture_num}" class="card-img-wrapper" style="text-decoration:none;color:inherit;">
                             <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${top.lecture_img}" alt="${top.lecture_title}">
<%--                              <button class="bookmark-btn  ${top.bookmark ? 'active' : ''}"  --%>
<%--                                    data-lecture-num="${top.lecture_num}" --%>
<%--                                    onclick="event.preventDefault(); toggleBookmark(${top.lecture_num}, this);"> --%>
<!--                                  <i class="far fa-bookmark"></i> -->
<!--                              </button> -->
                             <button class="bookmark-btn ${purchasedLectures.contains(top.lecture_num) ? 'purchased' : (top.bookmark ? 'active' : '')}"
							        data-purchased="${purchasedLectures.contains(top.lecture_num)}"
							        data-lecture-num="${top.lecture_num}"
							        onclick="event.preventDefault(); toggleBookmark(${top.lecture_num}, this);"
							        ${purchasedLectures.contains(top.lecture_num) ? 'title="이미 구매한 강의입니다"' : ''}>
							    <i class="${purchasedLectures.contains(top.lecture_num) ? 'fas fa-check-circle' : 'far fa-bookmark'}"></i>
							</button>
                         </a>
                         <a href="${pageContext.request.contextPath}/category/lecture?no=${top.lecture_num}" style="text-decoration:none;color:inherit;">
                             <div class="card-body">
                                 <div class="card-title">${top.lecture_title}</div>
                                 <div class="card-instructor">${top.lecture_author}</div>
                                 <div class="card-meta">
                                     <div class="card-price">
                                         <fmt:formatNumber value="${top.lecture_price}" type="number" />원
                                     </div>
                                     <div class="card-stats">
                                         <span class="rating">
                                             <i class="fas fa-star"></i> ${top.avg_score}
                                             <span class="review-count">(${top.review_count})</span>
                                         </span>
                                         <span class="student-count">
                                             <i class="fas fa-user"></i> ${top.student_count}+
                                         </span>
                                     </div>
                                 </div>
                             </div>
                         </a>
                     </div>
         
                     <!-- 3번째 카드마다 또는 마지막 요소에서 slide 닫기 -->
                     <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
                         </div> <!-- top10-slide 끝 -->
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
                  <div class="card">
                      <a href="${pageContext.request.contextPath}/category/lecture?no=${lec.lecture_num}" class="card-img-wrapper" style="text-decoration:none;color:inherit;">
                          <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lec.lecture_img}" alt="${lec.lecture_title}">
<%--                           <button class="bookmark-btn ${lec.bookmark ? 'active' : ''}"  --%>
<%--                                 data-lecture-num="${lec.lecture_num}" --%>
<%--                                 onclick="event.preventDefault(); toggleBookmark(${lec.lecture_num}, this);"> --%>
<!--                               <i class="far fa-bookmark"></i> -->
<!--                           </button> -->
                          <button class="bookmark-btn ${purchasedLectures.contains(lec.lecture_num) ? 'purchased' : (lec.bookmark ? 'active' : '')}"
							      data-purchased="${purchasedLectures.contains(lec.lecture_num)}"
							      data-lecture-num="${lec.lecture_num}"
							      onclick="event.preventDefault(); toggleBookmark(${lec.lecture_num}, this);"
							      ${purchasedLectures.contains(lec.lecture_num) ? 'title="이미 구매한 강의입니다"' : ''}>
							   <i class="${purchasedLectures.contains(lec.lecture_num) ? 'fas fa-check-circle' : 'far fa-bookmark'}"></i>
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

function searchLecture(){
   const search = document.getElementById('searchInput').value.trim();
   if(search === ''){
      alert("검색어를 입력해주세요.");
      return;
   }
   window.location.href='${pageContext.request.contextPath}/main/search?search=' + encodeURIComponent(search);
}


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

//북마크 토글 로직
function toggleBookmark(lectureNum, btn) {
	
	// 결제한 강의인지 확인
    if(btn.dataset.purchased === 'true') {
        alert('이미 구매한 강의입니다. 내 강의실에서 확인하세요.');
        return;
    }
   
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

// 초기화
if (totalSlides > 0) {
    createDots();
}
</script>

<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
