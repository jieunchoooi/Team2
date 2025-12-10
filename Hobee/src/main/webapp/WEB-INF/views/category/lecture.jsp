<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 강의 구매이력 세션에서 조회 -->
<c:set var="purchasedLectures" value="${sessionScope.purchasedLectures}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hobee 강의 상세 - 디지털 드로잉으로 나만의 캐릭터 만들기</title>

<!-- CSS -->
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/category/lecture.css">
<!-- 포트원 js -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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
		  <span>
		    <c:forEach var="tag" items="${fn:split(lectureVO.lecture_tag, ',')}" varStatus="status">
		      <span class="tag-badge">#${tag}</span>
		    </c:forEach>
		  </span>
	  </div>
	  
      <div class="course-meta">
      	<span><i class="fa-solid fa-clipboard-user"></i> &nbsp;${lectureVO.lecture_author} &nbsp;강사</span>&nbsp;
      </div>
      
      <!-- 평균 별점 및 리뷰 개수 추가 -->
		<div class="course-meta">
		    <span>
		        <i class="fas fa-star" style="color: #ffc107;"></i> 
		        (${lectureVO.avg_score})&nbsp; 
		        <span style="color: #888;">리뷰 ${lectureVO.review_count}개</span>
		    </span>
		    <span><i class="fas fa-users"></i> &nbsp;수강생 ${lectureVO.student_count}명</span>
		</div>
      
      <p class="course-description collapsed" id="courseDescription">
        ${lectureVO.lecture_detail}
      </p>
      <button class="description-more-btn" id="descriptionMoreBtn" style="display:none;">
		  <span class="btn-text">더보기</span>
		  <i class="fas fa-chevron-down"></i>
	  </button>
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
	    <c:if test="${not empty sessionScope.user_id && hasPurchased > 0 && !hasWrittenReview}">
		  <button class="btn-write-review" onclick="openReviewModal()">
		    리뷰 작성하기
		  </button>
		</c:if>
      </div>
      <div class="review-grid" onclick="openReviewListModal(${lectureVO.lecture_num})">
        <c:choose>
          <c:when test="${not empty reviewList}">
            <c:forEach var="review" items="${reviewList}" begin="0" end="3">
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
      
      <!-- 더보기 버튼 -->
      <c:if test="${not empty reviewList && fn:length(reviewList) > 4}">
        <div style="text-align: right;">
          <button class="btn-more-reviews" onclick="openReviewListModal(${lectureVO.lecture_num})">
            더보기
          </button>
        </div>
      </c:if>
    </div>

    <!-- 커리큘럼 섹션 -->
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
			            <span class="lecture-duration">${detail.detail_time}</span>
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
	          <div class="lecture-card">
	            <div class="lecture-img-wrapper" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}'">
	              <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}" 
	                   alt="${lecture.lecture_title}">
	              <button class="bookmark-btn ${purchasedLectures.contains(lecture.lecture_num) ? 'purchased' : (lecture.bookmark ? 'active' : '')}"
						  data-purchased="${purchasedLectures.contains(lecture.lecture_num)}"
					      data-lecture-num="${lecture.lecture_num}"
					      onclick="event.stopPropagation(); toggleBookmark(${lecture.lecture_num}, this);"
					      ${purchasedLectures.contains(lecture.lecture_num) ? 'title="이미 구매한 강의입니다"' : ''}>
						<i class="${purchasedLectures.contains(lecture.lecture_num) ? 'fas fa-check-circle' : 'far fa-bookmark'}"></i>
				 </button>
	            </div>
	            <div class="lecture-info" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}'">
	              <div class="lecture-title">${lecture.lecture_title}</div>
	              <div class="lecture-instructor">${lecture.lecture_author}</div>
	              <div class="lecture-meta">
	                <div class="lecture-price">
	                  <fmt:formatNumber value="${lecture.lecture_price}" type="number" />원
	                </div>
	                <div class="lecture-stats">
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
	        <div class="lecture-card">
	          <div class="lecture-img-wrapper" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${slecture.lecture_num}'">
	            <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${slecture.lecture_img}"
	                 alt="${slecture.lecture_title}">
	            <button class="bookmark-btn ${purchasedLectures.contains(slecture.lecture_num) ? 'purchased' : (slecture.bookmark ? 'active' : '')}"
						  data-purchased="${purchasedLectures.contains(slecture.lecture_num)}"
					      data-lecture-num="${slecture.lecture_num}"
					      onclick="event.stopPropagation(); toggleBookmark(${slecture.lecture_num}, this);"
					      ${purchasedLectures.contains(slecture.lecture_num) ? 'title="이미 구매한 강의입니다"' : ''}>
						<i class="${purchasedLectures.contains(slecture.lecture_num) ? 'fas fa-check-circle' : 'far fa-bookmark'}"></i>
				 </button>
	          </div>
	          <div class="lecture-info" onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${slecture.lecture_num}'">
	            <div class="lecture-title">${slecture.lecture_title}</div>
	            <div class="lecture-instructor">${slecture.lecture_author}</div>
	            <div class="lecture-meta">
	              <div class="lecture-price">
	                <fmt:formatNumber value="${slecture.lecture_price}" type="number" />원
	              </div>
	              <div class="lecture-stats">
	                <span class="rating">
	                  <i class="fas fa-star"></i> ${slecture.avg_score}
	                  <span class="review-count">(${slecture.review_count})</span>
	                </span>
	                <span class="student-count">
	                  <i class="fas fa-user"></i> ${slecture.student_count}+
	                </span>
	              </div>
	            </div>
	          </div>
	        </div>
	      </c:forEach>
	    </c:when>
	    <c:otherwise>
	      <p style="color: #888; text-align: center; width: 100%;">
	        비슷한 강의가 없습니다.
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
          </div>
        </div>

        <h3 class="course-main-title">${lectureVO.lecture_title}</h3>

        <div class="price-section">
          <div class="current-price">
			  <fmt:formatNumber value="${lectureVO.lecture_price}" type="number" />원
		  </div>
        </div>
        
        <!-- 강의 정보 섹션 -->
        <div class="lecture-info-section">
          <div class="info-item">
            <span class="info-label">강사</span>
            <span class="info-value">${lectureVO.lecture_author}</span>
          </div>
          <div class="info-item">
            <span class="info-label">카테고리</span>
            <span class="info-value">${lectureVO.category_detail}</span>
          </div>
          <div class="info-item">
            <span class="info-label">커리큘럼</span>
            <span class="info-value">수업 ${lectureVO.curriculum_count}개</span>
          </div>
          <div class="info-item">
            <span class="info-label">강의시간</span>
            <span class="info-value">${lectureVO.total_time}</span>
          </div>
        </div>

		<%-- ============================================
		     수강 여부에 따라 버튼 상태 변경
		     hasPurchased > 0  → 이미 수강 중
		     hasPurchased == 0 → 결제 가능
		============================================= --%>
		<c:choose>

    <%-- 1) 이미 수강 중인 경우 --%>
    <c:when test="${hasPurchased > 0}">
        <button class="btn-purchase purchased" disabled>
            수강중
        </button>
    </c:when>

    <%-- 2) 수강 중이 아님 → 로그인 여부에 따라 다시 분기 --%>
    <c:otherwise>
    
        <c:choose>
            <%-- 2-1) 비로그인 → 결제 대신 로그인 모달 오픈 --%>
            <c:when test="${empty sessionScope.userVO}">
                <button class="btn-purchase"
                        onclick="openLoginModal()">
                    로그인 후 결제하기
                </button>
            </c:when>

            <%-- 2-2) 로그인됨 → 정상 결제 모달 오픈 --%>
            <c:otherwise>
                <button class="btn-purchase"
                        onclick="openPaymentModal('${lectureVO.lecture_num}', '${lectureVO.lecture_price}')">
                    결제하기
                </button>
            </c:otherwise>
        </c:choose>

    </c:otherwise>

</c:choose>

        <div class="action-icons">
          <div class="action-icon" onclick="shareKakao()">
          	<i class="far fa-share-square"></i><span>공유</span>
          </div>
			<c:choose>
			    <%-- 구매한 강의는 북마크 비활성화 --%>
			    <c:when test="${hasPurchased > 0}">
			        <div class="action-icon purchased" 
			             title="이미 구매한 강의입니다">
			            <i class="fas fa-check-circle" style="color: gray;" onclick="alertBookmark()"></i>
			            <span id="bookmarkCount">${lectureVO.bookmark_count}</span>
			        </div>
			    </c:when>
			    
			    <%-- 미구매 강의는 북마크 가능 --%>
			    <c:otherwise>
			        <div class="action-icon ${lectureVO.bookmark ? 'active' : ''}" 
			             data-lecture-num="${lectureVO.lecture_num}"
			             onclick="toggleBookmark(${lectureVO.lecture_num}, this);">
			            <i class="far fa-bookmark"></i>
			            <span id="bookmarkCount">${lectureVO.bookmark_count}</span>
			        </div>
			    </c:otherwise>
			</c:choose>
        </div>
      </div>
    </aside>
  </div>
</main>

<!-- 리뷰 작성 모달 -->
<div id="reviewModal" style="display:none;">
  <div class="modal-box">

    <h2 class="modal-title">리뷰 작성</h2>

    <!-- ⭐ 별점 영역 - 반개 선택 가능 -->
    <div class="star-rating">
      <span class="star-wrapper" data-value="1">
        <i class="fas fa-star star"></i>
      </span>
      <span class="star-wrapper" data-value="2">
        <i class="fas fa-star star"></i>
      </span>
      <span class="star-wrapper" data-value="3">
        <i class="fas fa-star star"></i>
      </span>
      <span class="star-wrapper" data-value="4">
        <i class="fas fa-star star"></i>
      </span>
      <span class="star-wrapper" data-value="5">
        <i class="fas fa-star star"></i>
      </span>
    </div>

    <!-- 입력창 -->
    <textarea id="reviewContent" placeholder="강의는 어떠셨나요? 내용을 입력해주세요."></textarea>

    <!-- 버튼 -->
    <div class="modal-buttons">
      <button id="submitReviewBtn" class="btn-submit">작성하기</button>
      <button class="btn-cancel" onclick="closeReviewModal()">취소</button>
    </div>

  </div>
</div>

<!-- 전체리뷰리스트 모달 영역 -->
<div id="reviewModalContainer" style="display:none;"></div>


<%-- ============================================
     📌 포인트 결제 모달 (강의 가격 + 할인 + 최종 금액 포함)
=============================================== --%>


<div id="paymentPointModal" style="display:none;">
    <div class="payment-modal-box">

        <h2 class="payment-modal-title">포인트 사용</h2>

        <%-- 🔹 강의 금액 --%>
        <div class="payment-modal-row">
            <span class="payment-label">강의 금액</span>
            <span class="payment-value">
                <fmt:formatNumber value="${lectureVO.lecture_price}" /> 원
            </span>
        </div>

        <%-- 🔹 JSTL로 할인 계산 --%>
        <c:set var="discountRate"
               value="${sessionScope.gradeVO.discount_rate != null ? sessionScope.gradeVO.discount_rate : 0}" />

        <%-- 🔹 (★ 추가됨) 적립률 가져오기 --%>
        <c:set var="rewardRate"
               value="${sessionScope.gradeVO.reward_rate != null ? sessionScope.gradeVO.reward_rate : 0}" />

        <c:set var="discountAmount"
               value="${lectureVO.lecture_price * (discountRate / 100.0)}" />

        <c:set var="discountedPrice"
               value="${lectureVO.lecture_price - discountAmount}" />

        <%-- 🔹 등급 할인 표시 --%>
        <div class="payment-modal-row">
            <span class="payment-label">등급 할인 (${discountRate}% )</span>
            <span class="payment-value">
                - <fmt:formatNumber value="${discountAmount}" /> 원
            </span>
        </div>

        <%-- 🔹 할인 적용 금액 --%>
        <div class="payment-modal-row">
            <span class="payment-label">할인 적용 금액</span>
            <span class="payment-value" id="discountedPriceValue">
                <fmt:formatNumber value="${discountedPrice}" /> 원
            </span>
        </div>

        <%-- 🔹 적립 예정 포인트 계산 (버림 처리) --%>
        <c:set var="expectedSavePointsRaw"
               value="${discountedPrice * (rewardRate / 100.0)}" />

        <c:set var="expectedSavePoints"
               value="${fn:substringBefore(expectedSavePointsRaw, '.')}" />

        <div class="payment-modal-row">
            <span class="payment-label">적립 예정 (${rewardRate}% )</span>
            <span class="payment-value">
                + <fmt:formatNumber value="${expectedSavePoints}" /> P
            </span>
        </div>

        <input type="hidden" id="expectedSaveHidden" value="${expectedSavePoints}" />

        <%-- 🔹 hidden 값 (JS 연결용) --%>
        <input type="hidden" id="discountedPriceHidden" value="${discountedPrice}" />

        <%-- 🔹 세션 userVO에서 포인트 가져오기 --%>
        <div class="payment-modal-row">
            <span class="payment-label">보유 포인트</span>
            <span class="payment-value">
                <fmt:formatNumber value="${sessionScope.userVO.points}" /> P
            </span>
        </div>

        <%-- 🔹 사용할 포인트 입력 --%>
        <div class="payment-modal-row payment-input-row">
            <span class="payment-label">사용할 포인트</span>
            <input type="number" id="modalUsedPoints" placeholder="0" />
            <button class="payment-btn-use-all" onclick="detailUseAllPoints()">모두 사용</button>
        </div>

        <%-- 🔹 최종 결제 금액(포인트 적용 후) --%>
        <div class="payment-modal-row payment-row-final">
            <span class="payment-label">최종 결제 금액</span>
            <span class="payment-value" id="finalAmountPreview">
                <fmt:formatNumber value="${discountedPrice}" /> 원
            </span>
        </div>

        <%-- 🔹 버튼 영역 --%>
        <div class="payment-modal-buttons">
            <button class="payment-btn-cancel" onclick="closePaymentModal()">취소</button>
            <button class="payment-btn-confirm" onclick="confirmPayment()">결제하기</button>
        </div>

    </div>
</div>



<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
const isLogin = ${sessionScope.userVO == null ? false : true};
  function alertBookmark(){
	  alert("이미 구매한 강의입니다. 내 강의실에서 확인하세요.");
  }

  //카카오톡 공유하기
  Kakao.init('7f21ec1e9b0371f46cf7190c8d91f522');
	
  function shareKakao() {
	  
     // 강의 정보 동적으로 가져오기
	 const lectureTitle = "${lectureVO.lecture_title}";
	 const lectureDetail = `${fn:substring(lectureVO.lecture_detail, 0, 100)}...`.replace(/["']/g, "");
	 const lectureImg = "${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}";  
	 
	 Kakao.Share.sendDefault({
	    objectType: 'feed',
	    content: {
	      title: lectureTitle,
	      description: lectureDetail,
	      imageUrl: lectureImg,
	      link: {
	        mobileWebUrl: window.location.href,
	        webUrl: window.location.href
	     }
	   }
	});
  }

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
    const chapterItem = header.parentElement;
    const contents = chapterItem.querySelectorAll('.chapter-content');
    const toggle = header.querySelector('.chapter-toggle');
    const isActive = contents[0].classList.contains('active');

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
  
  //북마크 토글 함수
  function toggleBookmark(lectureNum, btn) {
	  
		// 결제한 강의인지 확인
	    if(btn.dataset.purchased === 'true') {
	        alert('이미 구매한 강의입니다. 내 강의실에서 확인하세요.');
	        return;
	    }
		
// 		const isLogin = "${not empty sessionScope.user_id}" === "true";
	     
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
	        	   const bookmarkCountSpan = document.getElementById('bookmarkCount');
	        	   
	        	   if(response.bookmarked){
	        		   allButtons.forEach(button => {
	        			   button.classList.add('active'); //북마크 ON
	        		   });
	        		   //북마크 카운트 +1
	        		   if(bookmarkCountSpan){
	        			   bookmarkCountSpan.textContent = parseInt(bookmarkCountSpan.textContent) + 1;
	        		   }
	        	   } else {
	        		   allButtons.forEach(button =>{
	        			   button.classList.remove('active'); //북마크 OFF
	        		   });
	        		   //북마크 카운트 -1
	        		   if(bookmarkCountSpan){
	        			   bookmarkCountSpan.textContent = parseInt(bookmarkCountSpan.textContent) - 1;
	        		   }
	        	   }
	           }
	        }
	     });
  }
  
  // ⭐ 별점 선택 변수
  let selectedStar = 0;

  // ⭐ 리뷰 작성 모달 열기/닫기 - 수정된 버전
  function openReviewModal() {
      document.body.classList.add('modal-open');
      document.getElementById('reviewModal').style.display = 'flex';
      selectedStar = 0;
      updateStars(0);
  }

  function closeReviewModal() {
      document.body.classList.remove('modal-open');
      document.getElementById('reviewModal').style.display = 'none';
      document.getElementById('reviewContent').value = '';
      selectedStar = 0;
      updateStars(0);
  }

  // 별 업데이트 함수
  function updateStars(rating) {
    const starWrappers = document.querySelectorAll('#reviewModal .star-wrapper');
    
    starWrappers.forEach((wrapper, index) => {
      const star = wrapper.querySelector('.star');
      const starValue = index + 1;
      
      star.classList.remove('full', 'half');
      
      if (rating >= starValue) {
        star.classList.add('full');
      } else if (rating > starValue - 1 && rating < starValue) {
        star.classList.add('half');
      }
    });
  }

  // 별 클릭 이벤트
  document.querySelectorAll('#reviewModal .star-wrapper').forEach(wrapper => {
    wrapper.addEventListener('click', function(e) {
      const starValue = parseInt(this.getAttribute('data-value'));
      const rect = this.getBoundingClientRect();
      const clickX = e.clientX - rect.left;
      const starWidth = rect.width;
      
      if (clickX < starWidth / 2) {
        selectedStar = starValue - 0.5;
      } else {
        selectedStar = starValue;
      }
      
      updateStars(selectedStar);
    });
  });

  // 모달 배경 클릭 시 닫기
  document.addEventListener('click', function(e) {
      if (e.target.id === 'reviewModal') {
          closeReviewModal();
      }
      if (e.target.id === 'reviewModalContainer') {
          closeReviewListModal();
      }
  });

  // ESC 키로 모달 닫기
  document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
          if (document.getElementById('reviewModal').style.display === 'flex') {
              closeReviewModal();
          }
          if (document.getElementById('reviewModalContainer').style.display === 'flex') {
              closeReviewListModal();
          }
      }
  });

  /* 리뷰 제출 */
  document.getElementById('submitReviewBtn').addEventListener('click', function() {
    if (selectedStar === 0) {
      alert("별점을 선택해주세요.");
      return;
    }

    if (document.getElementById('reviewContent').value.trim() === "") {
      alert("리뷰 내용을 입력해주세요.");
      return;
    }
    
    let lectureNum = ${lectureVO.lecture_num};

    if (typeof $ !== 'undefined') {
      $.ajax({
        url: "${pageContext.request.contextPath}/category/insertReview",
        type: "POST",
        data: {
          lecture_num: lectureNum,
          review_score: selectedStar,
          review_content: $("#reviewContent").val()
        },
        success: function(result) {
          alert("리뷰가 등록되었습니다.");
          closeReviewModal();
          location.reload();
        },
        error: function() {
          alert("리뷰 등록 중 오류가 발생했습니다.");
        }
      });
    } 
  });

  // 전체 리뷰 리스트 모달 열기 - 수정된 버전
  function openReviewListModal(lectureNum) {
      $.ajax({
          url: '${pageContext.request.contextPath}/category/reviewList',
          type: 'GET',
          data: { no: lectureNum },
          success: function(data) {
              document.body.classList.add('modal-open');
              $('#reviewModalContainer')
                  .html(data)
                  .css('display', 'flex')
                  .hide()
                  .fadeIn();
          },
          error: function() {
              alert('리뷰를 불러오는 데 실패했습니다.');
          }
      });
  }

  // 전체 리뷰 모달 닫기 - 수정된 버전
  function closeReviewListModal() {
      $('#reviewModalContainer').fadeOut(function() {
          $(this).html('');
          document.body.classList.remove('modal-open');
      });
  }

  // jQuery 닫기 버튼
  $(document).on('click', '.btn-close', function() {
      closeReviewListModal();
  });
  
  //강의 상세설명 더보기 
  document.addEventListener('DOMContentLoaded', function() {	
    const description = document.querySelector('.course-description');
    const moreBtn = document.getElementById('descriptionMoreBtn');
    
    if (!description || !moreBtn) return;
    
    // 실제 컨텐츠 높이 체크
    function checkDescriptionHeight() {
      // 원래 스타일 저장
      const originalMaxHeight = description.style.maxHeight;
      const originalDisplay = description.style.display;
      
      // collapsed 클래스 제거하고 실제 높이 측정
      description.classList.remove('collapsed');
      description.style.maxHeight = 'none';
      description.style.display = 'block';
      
      const fullHeight = description.scrollHeight;
      
      // collapsed 클래스 다시 추가
      description.classList.add('collapsed');
      description.style.maxHeight = originalMaxHeight;
      description.style.display = originalDisplay;
      
      // 2줄 높이 계산 (line-height 1.7 × 2 = 3.4em ≈ 51px 정도)
      const twoLineHeight = parseFloat(getComputedStyle(description).lineHeight) * 2;
      
      console.log('전체 높이:', fullHeight, '2줄 높이:', twoLineHeight);
      
      // 2줄 높이를 초과하면 더보기 버튼 표시
      if (fullHeight > twoLineHeight + 5) { // 여유값 5px 추가
        moreBtn.style.display = 'inline-block';
        console.log('더보기 버튼 표시!');
      } else {
        moreBtn.style.display = 'none';
        console.log('더보기 버튼 숨김');
      }
    }
    
    // 더보기/접기 토글
    let isExpanded = false;
    moreBtn.addEventListener('click', function() {
      isExpanded = !isExpanded;
      
      if (isExpanded) {
        description.classList.remove('collapsed');
        moreBtn.querySelector('.btn-text').textContent = '접기';
        moreBtn.querySelector('i').style.transform = 'rotate(180deg)';
      } else {
        description.classList.add('collapsed');
        moreBtn.querySelector('.btn-text').textContent = '더보기';
        moreBtn.querySelector('i').style.transform = 'rotate(0deg)';
      }
    });
    
    // 폰트 로드 후 체크 (중요!)
    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(function() {
        setTimeout(checkDescriptionHeight, 100);
      });
    } else {
      // 폴백: window.load 이벤트 사용
      window.addEventListener('load', function() {
        setTimeout(checkDescriptionHeight, 100);
      });
    }
    
    // 윈도우 리사이즈 시 재체크
    window.addEventListener('resize', checkDescriptionHeight);
  });
  
//결제 쪽 js ---------------------------------------------------------------------------------------------  
  
  /* ======================================================
  ⬛ PortOne 초기화
====================================================== */
const IMP = window.IMP;
IMP.init("imp77215860");

/* ======================================================
  ⬛ 회원 등급 할인 / 적립률 (세션에서 가져오기)
====================================================== */
const discountRate = ${sessionScope.gradeVO != null ? sessionScope.gradeVO.discount_rate : 0};
const rewardRate   = ${sessionScope.gradeVO != null ? sessionScope.gradeVO.reward_rate : 0};

/* ======================================================
⬛ 결제용 전역 변수 (중복 제거)
====================================================== */
let selectedLectureNum = null;
let selectedLectureOriginalPrice = 0;    // 원가
let selectedLectureDiscountedPrice = 0;  // 등급 할인 적용 가격
//세션 포인트 안전 처리
const myPoints = ${sessionScope.userVO != null ? sessionScope.userVO.points : 0};

// DOM 요소 안전 핸들러
const modalUsedPointsEl = document.getElementById("modalUsedPoints");
const finalAmountPreviewEl = document.getElementById("finalAmountPreview");

/* ======================================================
⬛ 결제 모달 열기
====================================================== */

function openPaymentModal(lectureNum, price) {

    // 로그인 체크 (boolean)
    if (!isLogin) {
        if (typeof openLoginModal === "function") {
            openLoginModal();
        } else {
            alert("로그인이 필요한 서비스입니다.");
        }
        return;
    }

    // ----------------------------
    // 🔽 로그인된 경우만 실행됨
    // ----------------------------

    selectedLectureNum = Number(lectureNum) || 0;
    selectedLectureOriginalPrice = Number(price) || 0;

    // 🔥 할인 금액 계산 (널 안전)
    const discount = Math.floor(selectedLectureOriginalPrice * (discountRate / 100));
    selectedLectureDiscountedPrice = selectedLectureOriginalPrice - discount;

    // ---------------------------------------
    // 🔥 modalUsedPoints element Null-Safe 체크
    // ---------------------------------------
    const usedPointInput = document.getElementById("modalUsedPoints");
    if (usedPointInput) {
        usedPointInput.value = 0;
    }

    // ---------------------------------------
    // 🔥 최종 금액 preview Null-Safe 체크
    // ---------------------------------------
    const preview = document.getElementById("finalAmountPreview");
    if (preview) {
        preview.innerText = selectedLectureDiscountedPrice.toLocaleString() + "원";
    }

    // ---------------------------------------
    // 🔥 결제 모달 띄우기 Null-Safe
    // ---------------------------------------
    const modal = document.getElementById("paymentPointModal");
    if (modal) {
        document.body.classList.add("modal-open");
        modal.style.display = "flex";
    }
}


/* ======================================================
⬛ 결제 모달 닫기
====================================================== */
function closePaymentModal() {
    document.body.classList.remove("modal-open");
    document.getElementById("paymentPointModal").style.display = "none";
}


/* ======================================================
⬛ 포인트 입력 이벤트
====================================================== */
if (modalUsedPointsEl) {
    modalUsedPointsEl.addEventListener("input", function () {

        if (!isLogin) return;

        let used = parseInt(this.value) || 0;

        // 유효성 검사
        if (used < 0) used = 0;
        if (used > myPoints) used = myPoints;
        if (used > selectedLectureDiscountedPrice)
            used = selectedLectureDiscountedPrice;

        this.value = used;

        // 최종 금액 계산 (DOM Null-safe)
        const finalAmount = selectedLectureDiscountedPrice - used;

        if (finalAmountPreviewEl) {
            finalAmountPreviewEl.innerText = finalAmount.toLocaleString() + "원";
        }
    });
}


/* ======================================================
⬛ 모두 사용 버튼
====================================================== */
function detailUseAllPoints() {
    if (!isLogin) return;

    const use = Math.min(myPoints, selectedLectureDiscountedPrice);

    if (modalUsedPointsEl) {
        modalUsedPointsEl.value = use;
    }

    const finalAmount = selectedLectureDiscountedPrice - use;

    if (finalAmountPreviewEl) {
        finalAmountPreviewEl.innerText = finalAmount.toLocaleString() + "원";
    }
}


/* ======================================================
⬛ 결제 진행 (confirmPayment)
====================================================== */
function confirmPayment() {
    if (!isLogin) return;

    let usedPoints = 0;

    if (modalUsedPointsEl) {
        usedPoints = parseInt(modalUsedPointsEl.value) || 0;
    }

    // 유효성 검사
    if (usedPoints < 0) usedPoints = 0;
    if (usedPoints > myPoints) usedPoints = myPoints;
    if (usedPoints > selectedLectureDiscountedPrice)
        usedPoints = selectedLectureDiscountedPrice;

    closePaymentModal();

    requestPayment(selectedLectureNum, selectedLectureOriginalPrice, usedPoints);
}


/* ======================================================
⬛ 최종 결제 실행
====================================================== */
function requestPayment(lectureNum, originalPrice, usedPoints) {
    if (!isLogin) return;

    // 1) 할인 적용
    const discount = Math.floor(originalPrice * (discountRate / 100));
    const discountedPrice = originalPrice - discount;

    // 2) 포인트 적용
    let finalAmount = discountedPrice - usedPoints;
    if (finalAmount < 0) finalAmount = 0;

    // 3) 적립 포인트
    const savedPoints = Math.floor(finalAmount * (rewardRate / 100));

    // 4) 세션 사용자 정보 (Null-safe)
    const userName  = "<c:out value='${sessionScope.userVO != null ? sessionScope.userVO.user_name : ""}'/>";
    const userEmail = "<c:out value='${sessionScope.userVO != null ? sessionScope.userVO.user_email : ""}'/>";
    const userPhone = "<c:out value='${sessionScope.userVO != null ? sessionScope.userVO.user_phone : ""}'/>";
    const userNum   = "<c:out value='${sessionScope.userVO != null ? sessionScope.userVO.user_num : ""}'/>";

    if (!userNum) {
        alert("로그인이 필요한 서비스입니다.");
        return;
    }

    // 5) 포트원 결제창
    IMP.request_pay({
        pg: "kakaopay.TC0ONETIME",
        pay_method: "kakaopay",
        merchant_uid: "M" + new Date().getTime(),
        name: "Hobee 강의 결제",
        amount: finalAmount,
        buyer_email: userEmail,
        buyer_name: userName,
        buyer_tel: userPhone
    }, function (rsp) {
        
        if (!rsp.success) {
            alert("❌ 결제 실패: " + rsp.error_msg);
            return;
        }

        // 6) 서버로 검증 요청
        $.post(
            "${pageContext.request.contextPath}/payment/verify",
            { imp_uid: rsp.imp_uid },
            function (verifyResult) {

                if (verifyResult.verify_result !== "success") {
                    alert("❌ 결제 검증 실패: " + verifyResult.message);
                    return;
                }

                // 7) 결제 완료 저장
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/payment/complete",
                    traditional: true,
                    data: {
                        user_num: userNum,
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        amount: finalAmount,
                        used_points: usedPoints,
                        saved_points: savedPoints,
                        lectureNums: [lectureNum],
                        "grade.discount_rate": discountRate,
                        "grade.reward_rate": rewardRate
                    },

                    success: function (completeResult) {
                        if (completeResult.status === "success") {
                            if (completeResult.gradeChanged && completeResult.gradeMessage) {
                                alert("\n" + completeResult.gradeMessage);
                            }
                            location.href = "${pageContext.request.contextPath}/payment/success";
                        }

                        else if (completeResult.status === "duplicate") {
                            alert("이미 처리된 결제입니다.\n" + completeResult.message);
                            location.href = "${pageContext.request.contextPath}/payment/success";
                        }

                        else {
                            alert("❌ 결제 저장 실패: " + completeResult.message);
                        }
                    },

                    error: function () {
                        alert("❌ 서버 통신 오류 (complete 단계)");
                    }
                });
            }
        );
    });
}


</script>

<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
