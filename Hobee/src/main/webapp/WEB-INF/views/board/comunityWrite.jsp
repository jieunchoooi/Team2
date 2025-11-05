<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>커뮤니티 글쓰기 - Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --gray: #888;
  --text: #222;
  --bg: #f9fafc;
  --border: #e5e8eb;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Pretendard', sans-serif;
}

body {
  background: var(--bg);
  color: var(--text);
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

/* -------------------- 헤더 -------------------- */
header {
  background: #fff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  padding: 16px 40px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: relative;
  z-index: 100;
}
header h1 {
  color: var(--primary);
  font-size: 1.5rem;
  font-weight: 700;
  cursor: pointer;
}
nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
}
.nav-left, .nav-right {
  display: flex;
  align-items: center;
  gap: 20px;
}
nav a {
  text-decoration: none;
  color: #333;
  font-weight: 500;
  padding: 6px 10px;
  border-radius: 10px;
  transition: background 0.2s;
}
nav a:hover {
  background: var(--hover-bg);
  color: var(--primary);
}
.auth-link {
  font-size: 0.85rem;
  color: var(--gray);
  padding: 4px 8px;
  border-radius: 8px;
  transition: color 0.2s, background 0.2s;
}
.auth-link:hover {
  color: var(--primary);
  background: var(--hover-bg);
}

/* -------------------- 메인 -------------------- */
main {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px 0;
}

/* 글쓰기 카드 */
.write-container {
  background: #fff;
  width: 70%;
  max-width: 1000px;
  height: 80vh;
  border-radius: 20px;
  box-shadow: 0 4px 14px rgba(0,0,0,0.08);
  display: flex;
  flex-direction: column;
  padding: 30px 40px;
}

/* 헤더 */
.write-header {
  text-align: center;
  margin-bottom: 15px;
}
.write-header h2 {
  color: var(--primary);
  font-size: 1.4rem;
  font-weight: 700;
}

/* 폼 */
.write-form {
  display: flex;
  flex-direction: column;
  flex: 1;
}

/* 카테고리+말머리+제목 */
.top-row {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
}
select, input[type="text"], textarea {
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 0.95rem;
  outline: none;
  transition: border-color 0.2s;
}
select:focus, input:focus, textarea:focus {
  border-color: var(--primary);
}

/* 비율 조정 */
#category { flex: 1.2; }
#tag { flex: 1.2; }
#title { flex: 5; }

/* 이미지 업로드 */
.file-input {
  margin: 8px 0 12px 0;
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 0.9rem;
}
.file-input input { flex: 1; }

/* 본문 */
.textarea-wrap {
  flex: 1;
  position: relative;
}
textarea {
  width: 100%;
  height: 100%;
  resize: none;
  overflow-y: auto;
  line-height: 1.6;
}

/* 버튼 */
.write-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 12px;
}
.btn {
  background: var(--primary);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 10px 22px;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.2s;
}
.btn:hover { background: #1f65e0; }
.btn.cancel { background: #ccc; }
.btn.cancel:hover { background: #bbb; }
.btn.save { background: #ffd43b; color: #333; }
.btn.save:hover { background: #ffca2c; }

/* -------------------- 푸터 -------------------- */
footer {
  background: #fff;
  text-align: center;
  padding: 20px;
  font-size: 0.9rem;
  color: #777;
  border-radius: 20px 20px 0 0;
  box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
  margin-top: auto;
}

/* 반응형 */
@media (max-width: 768px) {
  .write-container {
    width: 90%;
    padding: 25px;
    height: auto;
  }
  .top-row {
    flex-direction: column;
  }
  #title {flex: none;}
}
</style>
</head>
<body>

<header>
  <h1 onclick="location.href='index.html'">Hobee</h1>
  <nav>
    <div class="nav-left">
      <a href="index.html">홈</a>
      <a href="#">강의</a>
      <a href="community.html" style="color: var(--primary); font-weight:600;">커뮤니티</a>
    </div>
    <div class="nav-right">
      <a href="#" class="auth-link">로그인</a>
      <a href="#" class="auth-link">회원가입</a>
    </div>
  </nav>
</header>

<main>
  <div class="write-container">
    <div class="write-header">
      <h2>✏️ 커뮤니티 글쓰기</h2>
    </div>
	
<%-- 	<form action="${pageContext.request.contextPath}/board/writePro" id="appForm" class="appForm" method="post" onsubmit="submitPost(event)"> --%>
    <form action="${pageContext.request.contextPath}/board/writePro" id="appForm" class="appForm" method="post">
      <div class="top-row">
        <select id="category" required>
          <option value="">카테고리</option>
          <option>예체능</option>
          <option>IT</option>
          <option>외국어</option>
        </select>

        <select id="tag" required>
          <option value="">말머리</option>
          <option>후기</option>
          <option>질문</option>
          <option>정보공유</option>
          <option>잡담</option>
        </select>

        <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required />
      </div>

      <div class="file-input">
        <label for="image">📎 이미지 첨부</label>
        <input type="file" id="image" accept="image/*" />
      </div>

      <div class="textarea-wrap">
        <textarea id="content" placeholder="내용을 입력하세요" name="content" required></textarea>
      </div>

      <div class="write-buttons">
        <button type="button" class="btn save" onclick="saveDraft()">임시저장</button>
        <button type="button" class="btn cancel" onclick="cancelPost()">취소</button>
        <button type="submit" class="btn">등록</button>
      </div>
    </form>
  </div>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
// const formFields = ["category", "tag", "title", "content"];

// window.addEventListener("DOMContentLoaded", () => {
//   formFields.forEach(id => {
//     const saved = localStorage.getItem("draft_" + id);
//     if (saved) document.getElementById(id).value = saved;
//   });
// });

// function saveDraft() {
//   formFields.forEach(id => {
//     const value = document.getElementById(id).value.trim();
//     localStorage.setItem("draft_" + id, value);
//   });
//   alert("임시 저장되었습니다! 브라우저를 닫아도 복원됩니다.");
// }

// function submitPost(event) {
//   event.preventDefault();
//   const title = document.getElementById('title').value.trim();
//   const content = document.getElementById('content').value.trim();
//   const category = document.getElementById('category').value;
//   const tag = document.getElementById('tag').value;

//   if (!title || !content || !category || !tag) {
//     alert('모든 항목을 입력해주세요!');
//     return;
//   }

//   formFields.forEach(id => localStorage.removeItem("draft_" + id));
//   alert('게시글이 등록되었습니다!');
//   location.href = "community.html";
// }

// function cancelPost() {
//   if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
//     location.href = "community.html";
//   }
// }
</script>

</body>
</html>
