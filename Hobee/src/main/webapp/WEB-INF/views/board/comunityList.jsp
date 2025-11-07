<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hobee 커뮤니티</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --gray: #888;
  --text: #222;
  --bg: #f9fafc;
}

* {margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif;}

body {
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* main layout */
main {
  flex: 1;
  display: flex;
  justify-content: center;
  padding: 30px 15px;
  gap: 30px;
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
}

/* 게시판 본문 */
.board-section { flex: 3; }
.category-tabs {
  display: flex;
  gap: 8px;
  margin-bottom: 18px;
}
.category-tab {
  cursor: pointer;
  padding: 6px 14px;
  border-radius: 20px;
  background: #f2f4f8;
  color: #333;
  font-weight: 500;
  font-size: 0.9rem;
  transition: all 0.2s;
}
.category-tab.active {background: var(--primary); color: #fff;}

/* 게시글 목록 */
.board-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}
.search-box input {
  padding: 8px 14px;
  width: 220px;
  border: 1px solid #ccc;
  border-radius: 20px;
  outline: none;
  font-size: 0.9rem;
}
.search-box input:focus {border-color: var(--primary);}

.write-btn {
  background: var(--primary);
  color: white;
  border: none;
  border-radius: 20px;
  padding: 8px 16px;
  cursor: pointer;
  font-size: 0.9rem;
  font-weight: 600;
  text-decoration: none; 
}
.write-btn:hover {background: #1f65e0;}

/* 테이블 */
table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.88rem;
}
thead {
  background: #f8f9fb;
  border-bottom: 1px solid #ddd;
}
th, td {
  text-align: left;
  padding: 10px 6px;
}
tbody tr {
  border-bottom: 1px solid #eee;
  transition: background 0.15s;
  cursor: pointer;
}
tbody tr:hover {background: var(--hover-bg);}
.tag {
  display: inline-block;
  font-size: 0.7rem;
  padding: 2px 6px;
  border-radius: 5px;
  color: white;
  margin-right: 6px;
}
.tag.후기 {background: #ff6b6b;}
.tag.질문 {background: #f2b63d;}
.tag.정보공유 {background: #36b37e;}
.tag.잡담 {background: #868e96;}

/* 페이지네이션 */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  margin-top: 15px;
}
.pagination button {
  border: none;
  background: var(--primary);
  color: #fff;
  padding: 6px 12px;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.2s;
}
.pagination button:disabled {
  background: #ccc;
  cursor: not-allowed;
}
.pagination span {
  font-size: 0.9rem;
  color: #333;
}

/* 사이드바 */
.sidebar {
  flex: 1;
  background: #fff;
  border-radius: 12px;
  padding: 18px 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  height: fit-content;
}
.sidebar h3 {
  font-size: 1rem;
  color: var(--primary);
  margin-bottom: 12px;
}
.popular-list {
  list-style: none;
}
.popular-list li {
  font-size: 0.85rem;
  margin-bottom: 10px;
  line-height: 1.4;
}
.popular-list li a {
  text-decoration: none;
  color: #333;
}
.popular-list li a:hover {
  color: var(--primary);
}

/* footer */
footer {
  background: #fff;
  text-align: center;
  padding: 15px;
  font-size: 0.8rem;
  color: #777;
  border-radius: 15px 15px 0 0;
  box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
  margin-top: 20px;
}
</style>
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<main>
  <section class="board-section">
    <div class="category-tabs">
      <div class="category-tab active" onclick="changeCategory('예체능')">예체능</div>
      <div class="category-tab" onclick="changeCategory('IT')">IT</div>
      <div class="category-tab" onclick="changeCategory('외국어')">외국어</div>
    </div>

    <div class="board-controls">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="게시글 검색...">
      </div>
      <a href="${pageContext.request.contextPath}/board/comunityWrite" class="write-btn">글쓰기</a>
    </div>

    <table>
      <thead>
        <tr>
<!--           <th style="width:12%">말머리</th> -->
          <th style="width:42%">제목</th>
          <th style="width:12%">작성자</th>
<!--           <th style="width:12%">날짜</th> -->
<!--           <th style="width:10%">조회</th> -->
<!--           <th style="width:10%">좋아요</th> -->
        </tr>
      </thead>
<!--       <tbody id="boardList"></tbody> -->
	   <tbody id="boardList">
        <c:choose>
          <c:when test="${not empty communityList}">
            <c:forEach var="communityList" items="${communityList}">
<%--               <tr onclick="viewPost(${community_content.id})"> --%>
				<tr>
<%--                 <td><span class="tag ${community_content.tag}">${community_content.tag}</span></td> --%>
                <td>${communityList.title}</td>
                <td>${community_content.author}</td>
<%--                 <td><fmt:formatDate value="${community_content.createDate}" pattern="MM-dd" /></td> --%>
<%--                 <td>${community_content.views}</td> --%>
<%--                 <td><span style="color:#f66;">❤</span> ${community_content.likes}</td> --%>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="6" class="no-data">등록된 게시글이 없습니다.</td>
            </tr>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <div class="pagination">
      <button id="prevBtn" onclick="changePage(-1)">← 이전</button>
      <span id="pageInfo">1 / 1</span>
      <button id="nextBtn" onclick="changePage(1)">다음 →</button>
    </div>

  </section>

  <aside class="sidebar">
    <h3>오늘의 인기글 🔥</h3>
    <ul class="popular-list" id="popularList"></ul>
  </aside>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

</body>
</html>
