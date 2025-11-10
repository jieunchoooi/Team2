<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root {
  --primary: #2963f6;
  --border: #e6e9f0;
  --bg: #f8faff;
  --text-gray: #555;
  --card-hover: rgba(41, 99, 246, 0.05);
}

body {
  font-family: 'Pretendard', sans-serif;
  background-color: var(--bg);
  color: #222;
  margin: 0;
  padding: 0;
}

main {
  max-width: 1100px;
  margin: 50px auto;
  padding: 0 20px 60px;
}

/* ✅ 2단 레이아웃 */
.layout {
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 30px;
  align-items: start;
}

/* ✅ 검색창 */
.search-bar {
  position: relative;
  display: flex;
  align-items: center;
  width: 100%;
  margin-bottom: 25px;
}

.search-bar i {
  position: absolute;
  left: 15px;
  color: #888;
  font-size: 1rem;
  color: #2963f6;
}

.search-bar input {
  width: 100%;
  padding: 10px 14px 10px 40px; /* 왼쪽에 아이콘 자리 확보 */
  border: 1px solid var(--border);
  border-radius: 22px;
  font-size: 0.9rem;
  outline: none;
  transition: border-color 0.2s;
  background-color: #fff;
  box-sizing: border-box;
}
.search-bar input:focus {
  border-color: var(--primary);
}


/* 추천 카드 */
.recommend-section {
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 22px 25px;
  margin-bottom: 30px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.04);
}
.recommend-section h2 {
  font-size: 1.1rem;
  font-weight: 700;
  margin-bottom: 14px;
  color: #222;
}
.recommend-cards {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
}
.recommend-card {
  flex: 1;
  min-width: 250px;
  background: var(--bg);
  border-radius: 12px;
  padding: 14px 16px;
  border: 1px solid var(--border);
  transition: all 0.2s ease;
  cursor: pointer;
}
.recommend-card:hover {
  background: var(--card-hover);
  border-color: var(--primary);
  transform: translateY(-2px);
}
.recommend-card .title {
  font-weight: 600;
  margin-bottom: 6px;
  color: #222;
}
.recommend-card .meta {
  font-size: 0.85rem;
  color: #888;
}

/* ✅ 카테고리 + 글쓰기 버튼 */
.category-topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
}

/* 카테고리 탭 */
.category-tabs {
  display: flex;
  gap: 10px;
}
.category-tab {
  border: 1px solid var(--border);
  background: #fff;
  border-radius: 22px;
  padding: 7px 18px;
  font-size: 0.9rem;
  cursor: pointer;
  color: var(--text-gray);
  transition: all 0.2s ease;
}
.category-tab:hover {
  color: var(--primary);
  border-color: var(--primary);
}
.category-tab.active {
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  border-color: var(--primary);
}

/* 글쓰기 버튼 */
.write-btn {
  background: var(--primary);
  color: #fff;
  border-radius: 25px;
  padding: 8px 20px;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  box-shadow: 0 2px 4px rgba(41, 99, 246, 0.2);
  transition: 0.2s;
}
.write-btn:hover {
  background: #1e53d8;
}

/* 게시글 리스트 */
.board-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.card {
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 12px;
  padding: 12px 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  transition: all 0.2s ease;
  cursor: pointer;
}
.card:hover {
  background: var(--card-hover);
  transform: translateY(-2px);
}
.card .title {
  font-size: 0.95rem;
  font-weight: 600;
  color: #222;
  margin-bottom: 4px;
}
.card .author {
  font-size: 0.85rem;
  color: var(--text-gray);
  margin-bottom: 3px;
}
.card .meta {
  font-size: 0.75rem;
  color: #999;
  display: flex;
  gap: 10px;
}
.no-data {
  background: #fff;
  border: 1px dashed var(--border);
  border-radius: 12px;
  padding: 40px;
  text-align: center;
  color: #999;
  font-size: 0.95rem;
}

/* ✅ 페이지네이션 */
.pagination {
  display: flex;
  justify-content: center;
  margin-top: 25px;
  gap: 6px;
}
.pagination a {
  border: 1px solid var(--border);
  background: #fff;
  color: var(--text-gray);
  border-radius: 6px;
  padding: 6px 10px;
  font-size: 0.85rem;
  text-decoration: none;
  transition: all 0.2s;
}
.pagination a:hover {
  border-color: var(--primary);
  color: var(--primary);
}
.pagination a.active {
  background: var(--primary);
  color: #fff;
  border-color: var(--primary);
  font-weight: 600;
}

/* ✅ 인기글 사이드바 */
.popular-section {
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 20px 18px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.04);
  position: sticky;
  top: 100px;
}
.popular-section h3 {
  font-size: 1rem;
  font-weight: 700;
  margin-bottom: 14px;
  color: #222;
}
.popular-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.popular-item {
  display: flex;
  gap: 10px;
  align-items: center;
  font-size: 0.9rem;
  padding: 6px 0;
  border-bottom: 1px solid #f0f0f0;
  transition: 0.2s;
  cursor: pointer;
}
.popular-item:hover {
  color: var(--primary);
}
.popular-rank {
  font-weight: 700;
  color: var(--primary);
  min-width: 20px;
}
.popular-title {
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #333;
}
</style>
</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include>

<main>
  <div class="layout">
    <!-- 왼쪽 본문 -->
    <div>
      <!-- ✅ 검색창 -->
		<div class="search-bar">
		  <i class="fa-solid fa-magnifying-glass"></i>
		  <input type="text" placeholder="게시글 검색...">
		</div>


      <!-- ✅ 이런 글은 어때요 -->
      <div class="recommend-section">
        <h2>이런 글은 어때요? 👀</h2>
        <div class="recommend-cards">
          <div class="recommend-card"><div class="title">신입 개발자 포트폴리오 정리 꿀팁</div><div class="meta">조회 1,204</div></div>
          <div class="recommend-card"><div class="title">요즘 뜨는 자격증 TOP 3</div><div class="meta">조회 893</div></div>
          <div class="recommend-card"><div class="title">개발자 면접에서 자주 나오는 질문 모음</div><div class="meta">조회 2,013</div></div>
          <div class="recommend-card"><div class="title">경력직 이직 면접 질문 모음</div><div class="meta">조회 7,017</div></div>
        </div>
      </div>

      <!-- ✅ 카테고리 탭 + 글쓰기 버튼 -->
      <div class="category-topbar">
        <div class="category-tabs">
          <div class="category-tab active">전체</div>
          <div class="category-tab">예체능</div>
          <div class="category-tab">IT</div>
          <div class="category-tab">외국어</div>
        </div>
        <a href="${pageContext.request.contextPath}/board/comunityWrite" class="write-btn">글쓰기 ✏️</a>
      </div>

      <!-- 게시글 리스트 -->
      <div class="board-list">
        <c:choose>
          <c:when test="${not empty communityList}">
            <c:forEach var="communityList" items="${communityList}">
              <div class="card">
                <div class="title">${communityList.title}</div>
                <div class="author">
                  <c:choose>
                    <c:when test="${not empty community_content.author}">
                      ${community_content.author}
                    </c:when>
                    <c:otherwise>&nbsp;</c:otherwise>
                  </c:choose>
                </div>
                <div class="meta">
                  <span><fmt:formatDate value="${community_content.createDate}" pattern="MM-dd" /></span>
                  <span>조회 ${community_content.views}</span>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="no-data">등록된 게시글이 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- ✅ 페이지네이션 -->
      <div class="pagination">
        <a href="#">이전</a>
        <a href="#" class="active">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">다음</a>
      </div>
    </div>

    <!-- ✅ 오른쪽 인기글 -->
    <div class="popular-section">
      <h3>🔥 인기글 TOP 10</h3>
      <div class="popular-list">
        <div class="popular-item"><span class="popular-rank">1</span><span class="popular-title">요즘 면접에서 이런 질문 나와요</span></div>
        <div class="popular-item"><span class="popular-rank">2</span><span class="popular-title">개발자 연봉 협상 꿀팁</span></div>
        <div class="popular-item"><span class="popular-rank">3</span><span class="popular-title">코딩 테스트 대비 공부법</span></div>
        <div class="popular-item"><span class="popular-rank">4</span><span class="popular-title">회사에서 살아남는 법</span></div>
        <div class="popular-item"><span class="popular-rank">5</span><span class="popular-title">포트폴리오 잘 만드는 법</span></div>
        <div class="popular-item"><span class="popular-rank">6</span><span class="popular-title">자바스크립트 기초 정리</span></div>
        <div class="popular-item"><span class="popular-rank">7</span><span class="popular-title">취업 준비, 이건 꼭 하세요</span></div>
        <div class="popular-item"><span class="popular-rank">8</span><span class="popular-title">면접 질문 리스트 공개</span></div>
        <div class="popular-item"><span class="popular-rank">9</span><span class="popular-title">이직 준비 체크리스트</span></div>
        <div class="popular-item"><span class="popular-rank">10</span><span class="popular-title">신입이 회사에서 배운 점</span></div>
      </div>
    </div>
  </div>
</main>
</body>
</html>
