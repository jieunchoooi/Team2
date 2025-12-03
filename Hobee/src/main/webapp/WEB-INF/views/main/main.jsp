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
   <section class="hobee-category">
       <div class="category-list">
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=전체" class="category-item active">
               <i class="fa-solid fa-layer-group"></i>
               <span>전체</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=디지털드로잉" class="category-item">
               <i class="fa-solid fa-pen-to-square"></i>
               <span>디지털드로잉</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=드로잉" class="category-item">
               <i class="fa-solid fa-paintbrush"></i>
               <span>드로잉</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=공예" class="category-item">
               <i class="fa-solid fa-hammer"></i>
               <span>공예</span>
           </a>
           
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=한식" class="category-item">
               <i class="fa-solid fa-utensils"></i>
               <span>요리</span>
           </a>
           
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=뷰티" class="category-item">
               <i class="fa-solid fa-brush"></i>
               <span>뷰티</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=타로·사주" class="category-item">
               <i class="fa-solid fa-hat-wizard"></i>
               <span>타로·사주</span>
           </a>
           
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=게임" class="category-item">
               <i class="fa-solid fa-gamepad"></i>
               <span>게임</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=AI스킬업" class="category-item">
               <i class="fa-solid fa-robot"></i>
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
               <i class="fa-solid fa-earth-americas"></i>
               <span>제2외국어</span>
           </a>
   
           <a href="${pageContext.request.contextPath}/category/lectureList?category_detail=외국어시험" class="category-item">
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
                        <a href="${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}" class="course-thumb-wrapper">
                           <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}"
                              class="course-thumb" alt="${lecture.lecture_title}">
                           <button class="bookmark-btn ${lecture.bookmark ? 'active' : ''}" 
                           		   data-lecture-num="${lecture.lecture_num}"
                           		   onclick="event.preventDefault(); toggleBookmark(${lecture.lecture_num}, this);">
                                <i class="far fa-bookmark"></i>
                            </button>
                        </a>
                        <div class="course-info">
                           <div class="course-title">${lecture.lecture_title}</div>
                           <div class="course-instructor">${lecture.lecture_author}</div>
                           <div class="course-meta">
                              <div class="course-price">
                                 <fmt:formatNumber value="${lecture.lecture_price}" type="number" />원
                              </div>
                              <div class="course-stats">
                                 <span class="rating">
                                    <i class="fas fa-star"></i> ${lecture.avg_score}
                                    <span class="review-count">(${lecture.review_count})</span>
                                 </span>
                                 <span class="student-count">
                                    <i class="fas fa-user"></i> ${lecture.student_count}+
                                 </span>
                              </div>
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
   
   <!-- 전체 강의 섹션 -->
   <section class="course-section">
      <h3>전체 강의</h3>
      <div class="course-grid">
         <c:forEach var="lecture" items="${lectureList}" varStatus="status">
            <div class="course-card">
               <a
                  href="${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}"
                  class="course-thumb-wrapper"> <img
                  src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}"
                  class="course-thumb" alt="${lecture.lecture_title}">
                  <button class="bookmark-btn ${lecture.bookmark ? 'active' : ''}"
                  		  data-lecture-num="${lecture.lecture_num}"
                     	  onclick="event.preventDefault(); toggleBookmark(${lecture.lecture_num}, this);">
                     <i class="far fa-bookmark"></i>
                  </button>
               </a>
               <div class="course-info">
                  <div class="course-title">${lecture.lecture_title}</div>
                  <div class="course-instructor">${lecture.lecture_author}</div>
                  <div class="course-meta">
                     <div class="course-price">
                        <fmt:formatNumber value="${lecture.lecture_price}" type="number" />
                        원
                     </div>
                     <div class="course-stats">
                        <span class="rating"> <i class="fas fa-star"></i>
                           ${lecture.avg_score} <span class="review-count">(${lecture.review_count})</span>
                        </span> <span class="student-count"> <i class="fas fa-user"></i>
                           ${lecture.student_count}+
                        </span>
                     </div>
                  </div>
               </div>
            </div>
         </c:forEach>
         <c:if test="${empty lectureList}">
            <p>전체강의가 없습니다.</p>
         </c:if>
      </div>
   </section>
   
<script>

function searchLecture(event) {
     event.preventDefault();
     const search = document.getElementById('searchInput').value.trim();
     if (!search) {
        alert('검색어를 입력해주세요.');
        return;
     }
     window.location.href = '${pageContext.request.contextPath}/main/search?search=' + encodeURIComponent(search);
}
   
// 북마크 토글 로직
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