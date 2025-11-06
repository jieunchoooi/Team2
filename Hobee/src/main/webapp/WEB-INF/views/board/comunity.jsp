<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!--       <button class="write-btn" onclick="createPost()">글쓰기</button> -->
      <a href="${pageContext.request.contextPath}/board/comunityWrite" class="write-btn">글쓰기</a>
    </div>

    <table>
      <thead>
        <tr>
          <th style="width:12%">말머리</th>
          <th style="width:42%">제목</th>
          <th style="width:12%">작성자</th>
          <th style="width:12%">날짜</th>
          <th style="width:10%">조회</th>
          <th style="width:10%">좋아요</th>
        </tr>
      </thead>
      <tbody id="boardList"></tbody>
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

<script>
// 로그인 상태 (임시)
// let isLoggedIn = true;

// 게시글 데이터 (10개)
// const posts = [
//   {category: "예체능", tag: "후기", title: "드로잉 클래스 완전 강추!", author: "아트초보", date: "10-28", views: 132, likes: 12},
//   {category: "예체능", tag: "질문", title: "아이패드 브러시 추천 좀 해주세요!", author: "홍길동", date: "10-27", views: 95, likes: 8},
//   {category: "IT", tag: "정보공유", title: "입문자 추천 강의 모음", author: "코딩러버", date: "10-25", views: 184, likes: 23},
//   {category: "IT", tag: "잡담", title: "코딩하다 멘붕왔을 때 극복법ㅋㅋ", author: "이자바", date: "10-24", views: 211, likes: 17},
//   {category: "외국어", tag: "후기", title: "영어 회화 수업 후기 공유!", author: "Jane", date: "10-26", views: 77, likes: 6},
//   {category: "외국어", tag: "질문", title: "스페인어 공부법 조언 부탁드려요!", author: "Carlos", date: "10-20", views: 42, likes: 4},
//   {category: "예체능", tag: "정보공유", title: "수채화 물감 브랜드 비교", author: "수채사랑", date: "10-22", views: 110, likes: 10},
//   {category: "IT", tag: "후기", title: "스프링 부트 처음 배우기 후기", author: "박개발", date: "10-21", views: 200, likes: 15},
//   {category: "외국어", tag: "잡담", title: "토익 공부 진짜 하기 싫어요ㅠㅠ", author: "스터디러", date: "10-19", views: 66, likes: 5},
//   {category: "IT", tag: "질문", title: "SQL 조인 잘 이해가 안돼요", author: "DB초보", date: "10-18", views: 120, likes: 9},
// ];

// let currentCategory = "예체능";
// let currentPage = 1;
// const postsPerPage = 10;

// function renderBoard() {
//   const tbody = document.getElementById("boardList");
//   const filtered = posts.filter(p => p.category === currentCategory);
//   const totalPages = Math.ceil(filtered.length / postsPerPage);
//   const start = (currentPage - 1) * postsPerPage;
//   const end = start + postsPerPage;
//   const currentPosts = filtered.slice(start, end);

//   tbody.innerHTML = currentPosts.map((p, i) => `
//     <tr onclick="viewPost(${i})">
//       <td><span class="tag ${p.tag}">${p.tag}</span></td>
//       <td>${p.title}</td>
//       <td>${p.author}</td>
//       <td>${p.date}</td>
//       <td>${p.views}</td>
//       <td><span style="color:#f66;">❤</span> ${p.likes}</td>
//     </tr>
//   `).join('');

//   // 페이지 표시
//   document.getElementById("pageInfo").textContent = `${currentPage} / ${totalPages}`;
//   document.getElementById("prevBtn").disabled = currentPage === 1;
//   document.getElementById("nextBtn").disabled = currentPage === totalPages;
// }

// function renderPopular() {
//   const sidebar = document.getElementById("popularList");
//   const popular = posts
//     .filter(p => p.category === currentCategory)
//     .sort((a, b) => b.views - a.views)
//     .slice(0, 5);
//   sidebar.innerHTML = popular.map(p => `<li><a href="#">[${p.tag}] ${p.title}</a></li>`).join('');
// }

// function changeCategory(category) {
//   document.querySelectorAll('.category-tab').forEach(t => t.classList.remove('active'));
//   event.target.classList.add('active');
//   currentCategory = category;
//   currentPage = 1;
//   renderBoard();
//   renderPopular();
// }

// function changePage(direction) {
//   currentPage += direction;
//   renderBoard();
// }

function createPost() {
//   if (!isLoggedIn) {
//     alert("로그인한 사용자만 글을 작성할 수 있습니다.");
//     location.href = "login.html";
//     return;
//   }
  location.href = "communityWrite.jsp";
}

// function viewPost(index) {
//   alert(`게시글 상세 페이지로 이동: ${posts[index].title}`);
// }

// document.addEventListener("DOMContentLoaded", () => {
//   renderBoard();
//   renderPopular();
// });
</script>

</body>
</html>
