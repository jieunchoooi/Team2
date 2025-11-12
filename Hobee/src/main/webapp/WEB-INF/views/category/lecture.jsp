<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
.course-title { font-size: 1.6rem; font-weight: 700; margin-bottom: 15px; line-height: 1.4; }
.course-meta { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; color: var(--gray); font-size: 0.95rem; }
.course-meta i { color: var(--primary); }
.course-description { line-height: 1.7; color: #444; }

.curriculum-section { background: #fff; border-radius: 16px; padding: 30px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.curriculum-section h3 { font-size: 1.3rem; font-weight: 700; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
.curriculum-count { font-size: 0.95rem; color: var(--gray); font-weight: 500; }
.curriculum-item { display: flex; align-items: center; gap: 15px; padding: 18px; border: 1px solid #e0e0e0; border-radius: 12px; margin-bottom: 12px; transition: all 0.2s; cursor: pointer; }
.curriculum-item:hover { background: var(--hover-bg); border-color: var(--primary); }
.curriculum-thumbnail { width: 80px; height: 60px; border-radius: 8px; object-fit: cover; }
.curriculum-info { flex: 1; }
.curriculum-title { font-weight: 600; margin-bottom: 5px; color: #222; }
.curriculum-meta { display: flex; gap: 10px; font-size: 0.85rem; color: var(--gray); }
.play-icon { color: var(--primary); font-size: 1.2rem; }

.purchase-sidebar { 
  background: #fff; 
  border-radius: 16px; 
  box-shadow: 0 2px 12px rgba(0,0,0,0.08); 
}
.purchase-box { background: #fff; border-radius: 16px; padding: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
.instructor-info { display: flex; align-items: center; gap: 10px; margin-bottom: 18px; padding-bottom: 18px; border-bottom: 1px solid #e0e0e0; }
.instructor-avatar { width: 36px; height: 36px; border-radius: 50%; background: var(--primary); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.9rem; }
.instructor-name { font-weight: 600; color: #222; font-size: 0.95rem; }
.instructor-category { font-size: 0.8rem; color: var(--gray); }
.course-main-title { font-size: 1.15rem; font-weight: 700; line-height: 1.4; margin-bottom: 18px; }
.price-section { margin-bottom: 18px; }
.discount-rate { font-size: 1.15rem; font-weight: 700; color: var(--primary); margin-bottom: 5px; }
.original-price { font-size: 0.9rem; color: var(--gray); text-decoration: line-through; margin-bottom: 5px; }
.current-price { font-size: 1.6rem; font-weight: 700; color: #222; margin-bottom: 5px; }
.monthly-price { font-size: 0.85rem; color: var(--primary); font-weight: 600; }
.btn-purchase { width: 100%; background: var(--primary); color: #fff; border: none; padding: 14px; border-radius: 12px; font-size: 1rem; font-weight: 700; cursor: pointer; transition: all 0.2s; margin-bottom: 12px; }
.btn-purchase:hover { background: #1f65e0; transform: translateY(-2px); }
.btn-subscribe { width: 100%; background: #fff; color: var(--primary); border: 2px solid var(--primary); padding: 12px; border-radius: 12px; font-size: 0.95rem; font-weight: 600; cursor: pointer; transition: all 0.2s; margin-bottom: 18px; }
.btn-subscribe:hover { background: var(--hover-bg); }
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

footer { background: #fff; text-align: center; padding: 20px; font-size: 0.9rem; color: #777; border-radius: 20px 20px 0 0; box-shadow: 0 -2px 6px rgba(0,0,0,0.05); margin-top: 60px; }

@media (max-width: 1200px) {
  main { flex-direction: column; align-items: center; }
  .right-sidebar { width: 100%; max-width: 870px; position: relative; top: 0; }
  .lecture-grid { grid-template-columns: repeat(2, 1fr); }
}
</style>
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<main>
  <div class="detail-content">
    <div class="course-info">
      <h2 class="course-title">디지털 드로잉으로 나만의 캐릭터 만들기</h2>
      <div class="course-meta">
        <span><i class="far fa-calendar"></i> 2019년 1월 30일 수강 시작</span>
        <span><i class="far fa-clock"></i> 총 8시간 6분</span>
      </div>
      <div class="course-meta">
        <span><i class="far fa-play-circle"></i> 일반 난이도 · 영상 36개 · 챕터 파일 120개</span>
      </div>
      <div class="course-meta">
        <span><i class="fas fa-globe"></i> 한국어 음성</span>
        <span><i class="far fa-closed-captioning"></i> 한국어 · 영어 · 일본어 자막</span>
      </div>
      <p class="course-description">
        아이패드와 펜슬만 있다면 누구나 쉽게 시작할 수 있는 디지털 드로잉 입문 클래스!  
        캐릭터 디자인의 기본부터, 나만의 개성을 담은 일러스트 완성까지 함께 해요.
        디지털 드로잉은 단순한 그림 그리기를 넘어, 자신만의 창의력과 감성을 표현할 수 있는 새로운 방식의 예술입니다.
      </p>
    </div>

    <div class="tab-menu">
      <div class="tab-item active">강의 소개</div>
      <div class="tab-item">커리큘럼</div>
      <div class="tab-item">강사의 다른강의</div>
      <div class="tab-item">비슷한 강의 추천</div>
    </div>

    <!-- 커리큘럼 섹션 -->
    <div class="curriculum-section">
      <h3>
        클래스 커리큘럼
        <span class="curriculum-count">챕터 11개</span>
      </h3>

      <div class="curriculum-item">
        <img class="curriculum-thumbnail" src="https://picsum.photos/80/60?random=101" alt="커리큘럼 1" />
        <div class="curriculum-info">
          <div class="curriculum-title">Welcome<br>어색한 그림은 이제 안녕! 드로잉 기초부터 시작하는 리니의 펜드로잉 클래스에 오신 것을 환영합니다!</div>
          <div class="curriculum-meta">
            <span><i class="far fa-play-circle"></i> 미리보기</span>
            <span>02:16</span>
          </div>
        </div>
        <i class="fas fa-play-circle play-icon"></i>
      </div>

      <div class="curriculum-item">
        <img class="curriculum-thumbnail" src="https://picsum.photos/80/60?random=102" alt="커리큘럼 2" />
        <div class="curriculum-info">
          <div class="curriculum-title">1. 제대로 배우는 펜드로잉 클래스를 소개합니다.</div>
          <div class="curriculum-meta">
            <span>03:45</span>
          </div>
        </div>
        <i class="fas fa-play-circle play-icon"></i>
      </div>

      <div class="curriculum-item">
        <img class="curriculum-thumbnail" src="https://picsum.photos/80/60?random=103" alt="커리큘럼 3" />
        <div class="curriculum-info">
          <div class="curriculum-title">2. 기본 선과 색 표현 배우기</div>
          <div class="curriculum-meta">
            <span>05:20</span>
          </div>
        </div>
        <i class="fas fa-play-circle play-icon"></i>
      </div>

      <div class="curriculum-item">
        <img class="curriculum-thumbnail" src="https://picsum.photos/80/60?random=104" alt="커리큘럼 4" />
        <div class="curriculum-info">
          <div class="curriculum-title">3. 얼굴 구조와 표정 그리기</div>
          <div class="curriculum-meta">
            <span>07:15</span>
          </div>
        </div>
        <i class="fas fa-play-circle play-icon"></i>
      </div>

      <div class="curriculum-item">
        <img class="curriculum-thumbnail" src="https://picsum.photos/80/60?random=105" alt="커리큘럼 5" />
        <div class="curriculum-info">
          <div class="curriculum-title">4. 의상과 포즈 디자인</div>
          <div class="curriculum-meta">
            <span>06:30</span>
          </div>
        </div>
        <i class="fas fa-play-circle play-icon"></i>
      </div>
    </div>

    <!-- 강사의 다른 강의 -->
    <div class="instructor-section">
      <h3>강사의 다른강의</h3>
      <div class="lecture-grid">
        <% for(int i=1; i<=4; i++){ %>
        <div class="lecture-card">
          <img src="https://picsum.photos/300/200?random=<%= i+30 %>" alt="강의<%= i %>">
          <div class="lecture-info">
            <div class="lecture-title">리니의 캐릭터 드로잉 <%= i %></div>
            <div class="lecture-price">₩<%= 45000 + i*2000 %></div>
          </div>
        </div>
        <% } %>
      </div>
    </div>

    <!-- 비슷한 강의 추천 -->
    <div class="similar-section">
      <h3>비슷한 강의 추천</h3>
      <div class="lecture-grid">
        <% for(int i=1; i<=4; i++){ %>
        <div class="lecture-card">
          <img src="https://picsum.photos/300/200?random=<%= i+50 %>" alt="추천 강의<%= i %>">
          <div class="lecture-info">
            <div class="lecture-title">디지털 드로잉 입문 <%= i %></div>
            <div class="lecture-price">₩<%= 39000 + i*1500 %></div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
  </div>

  <!-- 우측 사이드바: 이미지 + 구매박스 -->
  <div class="right-sidebar">
    <img class="course-thumbnail" src="https://images.squarespace-cdn.com/content/v1/63d40fe2cbd65e16cb8098b6/7da763b6-1122-4c6f-9bfd-2c9c278dff10/image-asset%2B%2831%29.jpeg" alt="디지털 드로잉 클래스" />
    
    <aside class="purchase-sidebar">
      <div class="purchase-box">
        <div class="instructor-info">
          <div class="instructor-avatar">리니</div>
          <div><div class="instructor-name">리니</div><div class="instructor-category">🔥 드로잉 1위</div></div>
        </div>

        <h3 class="course-main-title">어색한 그림은 이제 안녕! 드로잉 기초부터 시작하는 리니의 펜드로잉</h3>

        <div class="price-section">
          <div class="discount-rate">42% ₩50,000원</div>
          <div class="current-price">월 90,000원 <span style="font-size: 0.9rem; color: #888;">5개월 할부까</span></div>
          <div class="monthly-price">월 52,140원 나의 최대 혜택가 〉</div>
        </div>

        <button class="btn-purchase">구매하기</button>
        <button class="btn-subscribe">구독으로 시작하기</button>

        <div class="class-plus-info">
          이 클래스는 부분유료 5,400개 강의를<br>
          월 22,400원에 무제한 수강해 보세요.
        </div>

        <div class="action-icons">
          <div class="action-icon"><i class="far fa-heart"></i><span>좋아요</span></div>
          <div class="action-icon"><i class="far fa-bookmark"></i><span>46513</span></div>
          <div class="action-icon"><i class="far fa-share-square"></i><span>공유</span></div>
          <div class="action-icon"><i class="fas fa-gift"></i><span>구매</span></div>
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
  const instructorSection = document.querySelector('.instructor-section');
  const similarSection = document.querySelector('.similar-section');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      // 모든 탭 active 제거
      tabs.forEach(t => t.classList.remove('active'));
      // 클릭한 탭만 active
      tab.classList.add('active');

      // 각 섹션으로 스크롤 이동
      if(tab.textContent.includes('커리큘럼')){
        curriculumSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('다른강의')){
        instructorSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('추천')){
        similarSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      } else if(tab.textContent.includes('강의 소개')){
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    });
  });
</script>

</body>
</html>