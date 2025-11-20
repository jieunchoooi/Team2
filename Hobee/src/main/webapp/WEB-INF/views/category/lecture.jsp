<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hobee 강의 상세 - 디지털 드로잉으로 나만의 캐릭터 만들기</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --text-color: #222;
  --gray: #888;
  --bg: #f9fafc;
}

* { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }

body { background: var(--bg); color: var(--text-color); display: flex; flex-direction: column; min-height: 100vh; }

main { flex: 1; display: flex; justify-content: center; padding: 40px 20px; gap: 30px; max-width: 1400px; margin: 0 auto; width: 100%; align-items: flex-start; }

.detail-content {
  flex: 1;
  max-width: 870px;
}

.right-sidebar {
  width: 330px;
  position: sticky;
  top: 40px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.course-thumbnail { 
  width: 100%;
  height: auto;
  border-radius: 16px; 
  box-shadow: 0 4px 15px rgba(0,0,0,0.08); 
}

.tab-menu {
  display: flex;
  gap: 30px;
  margin-bottom: 30px;
  position: sticky;
  top: 0;
  background: var(--bg);
  z-index: 10;
  padding-bottom: 10px;
}

.tab-item { padding: 12px 5px; font-size: 1.05rem; font-weight: 600; color: #888; cursor: pointer; border-bottom: 3px solid transparent; transition: all 0.2s; }
.tab-item.active { color: #222; border-bottom-color: #222; }
.tab-item:hover { color: #222; }

.course-info { background: #fff; border-radius: 16px; padding: 30px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.course-title { font-size: 1.6rem; font-weight: 700; margin-bottom: 25px; line-height: 1.4; }
.course-meta { display: flex; align-items: center; gap: 15px; margin-bottom: 7px; color: var(--gray); font-size: 0.95rem; }
.course-meta i { color: var(--primary); }
.course-description { line-height: 1.7; color: #444;  margin-top: 5px;}

/* 커리큘럼 섹션 - 새로운 디자인 */
.curriculum-section { background: #fff; border-radius: 16px; padding: 30px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.curriculum-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.curriculum-header h3 { font-size: 1.3rem; font-weight: 700; color: #222; }
.curriculum-count { font-size: 0.95rem; color: var(--gray); font-weight: 500; }
.expand-all-btn { color: var(--primary); font-size: 0.9rem; font-weight: 600; cursor: pointer; border: none; background: none; transition: color 0.2s; }
.expand-all-btn:hover { color: #1f65e0; }

 .chapter-item { border: 1px solid #e0e0e0; border-radius: 12px; margin-bottom: 12px; overflow: hidden; transition: all 0.2s; } 
 .chapter-item:hover { border-color: var(--primary); } 

.chapter-header { display: flex; align-items: center; gap: 15px; padding: 18px; cursor: pointer; background: #fff; transition: background 0.2s; }
.chapter-header:hover { background: var(--hover-bg); }
.chapter-header.active { background: var(--hover-bg); }

.chapter-info { flex: 1; }
.chapter-label { font-size: 0.8rem; color: var(--gray); margin-bottom: 4px; text-transform: uppercase; }
.chapter-title { font-weight: 700; font-size: 1.05rem; color: #222; line-height: 1.4; }

.chapter-meta { display: flex; align-items: center; gap: 8px; color: var(--gray); font-size: 0.85rem; }
.chapter-toggle { color: var(--gray); font-size: 1rem; transition: transform 0.3s; }
.chapter-toggle.active { transform: rotate(180deg); }

.chapter-content { max-height: 0; overflow: hidden; transition: max-height 0.3s ease; background: #fafafa; }
.chapter-content.active { max-height: 1000px; }

.lecture-item { display: flex; align-items: center; gap: 12px; padding: 12px 18px; border-top: 1px solid #e0e0e0; cursor: pointer; transition: background 0.2s; }
.lecture-item:hover { background: #f0f0f0; }
.lecture-number { font-size: 0.85rem; color: var(--gray); font-weight: 600; min-width: 30px; }
.lecture-title { flex: 1; font-size: 0.95rem; color: #333; }
.lecture-duration { font-size: 0.85rem; color: var(--gray); }
.lecture-play-icon { color: var(--primary); font-size: 1rem; }

/* 수강생 리뷰 섹션 */
.review-section { 
  background: #fff; 
  border-radius: 16px; 
  padding: 30px; 
  margin-bottom: 20px; 
  box-shadow: 0 2px 10px rgba(0,0,0,0.05); 
}

.review-header-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
}

.review-section h3 { 
  font-size: 1.3rem; 
  font-weight: 700; 
  color: #222;
  margin: 0;
}

.btn-write-review {
  background: #eef5ff;
  color: var(--primary);
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 0.95rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  gap: 6px;
}

.btn-write-review:hover {
  background: var(--primary);  /* hover 시 파란색 배경 */
  color: #fff;  /* hover 시 흰색 텍스트 */
  transform: translateY(-2px);
}


.btn-write-review i {
  font-size: 0.9rem;
}

.review-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}

.review-card {
  background: #fff;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 20px;
  transition: all 0.2s;
}

.review-card:hover {
  border-color: var(--primary);
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

.review-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.reviewer-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.reviewer-name {
  font-weight: 600;
  font-size: 1rem;
  color: #222;
}

.review-meta {
  font-size: 0.85rem;
  color: var(--gray);
}

.review-rating {
  display: flex;
  align-items: center;
  gap: 8px;
}

.stars {
  position: relative;
  display: inline-flex;
  gap: 2px;
  font-size: 0.9rem;
  line-height: 1;
}

.stars .empty {
  display: inline-flex;
  gap: 2px;
}

.stars .empty i {
  color: #e0e0e0; /* 빈 별 색상 */
}

.stars .filled {
  position: absolute;
  top: 0;
  left: 0;
  display: inline-flex;
  gap: 2px;
  overflow: hidden;
  white-space: nowrap;
  width: calc(var(--rating) * 20%);
}

.stars .filled i {
  color: #ffc107; /* 채워진 별 색상 */
}

.rating-number {
  font-weight: 700;
  font-size: 1rem;
  color: #222;
}

.recommend-badge {
  display: inline-block;
  background: #eef5ff;
  color: var(--primary);
  padding: 4px 10px;
  border-radius: 16px;
  font-size: 0.8rem;
  font-weight: 600;
  margin-top: 8px;
}

.review-content {
  line-height: 1.7;
  color: #444;
  font-size: 0.95rem;
  margin-top: 12px;
}

.purchase-sidebar { 
  background: #fff; 
  border-radius: 16px; 
  box-shadow: 0 2px 12px rgba(0,0,0,0.08); 
}
.purchase-box { background: #fff; border-radius: 16px; padding: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
.instructor-info { display: flex; align-items: center; gap: 10px; margin-bottom: 18px; padding-bottom: 18px; border-bottom: 1px solid #e0e0e0; }
.instructor-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  overflow: hidden;       /* 이미지가 영역 밖으로 나오지 않도록 */
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary); 
}

.instructor-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;      /* 이미지 비율 유지하며 꽉 채우기 */
  display: block;
}

.instructor-name { font-weight: 600; color: #222; font-size: 0.95rem; }
.instructor-category { font-size: 0.8rem; color: var(--gray); }
.course-main-title { font-size: 1.15rem; font-weight: 700; line-height: 1.4; margin-bottom: 18px; }
.price-section { margin-bottom: 18px; }
.discount-rate { font-size: 1.15rem; font-weight: 700; color: var(--primary); margin-bottom: 5px; }
.original-price { font-size: 0.9rem; color: var(--gray); text-decoration: line-through; margin-bottom: 5px; }
.current-price { font-size: 1.6rem; font-weight: 700; color: #222; margin-bottom: 5px; }

.btn-purchase { width: 100%; background: var(--primary); color: #fff; border: none; padding: 14px; border-radius: 12px; font-size: 1rem; font-weight: 700; cursor: pointer; transition: all 0.2s; margin-bottom: 12px; }
.btn-purchase:hover { background: #1f65e0; transform: translateY(-2px); }

.class-plus-info { font-size: 0.8rem; color: var(--gray); line-height: 1.6; padding-bottom: 20px;}
.action-icons { display: flex; justify-content: space-around; padding-top: 18px; border-top: 1px solid #e0e0e0; }
.action-icon { display: flex; flex-direction: column; align-items: center; gap: 4px; cursor: pointer; transition: all 0.2s; }
.action-icon i { font-size: 1.2rem; color: #555; }
.action-icon span { font-size: 0.75rem; color: var(--gray); }
.action-icon:hover i { color: var(--primary); }

/* 강사의 다른 강의 / 비슷한 강의 추천 */
.instructor-section, .similar-section { background: #fff; border-radius: 16px; padding: 30px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.instructor-section h3, .similar-section h3 { font-size: 1.3rem; font-weight: 700; margin-bottom: 25px; color: #222; }
.lecture-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
.lecture-card { background: #fff; border-radius: 14px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); transition: all 0.2s ease; cursor: pointer; }
.lecture-card:hover { transform: translateY(-4px); box-shadow: 0 6px 16px rgba(0,0,0,0.1); }
.lecture-card img { width: 100%; height: 160px; object-fit: cover; }
.lecture-info { padding: 12px 14px; }
.lecture-title { font-size: 1rem; font-weight: 600; color: #222; margin-bottom: 6px; }
.lecture-price { color: var(--primary); font-weight: 700; font-size: 0.95rem; }

.tag-badge {
  display: inline-block;
  background: #eef5ff;
  color: var(--primary);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 500;
  margin-right: 6px;
  margin-bottom: 4px;
}

.tag-badge:hover {
  background: var(--primary);
  color: #fff;
  cursor: pointer;
}

footer { background: #fff; text-align: center; padding: 20px; font-size: 0.9rem; color: #777; border-radius: 20px 20px 0 0; box-shadow: 0 -2px 6px rgba(0,0,0,0.05); margin-top: 60px; }

@media (max-width: 1200px) {
  main { flex-direction: column; align-items: center; }
  .right-sidebar { width: 100%; max-width: 870px; position: relative; top: 0; }
  .lecture-grid { grid-template-columns: repeat(2, 1fr); }
  .review-grid { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<main>
  <div class="detail-content">
    <div class="course-info">
      <div class="course-meta">
        <span> ${lectureVO.category_detail}</span>
      </div>
      <h2 class="course-title">${lectureVO.lecture_title}</h2>
      
	  <!-- 태그 표시 -->
	  <div class="course-meta">
		  <span><i class="fa-solid fa-tag"></i>&nbsp;
		    <c:forEach var="tag" items="${fn:split(lectureVO.lecture_tag, ',')}" varStatus="status">
		      <span class="tag-badge">#${tag}</span>
		    </c:forEach>
		  </span>
	  </div>
	  
      <div class="course-meta">
      	<span><i class="fa-solid fa-clipboard-user"></i> &nbsp;${lectureVO.lecture_author} &nbsp;강사</span>&nbsp;
        <span><i class="fas fa-users"></i> &nbsp;조회수 ${lectureVO.readcount}</span>
      </div>
      <p class="course-description">
        ${lectureVO.lecture_detail}
      </p>
    </div>

    <div class="tab-menu">
      <div class="tab-item active">강의 소개</div>
      <div class="tab-item">수강생 리뷰</div>
      <div class="tab-item">커리큘럼</div>
      <div class="tab-item">강사의 다른강의</div>
      <div class="tab-item">비슷한 강의 추천</div>
    </div>
    
    <!-- 수강생 리뷰 섹션 -->
    <div class="review-section">
      <div class="review-header-container">
        <h3>수강생들의 리뷰</h3>
        <c:if test="${not empty sessionScope.user_id && hasPurchased}">
	        <button class="btn-write-review" onclick="location.href='${pageContext.request.contextPath}/review/write?lecture_num=${lectureVO.lecture_num}'">
	          리뷰 작성하기
	        </button>
        </c:if>
      </div>
      <div class="review-grid">
        <c:choose>
          <c:when test="${not empty reviewList}">
            <c:forEach var="review" items="${reviewList}">
              <div class="review-card">
                <div class="review-header">
                  <div class="reviewer-info">
                    <div class="reviewer-name">${review.user_name}</div>
                    <div class="review-meta">수강평 ${review.review_count} · 평균 평점 ${review.avg_score}</div>
                  </div>
                  <div class="review-rating">
                    <span class="stars" style="--rating: ${review.review_score};">
                      <span class="empty">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                      </span>
                      <span class="filled">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                      </span>
                    </span>
                    <span class="rating-number">${review.review_score}</span>
                  </div>
                </div>              
                <p class="review-content">${review.review_content}</p>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p style="color: #888; text-align: center; width: 100%; grid-column: 1 / -1;">
              아직 등록된 수강평이 없습니다.
            </p>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- 커리큘럼 섹션 - 새로운 디자인 -->
    <div class="curriculum-section">
      <div class="curriculum-header">
        <div>
          <h3>커리큘럼 <span class="curriculum-count">챕터 ${chapterList.size()}개</span></h3>
        </div>
        <button class="expand-all-btn" onclick="toggleAllChapters()">전체 챕터 열기</button>
      </div>
      
      <!-- 커리큘럼 챕터  -->
      <c:forEach var="chapter" items="${chapterList}">
	      <div class="chapter-item">
			    <div class="chapter-header active" onclick="toggleChapter(this)">
			         <div class="chapter-info">
			        	<div class="chapter-label">CHAPTER ${chapter.chapter_order}</div>
			            <div class="chapter-title">${chapter.chapter_title}</div>
			         </div>
			         <div class="chapter-meta">
			            <span>강의 ${chapter.detailList.size()}개</span>
			            <i class="fas fa-chevron-down chapter-toggle active"></i>
			         </div>
			    </div>
		        <c:forEach var="detail" items="${chapter.detailList}">
		        	<div class="chapter-content active">
			          <div class="lecture-item">
			            <span class="lecture-number">${detail.detail_order}</span>
			            <span class="lecture-title">${detail.detail_title}</span>
			            <span class="lecture-duration">${detail.detail_time}분</span>
			          </div>
			        </div>
		        </c:forEach>
	      </div>
      </c:forEach>
    </div>

    <!-- 강사의 다른 강의 -->
	<div class="instructor-section">
	  <h3>강사의 다른강의</h3>
	  <div class="lecture-grid">
	    <c:choose>
	      <c:when test="${not empty authorLectures}">
	        <c:forEach var="lecture" items="${authorLectures}">
	          <div class="lecture-card" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}'">
	            <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}" 
	                 alt="${lecture.lecture_title}">
	            <div class="lecture-info">
	              <div class="lecture-title">${lecture.lecture_title}</div>
	              <div class="lecture-price">
	              	<fmt:formatNumber value="${lecture.lecture_price}" type="number" />원
	              </div>
	            </div>
	          </div>
	        </c:forEach>
	      </c:when>
	      <c:otherwise>
	        <p style="color: #888; text-align: center; width: 100%;">
	          해당 강사의 다른 강의가 없습니다.
	        </p>
	      </c:otherwise>
	    </c:choose>
	  </div>
	</div>
  
  	<!-- 비슷한 강의 추천 -->
    <div class="similar-section">
      <h3>비슷한 강의 추천</h3>
      <div class="lecture-grid">
       <c:choose>
       	<c:when test="${not empty similarLectures}">
       		<c:forEach var="slecture" items="${similarLectures}">
       			<div class="lecture-card" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${slecture.lecture_num}'">
       				<img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${slecture.lecture_img}"
       				     alt="${slecture.lecture_title}">
       				<div class="lecture-info">
       					<div class="lecture-title">${slecture.lecture_title}</div>
       					<div class="lecture-price">
       						<fmt:formatNumber value="${slecture.lecture_price}" type="number" />원
       					</div>
       				</div>
       			</div>
       		</c:forEach>
       	</c:when>
       	<c:otherwise>
       		<p style="color: #888; text-align: center; width: 100%;">
	          해당 강사의 다른 강의가 없습니다.
	        </p>
       	</c:otherwise>
       </c:choose>
      </div>
    </div>
  </div>

  <!-- 우측 사이드바: 이미지 + 구매박스 -->
  <div class="right-sidebar">
    <img class="course-thumbnail" src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}" alt="디지털 드로잉 클래스" />
    
    <aside class="purchase-sidebar">
      <div class="purchase-box">
        <div class="instructor-info">
          <div class="instructor-avatar">
          	<c:choose>
				<c:when test="${empty userVO.user_file}">
					<span>🐵</span>
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/resources/img/user_picture/${userVO.user_file}" alt="프로필 사진">
				</c:otherwise>
			</c:choose>
          </div>
          <div>
          	<div class="instructor-name">${lectureVO.lecture_author}</div>
<!--           	<div class="instructor-category">🔥 드로잉 1위</div> -->
          </div>
        </div>

        <h3 class="course-main-title">${lectureVO.lecture_title}</h3>

        <div class="price-section">
          <div class="discount-rate">42% ₩50,000원</div>
          <div class="current-price">
			  <fmt:formatNumber value="${lectureVO.lecture_price}" type="number" />원
		  </div>
        </div>

        <button class="btn-purchase">구매하기</button>

<!--         <div class="class-plus-info"> -->
<!--           이 클래스는 부분유료 5,400개 강의를<br> -->
<!--           월 22,400원에 무제한 수강해 보세요. -->
<!--         </div> -->

        <div class="action-icons">
          <div class="action-icon"><i class="far fa-heart"></i><span>좋아요</span></div>
          <div class="action-icon"><i class="far fa-share-square"></i><span>공유</span></div>
          <div class="action-icon"><i class="far fa-bookmark"></i><span>46513</span></div>
        </div>
      </div>
    </aside>
  </div>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
  // 탭 클릭 시 스크롤 이동
  const tabs = document.querySelectorAll('.tab-item');
  const curriculumSection = document.querySelector('.curriculum-section');
  const reviewSection = document.querySelector('.review-section');
  const instructorSection = document.querySelector('.instructor-section');
  const similarSection = document.querySelector('.similar-section');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');

      if(tab.textContent.includes('커리큘럼')){
        curriculumSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('수강생 리뷰')){
        reviewSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('다른강의')){
        instructorSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('추천')){
        similarSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('강의 소개')){
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    });
  });

  // 챕터 토글 기능
  function toggleChapter(header) {
    const chapterItem = header.parentElement; // chapter-item
    const contents = chapterItem.querySelectorAll('.chapter-content'); // 모든 lecture-item 포함
    const toggle = header.querySelector('.chapter-toggle');
    const isActive = contents[0].classList.contains('active'); // 첫 번째 content로 상태 체크

    contents.forEach(content => {
        if (isActive) {
            content.classList.remove('active');
        } else {
            content.classList.add('active');
        }
    });

	    if (isActive) {
	        toggle.classList.remove('active');
	        header.classList.remove('active');
	    } else {
	        toggle.classList.add('active');
	        header.classList.add('active');
	    }
	}

  // 전체 챕터 열기/닫기
  let allExpanded = false;
  function toggleAllChapters() {
    const btn = document.querySelector('.expand-all-btn');
    const allContents = document.querySelectorAll('.chapter-content');
    const allToggles = document.querySelectorAll('.chapter-toggle');
    const allHeaders = document.querySelectorAll('.chapter-header');

    allExpanded = !allExpanded;

    if (allExpanded) {
      btn.textContent = '전체 챕터 닫기';
      allContents.forEach(content => content.classList.add('active'));
      allToggles.forEach(toggle => toggle.classList.add('active'));
      allHeaders.forEach(header => header.classList.add('active'));
    } else {
      btn.textContent = '전체 챕터 열기';
      allContents.forEach(content => content.classList.remove('active'));
      allToggles.forEach(toggle => toggle.classList.remove('active'));
      allHeaders.forEach(header => header.classList.remove('active'));
    }
  }
</script>

</body>
</html>