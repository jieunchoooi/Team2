<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>수강생들의 리뷰</title>
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

/* * {  */
/*   margin: 0;  */
/*   padding: 0;  */
/*   box-sizing: border-box;  */
/*   font-family: 'Pretendard', sans-serif;  */
/* } */

body { 
  background: var(--bg); 
  color: var(--text-color); 
  min-height: 100vh;
/*   padding: 20px; */
}

.modal-container {
  width: 700px;
  margin: 0 auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

/* 헤더 */
.modal-header {
  padding: 30px;
  border-bottom: 1px solid #e0e0e0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #fff;
}

.review-modal-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--text-color);
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  color: var(--gray);
  cursor: pointer;
  padding: 5px 10px;
  transition: color 0.2s;
}

.btn-close:hover {
  color: var(--text-color);
}

/* 리뷰 리스트 컨테이너 */
.review-list-container {
  max-height: 70vh;
  overflow-y: auto;
  padding: 20px 30px;
}

/* 스크롤바 스타일 */
.review-list-container::-webkit-scrollbar {
  width: 8px;
}

.review-list-container::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.review-list-container::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 10px;
}

.review-list-container::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

/* 리뷰 아이템 */
.review-item {
  padding: 20px 0;
  border-bottom: 1px solid #f0f0f0;
}

.review-item:last-child {
  border-bottom: none;
}

.review-item-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.reviewer-info-modal {
  display: flex;
  align-items: center;
  gap: 10px;
}

.reviewer-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: var(--primary);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-weight: 600;
  font-size: 1rem;
}

.reviewer-details {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.reviewer-name-modal {
  font-weight: 600;
  font-size: 1rem;
  color: var(--text-color);
}

.review-date {
  font-size: 0.85rem;
  color: var(--gray);
}

.review-rating-modal {
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
  color: #e0e0e0;
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
  color: #ffc107;
}

.rating-number {
  font-weight: 700;
  font-size: 1rem;
  color: var(--text-color);
}

.review-content-modal {
  line-height: 1.7;
  color: #444;
  font-size: 0.9rem;
  margin-top: 12px;
  word-break: break-word;
}

.review-actions {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-top: 12px;
}

.review-action-btn {
  display: flex;
  align-items: center;
  gap: 5px;
  background: none;
  border: none;
  color: var(--gray);
  font-size: 0.85rem;
  cursor: pointer;
  transition: color 0.2s;
}

.review-action-btn:hover {
  color: var(--primary);
}

.review-action-btn i {
  font-size: 0.9rem;
}

/* 빈 상태 */
.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: var(--gray);
}

.empty-state i {
  font-size: 3rem;
  color: #e0e0e0;
  margin-bottom: 15px;
}

.empty-state p {
  font-size: 1rem;
  color: var(--gray);
}

/* 반응형 */
@media (max-width: 768px) {
  body {
    padding: 10px;
  }

  .modal-header {
    padding: 20px;
  }

  .review-list-container {
    padding: 15px 20px;
    max-height: 80vh;
  }

}
</style>
</head>
<body>

<div class="modal-container">
  <!-- 헤더 -->
  <div class="modal-header">
    <h2 class="review-modal-title">수강생들의 리뷰</h2>
    <button class="btn-close" onclick="window.close()">
      <i class="fas fa-times"></i>
    </button>
  </div>

  <!-- 리뷰 리스트 -->
  <div class="review-list-container">
    <c:choose>
      <c:when test="${not empty reviewList}">
        <c:forEach var="review" items="${reviewList}">
          <div class="review-item">
            <div class="review-item-header">
              <div class="reviewer-info-modal">
                <div class="reviewer-details">
                  <div class="reviewer-name-modal">${review.user_name}</div>
                </div>
              </div>
              <div class="review-rating-modal">
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
            
            <div class="review-content-modal">
              ${review.review_content}
            </div>

<!--             <div class="review-actions"> -->
<!--               <button class="review-action-btn"> -->
<!--                 <i class="far fa-thumbs-up"></i> -->
<!--                 <span>도움돼요</span> -->
<!--               </button> -->
<!--             </div> -->
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="empty-state">
          <i class="far fa-comment-dots"></i>
          <p>아직 등록된 수강평이 없습니다.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>

// ESC 키로 창 닫기
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    window.close();
  }
});

// 도움돼요 버튼 클릭
document.querySelectorAll('.review-action-btn').forEach(btn => {
  btn.addEventListener('click', function() {
    const icon = this.querySelector('i');
    if (icon.classList.contains('far')) {
      icon.classList.remove('far');
      icon.classList.add('fas');
      this.style.color = 'var(--primary)';
    } else {
      icon.classList.remove('fas');
      icon.classList.add('far');
      this.style.color = '';
    }
  });
});
</script>

</body>
</html>
